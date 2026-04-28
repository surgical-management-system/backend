package com.dacs.backend.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dacs.backend.dto.CirugiaDTO;
import com.dacs.backend.dto.PacienteDTO;
import com.dacs.backend.dto.PaginacionDto;
import com.dacs.backend.dto.ServicioDto;
import com.dacs.backend.mapper.CirugiaMapper;
import com.dacs.backend.model.entity.Cirugia;
import com.dacs.backend.model.entity.EquipoMedico;
import com.dacs.backend.model.entity.EstadoCirugia;
import com.dacs.backend.model.repository.CirugiaRepository;
import com.dacs.backend.model.repository.PacienteRepository;
import com.dacs.backend.model.repository.ServicioRepository;

import jakarta.persistence.criteria.JoinType;
import jakarta.persistence.criteria.Subquery;

@Service
public class CirugiaServiceImpl implements CirugiaService {

    @Autowired
    CirugiaRepository cirugiaRepository;
    @Autowired
    private CirugiaMapper cirugiaMapper;

    @Autowired
    private PacienteRepository pacienteRepository;

    @Autowired
    private ServicioRepository servicioRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private TurnoService turnoService;

    @Override
    public Optional<Cirugia> getById(Long id) {
        return cirugiaRepository.findById(id);
    }

    @Override
    @Transactional
    public CirugiaDTO.Response createCirugia(CirugiaDTO.Create request) {
        // mapear request -> entidad (resuelve relaciones dentro del mapper)
        Long servicioId = request.getServicioId();
        Long quirofanoId = request.getQuirofanoId();
        LocalDateTime fechaHoraInicio = request.getFechaHoraInicio();
        LocalDateTime fechaHoraFin = fechaHoraInicio.plusMinutes(servicioRepository.findById(servicioId).get().getDuracionMinutos()); // suposición
        
      //  System.out.println("FechaHoraInicio: " + fechaHoraFin);
        System.out.println("FechaHoraFin: " + fechaHoraFin);
        System.out.println("QuirofanoId: " + quirofanoId);
        System.out.println("fechaHoraInicioss: " + fechaHoraInicio);

        Cirugia entity = cirugiaMapper.toEntity(request);
        Cirugia saved = cirugiaRepository.save(entity);

        turnoService.reservarTurnosParaCirugia(saved.getId(), quirofanoId, fechaHoraInicio, fechaHoraFin);
        
        // mapear entidad -> response DTO
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
        // Soft delete: cambiar estado a CANCELADA
        cirugia.setEstado(EstadoCirugia.CANCELADA);
        cirugiaRepository.save(cirugia);
        turnoService.borrarTurno(id);
    }

    @Override
    public Cirugia getBy(Map<String, Object> filter) {
        throw new UnsupportedOperationException();
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
        return cirugiaMapper.toResponseDto(cirugiaRepository.save(entity));
    }

    @Override
    public List<Cirugia> getAll() {
        return cirugiaRepository.findAll();
    }

    @Override
    public CirugiaDTO.Response finalizarCirugia(long cirugiaId) {
        Cirugia cirugia = cirugiaRepository.findById(cirugiaId)
                .orElseThrow(() -> new IllegalArgumentException("Cirugia no encontrada id=" + cirugiaId));
        //cirugia.setFechaHoraFin(LocalDateTime.now());   AGREGAR CAMPO EN ENTITY SI ES NECESARIO
        cirugia.setEstado(EstadoCirugia.FINALIZADA);
        Cirugia updated = cirugiaRepository.save(cirugia);
        return cirugiaMapper.toResponseDto(updated);
    }

    @Override
    @Transactional
    public CirugiaDTO.Response inicializarCirugia(long cirugiaId) {
        Cirugia cirugia = cirugiaRepository.findById(cirugiaId)
                .orElseThrow(() -> new IllegalArgumentException("Cirugia no encontrada id=" + cirugiaId));

        if (cirugia.getEstado() == EstadoCirugia.FINALIZADA) {
            throw new IllegalArgumentException("No se puede inicializar una cirugía finalizada");
        }
        if (cirugia.getEstado() == EstadoCirugia.CANCELADA) {
            throw new IllegalArgumentException("No se puede inicializar una cirugía cancelada");
        }

        cirugia.setEstado(EstadoCirugia.EN_CURSO);
        Cirugia updated = cirugiaRepository.save(cirugia);
        return cirugiaMapper.toResponseDto(updated);
    }


    @Override
    public PaginacionDto.Response<CirugiaDTO.Response> getCirugias(int pagina, int tamaño, LocalDate fechaInicio,
            LocalDate fechaFin, EstadoCirugia estado, String search, String sort, String order) {
        Sort sortSpec = buildSort(sort, order);
        Pageable pageable = PageRequest.of(pagina, tamaño, sortSpec);

        Specification<Cirugia> specification = buildSpecification(fechaInicio, fechaFin, estado, search);
        if (shouldFilterToAssignedSurgeries()) {
            specification = specification.and(assignedToCurrentMedicalStaff());
        }

        Page<Cirugia> p = cirugiaRepository.findAll(specification, pageable);

        List<Cirugia> entidades = p.getContent();
        List<CirugiaDTO.Response> dtos = entidades.stream()
                .map(e -> modelMapper.map(e, CirugiaDTO.Response.class))
                .collect(Collectors.toList());

        mapearPacientes(entidades, dtos);
        mapearServicios(entidades, dtos);
        PaginacionDto.Response<CirugiaDTO.Response> resp = new PaginacionDto.Response<CirugiaDTO.Response>();
        resp.setContenido(dtos);
        resp.setPagina(p.getNumber());
        resp.setTamaño(p.getSize());
        resp.setTotalElementos(p.getTotalElements());
        resp.setTotalPaginas(p.getTotalPages());
        return resp;
    }

    private Specification<Cirugia> buildSpecification(LocalDate fechaInicio, LocalDate fechaFin, EstadoCirugia estado,
            String search) {
        return (root, query, cb) -> {
            query.distinct(true);

            List<jakarta.persistence.criteria.Predicate> predicates = new java.util.ArrayList<>();

            if (fechaInicio != null) {
                predicates.add(cb.greaterThanOrEqualTo(root.get("fechaHoraInicio"), fechaInicio.atStartOfDay()));
            }
            if (fechaFin != null) {
                predicates.add(cb.lessThanOrEqualTo(root.get("fechaHoraInicio"), fechaFin.atTime(23, 59, 59)));
            }
            if (estado != null) {
                predicates.add(cb.equal(root.get("estado"), estado));
            }

            if (search != null && !search.isBlank()) {
                String likePattern = "%" + search.trim().toLowerCase() + "%";

                var pacienteJoin = root.join("paciente", JoinType.LEFT);
                var servicioJoin = root.join("servicio", JoinType.LEFT);
                var quirofanoJoin = root.join("quirofano", JoinType.LEFT);

                jakarta.persistence.criteria.Predicate searchPredicate = cb.or(
                        cb.like(cb.lower(cb.coalesce(pacienteJoin.get("nombre"), "")), likePattern),
                        cb.like(cb.lower(cb.coalesce(pacienteJoin.get("apellido"), "")), likePattern),
                        cb.like(cb.lower(cb.coalesce(pacienteJoin.get("dni"), "")), likePattern),
                        cb.like(cb.lower(cb.coalesce(servicioJoin.get("nombre"), "")), likePattern),
                        cb.like(cb.lower(cb.coalesce(root.get("estado").as(String.class), "")), likePattern),
                        cb.like(cb.lower(cb.coalesce(root.get("tipo"), "")), likePattern),
                        cb.like(cb.lower(cb.coalesce(root.get("prioridad"), "")), likePattern),
                        cb.like(cb.lower(cb.coalesce(quirofanoJoin.get("nombre"), "")), likePattern));
                predicates.add(searchPredicate);
            }

            return cb.and(predicates.toArray(new jakarta.persistence.criteria.Predicate[0]));
        };
    }

    private Specification<Cirugia> assignedToCurrentMedicalStaff() {
        String username = currentUsername();
        if (username == null || username.isBlank()) {
            return (root, query, cb) -> cb.conjunction();
        }

        String normalizedUsername = username.toLowerCase();
        return (root, query, cb) -> {
            Subquery<Long> subquery = query.subquery(Long.class);
            var equipoRoot = subquery.from(EquipoMedico.class);
            var personalJoin = equipoRoot.join("personal");

            subquery.select(cb.literal(1L));
            subquery.where(
                    cb.equal(equipoRoot.get("cirugia"), root),
                    cb.equal(cb.lower(personalJoin.get("legajo")), normalizedUsername));

            return cb.exists(subquery);
        };
    }

    private boolean shouldFilterToAssignedSurgeries() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            return false;
        }

        boolean isAdmin = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .anyMatch("ROLE_admin"::equals);
        if (isAdmin) {
            return false;
        }

        return authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .anyMatch("ROLE_personal_medico"::equals);
    }

    private String currentUsername() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) {
            return null;
        }

        String username = authentication.getName();
        if (username != null && !username.isBlank()) {
            return username;
        }

        Object principal = authentication.getPrincipal();
        if (principal instanceof org.springframework.security.oauth2.jwt.Jwt jwt) {
            return jwt.getClaimAsString("preferred_username");
        }

        return null;
    }

    private Sort buildSort(String sort, String order) {
        Sort.Direction direction = "desc".equalsIgnoreCase(order) ? Sort.Direction.DESC : Sort.Direction.ASC;
        String normalizedSort = sort == null ? "fechaHoraInicio" : sort.trim();

        return switch (normalizedSort) {
            case "paciente" -> Sort.by(direction, "paciente.apellido").and(Sort.by(direction, "paciente.nombre"));
            case "servicio" -> Sort.by(direction, "servicio.nombre");
            case "estado" -> Sort.by(direction, "estado");
            case "tipo" -> Sort.by(direction, "tipo");
            case "prioridad" -> Sort.by(direction, "prioridad");
            case "quirofano" -> Sort.by(direction, "quirofano.nombre");
            case "fechaHoraInicio", "fecha", "hora" -> Sort.by(direction, "fechaHoraInicio").and(Sort.by(direction, "id"));
            default -> Sort.by(direction, "fechaHoraInicio").and(Sort.by(direction, "id"));
        };
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
    public List<ServicioDto> getServicios( int pagina, int tamaño) {
        Pageable pageable = PageRequest.of(pagina, tamaño);
        return servicioRepository.findAll(pageable)
            .stream()
            .map(s -> modelMapper.map(s, ServicioDto.class))
            .collect(Collectors.toList());
    }

    @Override
    public Long countCirugiasRestantesHoy(){
        LocalDateTime startOfDay = LocalDate.now().atStartOfDay();
        LocalDateTime endOfDay = LocalDate.now().atTime(23, 59, 59);
        return cirugiaRepository.countByEstadoAndFechaHoraInicioBetween(EstadoCirugia.PROGRAMADA, startOfDay, endOfDay);
    }

    @Override
    public Long countCirugiasEstaSemana(){
        LocalDate today = LocalDate.now();
        LocalDate startOfWeek = today.minusDays(today.getDayOfWeek().getValue() - 1); // Lunes
        LocalDate endOfWeek = startOfWeek.plusDays(6); // Domingo

        LocalDateTime startOfWeekDateTime = startOfWeek.atStartOfDay();
        LocalDateTime endOfWeekDateTime = endOfWeek.atTime(23, 59, 59);

        return cirugiaRepository.countByEstadoAndFechaHoraInicioBetween(EstadoCirugia.PROGRAMADA, startOfWeekDateTime, endOfWeekDateTime);
    }
}