package com.dacs.backend.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dacs.backend.dto.CirugiaDTO;
import com.dacs.backend.dto.PacienteDTO;
import com.dacs.backend.dto.PaginacionDto;
import com.dacs.backend.dto.ServicioDto;
import com.dacs.backend.mapper.CirugiaMapper;
import com.dacs.backend.model.entity.Cirugia;
import com.dacs.backend.model.entity.EstadoCirugia;
import com.dacs.backend.model.repository.CirugiaRepository;
import com.dacs.backend.model.repository.PacienteRepository;
import com.dacs.backend.model.repository.ServicioRepository;
import com.dacs.backend.service.helper.CirugiaSecurityHelper;
import com.dacs.backend.service.helper.ProcedimientoSpecificationBuilder;
import com.dacs.backend.service.helper.ProcedimientoSortBuilder;

import lombok.RequiredArgsConstructor;

/**
 * Servicio de Cirugías aplicando principios SOLID.
 */
@Service
@RequiredArgsConstructor
public class CirugiaServiceImpl implements CirugiaService {

    private final CirugiaRepository cirugiaRepository;
    private final CirugiaMapper cirugiaMapper;
    private final PacienteRepository pacienteRepository;
    private final ServicioRepository servicioRepository;
    private final ModelMapper modelMapper;
    private final TurnoService turnoService;
    private final CirugiaSecurityHelper securityHelper;
    private final ProcedimientoSpecificationBuilder specificationBuilder;
    private final ProcedimientoSortBuilder sortBuilder;

    @Override
    public Optional<Cirugia> getById(Long id) {
        return cirugiaRepository.findById(id);
    }

    @Override
    @Transactional
    public CirugiaDTO.Response createCirugia(CirugiaDTO.Create request) {
        Long servicioId = request.getServicioId();
        Long quirofanoId = request.getQuirofanoId();
        LocalDateTime fechaHoraInicio = request.getFechaHoraInicio();
        LocalDateTime fechaHoraFin = fechaHoraInicio.plusMinutes(
                servicioRepository.findById(servicioId).orElseThrow().getDuracionMinutos());

        Cirugia entity = cirugiaMapper.toEntity(request);
        Cirugia saved = cirugiaRepository.save(entity);

        turnoService.reservarTurnosParaCirugia(saved.getId(), quirofanoId, fechaHoraInicio, fechaHoraFin);

        return cirugiaMapper.toResponseDto(saved);
    }

    @Override
    public Cirugia save(Cirugia entity) {
        return cirugiaRepository.save(entity);
    }

    @Override
    public Boolean existById(Long id) {
        return cirugiaRepository.existsById(id);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        Cirugia cirugia = cirugiaRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Cirugía no encontrada id=" + id));
        cancelarCirugiaYLiberarTurnos(cirugia);
    }

    @Override
    public CirugiaDTO.Response updateCirugia(Long id, CirugiaDTO.Update requestDto) {
        if (!cirugiaRepository.existsById(id)) {
            throw new IllegalArgumentException("Cirugia no encontrada id=" + id);
        }
        Cirugia entity = cirugiaMapper.toEntity(requestDto);
        if (entity == null) {
            throw new IllegalArgumentException("La entidad Cirugia no puede ser null");
        }
        Cirugia saved = cirugiaRepository.save(entity);
        if (saved.getEstado() == EstadoCirugia.CANCELADA) {
            turnoService.borrarTurno(saved.getId());
        }
        return cirugiaMapper.toResponseDto(saved);
    }

    @Override
    public List<Cirugia> getAll() {
        return cirugiaRepository.findAll();
    }

    @Override
    public CirugiaDTO.Response finalizarCirugia(long cirugiaId) {
        Cirugia cirugia = cirugiaRepository.findById(cirugiaId)
                .orElseThrow(() -> new IllegalArgumentException("Cirugia no encontrada id=" + cirugiaId));
        cirugia.setEstado(cirugia.getEstado().finalizar());
        Cirugia updated = cirugiaRepository.save(cirugia);
        return cirugiaMapper.toResponseDto(updated);
    }

    @Override
    @Transactional
    public CirugiaDTO.Response inicializarCirugia(long cirugiaId) {
        Cirugia cirugia = cirugiaRepository.findById(cirugiaId)
                .orElseThrow(() -> new IllegalArgumentException("Cirugia no encontrada id=" + cirugiaId));

        cirugia.setEstado(cirugia.getEstado().inicializar());
        Cirugia updated = cirugiaRepository.save(cirugia);
        return cirugiaMapper.toResponseDto(updated);
    }

    @Transactional
    protected void cancelarCirugiaYLiberarTurnos(Cirugia cirugia) {
        cirugia.setEstado(cirugia.getEstado().cancelar());
        Cirugia saved = cirugiaRepository.save(cirugia);
        turnoService.borrarTurno(saved.getId());
    }

    @Override
    public PaginacionDto.Response<CirugiaDTO.Response> getCirugias(int pagina, int tamaño, LocalDate fechaInicio,
            LocalDate fechaFin, EstadoCirugia estado, String search, String sort, String order) {
        var sortSpec = sortBuilder.build(sort, order, "prioridad");
        Pageable pageable = PageRequest.of(pagina, tamaño, sortSpec);

        Specification<Cirugia> specification = specificationBuilder.build(fechaInicio, fechaFin, estado, search,
                "prioridad");
        if (securityHelper.shouldFilterToAssignedSurgeries()) {
            String username = securityHelper.getCurrentUsername();
            specification = specification.and(specificationBuilder.assignedToMedicalStaff(username));
        }

        Page<Cirugia> page = cirugiaRepository.findAll(specification, pageable);
        List<Cirugia> entidades = page.getContent();
        List<CirugiaDTO.Response> dtos = entidades.stream()
                .map(e -> modelMapper.map(e, CirugiaDTO.Response.class))
                .collect(Collectors.toList());

        mapearPacientes(entidades, dtos);
        mapearServicios(entidades, dtos);

        PaginacionDto.Response<CirugiaDTO.Response> resp = new PaginacionDto.Response<>();
        resp.setContenido(dtos);
        resp.setPagina(page.getNumber());
        resp.setTamaño(page.getSize());
        resp.setTotalElementos(page.getTotalElements());
        resp.setTotalPaginas(page.getTotalPages());
        return resp;
    }

    private void mapearPacientes(List<Cirugia> entidades, List<CirugiaDTO.Response> dtos) {
        List<Long> pacienteIds = entidades.stream()
                .map(Cirugia::getPaciente)
                .filter(Objects::nonNull)
                .map(ent -> ent.getId())
                .filter(Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());

        if (!pacienteIds.isEmpty()) {
            List<com.dacs.backend.model.entity.Paciente> pacientes = pacienteRepository.findAllById(pacienteIds);
            Map<Long, com.dacs.backend.model.entity.Paciente> pacientesMap = pacientes.stream()
                    .collect(Collectors.toMap(com.dacs.backend.model.entity.Paciente::getId, pc -> pc));

            for (int i = 0; i < entidades.size(); i++) {
                var entidad = entidades.get(i);
                var dto = dtos.get(i);
                if (entidad.getPaciente() != null && entidad.getPaciente().getId() != null) {
                    var pacienteEntity = pacientesMap.get(entidad.getPaciente().getId());
                    if (pacienteEntity != null) {
                        var pacienteDto = modelMapper.map(pacienteEntity, PacienteDTO.Response.class);
                        dto.setPaciente(pacienteDto);
                    }
                }
            }
        }
    }

    private void mapearServicios(List<Cirugia> entidades, List<CirugiaDTO.Response> dtos) {
        List<Long> servicioIds = entidades.stream()
                .map(Cirugia::getServicio)
                .filter(Objects::nonNull)
                .map(s -> s.getId())
                .filter(Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());

        if (!servicioIds.isEmpty()) {
            List<com.dacs.backend.model.entity.Servicio> servicios = servicioRepository.findAllById(servicioIds);
            Map<Long, com.dacs.backend.model.entity.Servicio> serviciosMap = servicios.stream()
                    .collect(Collectors.toMap(com.dacs.backend.model.entity.Servicio::getId, s -> s));

            for (int i = 0; i < entidades.size(); i++) {
                var entidad = entidades.get(i);
                var dto = dtos.get(i);
                if (entidad.getServicio() != null && entidad.getServicio().getId() != null) {
                    var servicioEntity = serviciosMap.get(entidad.getServicio().getId());
                    if (servicioEntity != null) {
                        var servicioDto = modelMapper.map(servicioEntity, ServicioDto.class);
                        dto.setServicio(servicioDto);
                    }
                }
            }
        }
    }

    @Override
    public List<ServicioDto> getServicios(int pagina, int tamaño) {
        Pageable pageable = PageRequest.of(pagina, tamaño);
        return servicioRepository.findAll(pageable)
                .stream()
                .map(s -> modelMapper.map(s, ServicioDto.class))
                .collect(Collectors.toList());
    }

    @Override
    public Long countCirugiasRestantesHoy() {
        LocalDateTime startOfDay = LocalDate.now().atStartOfDay();
        LocalDateTime endOfDay = LocalDate.now().atTime(23, 59, 59);
        return cirugiaRepository.countByEstadoAndFechaHoraInicioBetween(EstadoCirugia.PROGRAMADA, startOfDay, endOfDay);
    }

    @Override
    public Long countCirugiasEstaSemana() {
        LocalDate today = LocalDate.now();
        LocalDate startOfWeek = today.minusDays(today.getDayOfWeek().getValue() - 1);
        LocalDate endOfWeek = startOfWeek.plusDays(6);

        LocalDateTime startOfWeekDateTime = startOfWeek.atStartOfDay();
        LocalDateTime endOfWeekDateTime = endOfWeek.atTime(23, 59, 59);

        return cirugiaRepository.countByEstadoAndFechaHoraInicioBetween(EstadoCirugia.PROGRAMADA, startOfWeekDateTime,
                endOfWeekDateTime);
    }
}
