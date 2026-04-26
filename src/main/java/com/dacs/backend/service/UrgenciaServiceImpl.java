package com.dacs.backend.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dacs.backend.dto.PaginacionDto;
import com.dacs.backend.dto.UrgenciaDTO;
import com.dacs.backend.mapper.UrgenciaMapper;
import com.dacs.backend.model.entity.EstadoUrgencia;
import com.dacs.backend.model.entity.Urgencia;
import com.dacs.backend.model.repository.UrgenciaRepository;

import jakarta.persistence.criteria.JoinType;

@Service
public class UrgenciaServiceImpl implements UrgenciaService {

    @Autowired
    private UrgenciaRepository urgenciaRepository;

    @Autowired
    private UrgenciaMapper urgenciaMapper;

    @Override
    public Optional<Urgencia> getById(Long id) {
        return urgenciaRepository.findById(id);
    }

    @Override
    @Transactional
    public UrgenciaDTO.Response createUrgencia(UrgenciaDTO.Create request) {
        Urgencia entity = urgenciaMapper.toEntity(request);
        Urgencia saved = urgenciaRepository.save(entity);
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
        urgencia.setEstado(EstadoUrgencia.CANCELADA);
        urgenciaRepository.save(urgencia);
    }

    @Override
    public Urgencia getBy(Map<String, Object> filter) {
        throw new UnsupportedOperationException();
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
    public List<Urgencia> getAll() {
        return urgenciaRepository.findAll();
    }

    @Override
    public PaginacionDto<UrgenciaDTO.Response> getUrgencias(int pagina, int tamano, LocalDate fechaInicio,
            LocalDate fechaFin, EstadoUrgencia estado, String search, String sort, String order) {
        Sort sortSpec = buildSort(sort, order);
        Pageable pageable = PageRequest.of(pagina, tamano, sortSpec);
        Page<Urgencia> page = urgenciaRepository.findAll(buildSpecification(fechaInicio, fechaFin, estado, search), pageable);

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

    private Specification<Urgencia> buildSpecification(LocalDate fechaInicio, LocalDate fechaFin, EstadoUrgencia estado,
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

                predicates.add(cb.or(
                        cb.like(cb.lower(cb.coalesce(pacienteJoin.get("nombre"), "")), likePattern),
                        cb.like(cb.lower(cb.coalesce(pacienteJoin.get("apellido"), "")), likePattern),
                        cb.like(cb.lower(cb.coalesce(pacienteJoin.get("dni"), "")), likePattern),
                        cb.like(cb.lower(cb.coalesce(servicioJoin.get("nombre"), "")), likePattern),
                        cb.like(cb.lower(cb.coalesce(root.get("estado").as(String.class), "")), likePattern),
                        cb.like(cb.lower(cb.coalesce(root.get("tipo"), "")), likePattern),
                        cb.like(cb.lower(cb.coalesce(root.get("prioridad"), "")), likePattern),
                        cb.like(cb.lower(cb.coalesce(root.get("nivelUrgencia").as(String.class), "")), likePattern),
                        cb.like(cb.lower(cb.coalesce(quirofanoJoin.get("nombre"), "")), likePattern)));
            }

            return cb.and(predicates.toArray(new jakarta.persistence.criteria.Predicate[0]));
        };
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
            case "nivelUrgencia" -> Sort.by(direction, "nivelUrgencia");
            case "quirofano" -> Sort.by(direction, "quirofano.nombre");
            case "fechaHoraInicio", "fecha", "hora" -> Sort.by(direction, "fechaHoraInicio").and(Sort.by(direction, "id"));
            default -> Sort.by(direction, "fechaHoraInicio").and(Sort.by(direction, "id"));
        };
    }
}