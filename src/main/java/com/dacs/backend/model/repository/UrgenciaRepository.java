package com.dacs.backend.model.repository;

import java.time.LocalDateTime;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.dacs.backend.model.entity.EstadoUrgencia;
import com.dacs.backend.model.entity.Urgencia;

public interface UrgenciaRepository extends JpaRepository<Urgencia, Long>, JpaSpecificationExecutor<Urgencia> {
    Long countByEstadoAndFechaHoraInicioBetween(EstadoUrgencia estado, LocalDateTime startOfDay, LocalDateTime endOfDay);
}