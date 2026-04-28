package com.dacs.backend.model.repository;

import java.time.LocalDateTime;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.dacs.backend.model.entity.Cirugia;
import com.dacs.backend.model.entity.EstadoCirugia;

public interface CirugiaRepository extends JpaRepository<Cirugia, Long>, JpaSpecificationExecutor<Cirugia> {

    Page<Cirugia> findByFechaHoraInicioBetween(LocalDateTime atStartOfDay, LocalDateTime atTime, Pageable pageable);

    Page<Cirugia> findByFechaHoraInicioAfter(LocalDateTime atStartOfDay, Pageable pageable);

    Page<Cirugia> findByFechaHoraInicioBefore(LocalDateTime atTime, Pageable pageable);

    // Métodos con filtro por estado
    Page<Cirugia> findByEstado(EstadoCirugia estado, Pageable pageable);

    Page<Cirugia> findByEstadoAndFechaHoraInicioBetween(EstadoCirugia estado, LocalDateTime atStartOfDay, LocalDateTime atTime, Pageable pageable);

    Page<Cirugia> findByEstadoAndFechaHoraInicioAfter(EstadoCirugia estado, LocalDateTime atStartOfDay, Pageable pageable);

    Page<Cirugia> findByEstadoAndFechaHoraInicioBefore(EstadoCirugia estado, LocalDateTime atTime, Pageable pageable);

    Long countByEstadoAndFechaHoraInicioBetween(EstadoCirugia programada, LocalDateTime startOfDay,
            LocalDateTime endOfDay);

    // Find all cirugias for a given quirofano (used to detect overlaps)
    java.util.List<Cirugia> findByQuirofanoId(Long quirofanoId);

}
