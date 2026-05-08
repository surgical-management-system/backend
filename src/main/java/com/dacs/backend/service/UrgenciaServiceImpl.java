package com.dacs.backend.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dacs.backend.dto.PaginacionDto;
import com.dacs.backend.dto.UrgenciaDTO;
import com.dacs.backend.mapper.UrgenciaMapper;
import com.dacs.backend.model.entity.EstadoUrgencia;
import com.dacs.backend.model.entity.Urgencia;
import com.dacs.backend.model.repository.UrgenciaRepository;
import com.dacs.backend.service.helper.CirugiaSecurityHelper;
import com.dacs.backend.service.helper.ProcedimientoSpecificationBuilder;
import com.dacs.backend.service.helper.ProcedimientoSortBuilder;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UrgenciaServiceImpl implements UrgenciaService {

    private final UrgenciaRepository urgenciaRepository;
    private final UrgenciaMapper urgenciaMapper;
    private final TurnoService turnoService;
    private final CirugiaSecurityHelper securityHelper;
    private final ProcedimientoSpecificationBuilder specificationBuilder;
    private final ProcedimientoSortBuilder sortBuilder;

    @Override
    public Optional<Urgencia> getById(Long id) {
        return urgenciaRepository.findById(id);
    }

    @Override
    @Transactional
    public UrgenciaDTO.Response createUrgencia(UrgenciaDTO.Create request) {
        Urgencia entity = urgenciaMapper.toEntity(request);
        Urgencia saved = urgenciaRepository.save(entity);
        if (saved.getQuirofano() != null && saved.getServicio() != null && saved.getFechaHoraInicio() != null
                && saved.getServicio().getDuracionMinutos() != null) {
            turnoService.reservarTurnosParaUrgencia(
                    saved.getId(),
                    saved.getQuirofano().getId(),
                    saved.getFechaHoraInicio(),
                    saved.getFechaHoraInicio().plusMinutes(saved.getServicio().getDuracionMinutos()));
        }
        return urgenciaMapper.toResponseDto(saved);
    }

    @Override
    public Urgencia save(Urgencia entity) {
        return urgenciaRepository.save(entity);
    }

    @Override
    public Boolean existById(Long id) {
        return urgenciaRepository.existsById(id);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        Urgencia urgencia = urgenciaRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Urgencia no encontrada id=" + id));
        urgencia.setEstado(urgencia.getEstado().cancelar());
        urgenciaRepository.save(urgencia);
        turnoService.borrarTurnosPorUrgencia(id);
    }

    @Override
    public UrgenciaDTO.Response updateUrgencia(Long id, UrgenciaDTO.Update requestDto) {
        if (!urgenciaRepository.existsById(id)) {
            throw new IllegalArgumentException("Urgencia no encontrada id=" + id);
        }

        Urgencia entity = urgenciaMapper.toEntity(requestDto);
        entity.setId(id);
        return urgenciaMapper.toResponseDto(urgenciaRepository.save(entity));
    }

    @Override
    @Transactional
    public UrgenciaDTO.Response inicializarUrgencia(long urgenciaId) {
        Urgencia urgencia = urgenciaRepository.findById(urgenciaId)
                .orElseThrow(() -> new IllegalArgumentException("Urgencia no encontrada id=" + urgenciaId));

        urgencia.setEstado(urgencia.getEstado().inicializar());
        Urgencia updated = urgenciaRepository.save(urgencia);
        return urgenciaMapper.toResponseDto(updated);
    }

    @Override
    @Transactional
    public UrgenciaDTO.Response finalizarUrgencia(long urgenciaId) {
        Urgencia urgencia = urgenciaRepository.findById(urgenciaId)
                .orElseThrow(() -> new IllegalArgumentException("Urgencia no encontrada id=" + urgenciaId));

        urgencia.setEstado(urgencia.getEstado().finalizar());
        Urgencia updated = urgenciaRepository.save(urgencia);
        return urgenciaMapper.toResponseDto(updated);
    }

    @Override
    public List<Urgencia> getAll() {
        return urgenciaRepository.findAll();
    }

    @Override
    public PaginacionDto<UrgenciaDTO.Response> getUrgencias(int pagina, int tamano, LocalDate fechaInicio,
            LocalDate fechaFin, EstadoUrgencia estado, String search, String sort, String order) {
        var sortSpec = sortBuilder.build(sort, order, "nivelUrgencia");
        Pageable pageable = PageRequest.of(pagina, tamano, sortSpec);

        Specification<Urgencia> specification = specificationBuilder.build(fechaInicio, fechaFin, estado, search,
            "nivelUrgencia");
        if (securityHelper.shouldFilterToAssignedSurgeries()) {
            String username = securityHelper.getCurrentUsername();
            specification = specification.and(specificationBuilder.assignedToMedicalStaffUrgencia(username));
        }

        Page<Urgencia> page = urgenciaRepository.findAll(specification, pageable);

        List<Urgencia> entidades = page.getContent();
        List<UrgenciaDTO.Response> dtos = entidades.stream()
                .map(urgenciaMapper::toResponseDto)
                .collect(Collectors.toList());

        PaginacionDto.Response<UrgenciaDTO.Response> response = new PaginacionDto.Response<>();
        response.setContenido(dtos);
        response.setPagina(page.getNumber());
        response.setTamaño(page.getSize());
        response.setTotalElementos(page.getTotalElements());
        response.setTotalPaginas(page.getTotalPages());
        return response;
    }

    @Override
    public Long countUrgenciasHoy() {
        LocalDateTime startOfDay = LocalDate.now().atStartOfDay();
        LocalDateTime endOfDay = LocalDate.now().atTime(23, 59, 59);
        return urgenciaRepository.countByEstadoAndFechaHoraInicioBetween(EstadoUrgencia.PROGRAMADA, startOfDay, endOfDay);
    }

    @Override
    public Long countUrgenciasEstaSemana() {
        LocalDate today = LocalDate.now();
        LocalDate startOfWeek = today.minusDays(today.getDayOfWeek().getValue() - 1);
        LocalDate endOfWeek = startOfWeek.plusDays(6);

        LocalDateTime startOfWeekDateTime = startOfWeek.atStartOfDay();
        LocalDateTime endOfWeekDateTime = endOfWeek.atTime(23, 59, 59);

        return urgenciaRepository.countByEstadoAndFechaHoraInicioBetween(EstadoUrgencia.PROGRAMADA, startOfWeekDateTime,
                endOfWeekDateTime);
    }
}
