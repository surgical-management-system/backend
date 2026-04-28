package com.dacs.backend.model.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import jakarta.persistence.LockModeType;

import com.dacs.backend.model.entity.Turno;

public interface TurnoRepository extends JpaRepository<Turno, Long> {
    
    List<Turno> findAllByFechaHoraInicioBetween(LocalDateTime start, LocalDateTime end);

    void deleteByCirugiaId(Long cirugiaId);

    List<Turno> findAllByFechaHoraInicioBetweenAndQuirofanoId(LocalDateTime start, LocalDateTime end, Long quirofanoId);

    List<Turno> findAllByFechaHoraInicioBetweenAndQuirofanoIdAndEstado(LocalDateTime start, LocalDateTime end, Long quirofanoId, String estado);

    List<Turno> findAllByFechaHoraInicioBetweenAndEstado(LocalDateTime start, LocalDateTime end, String estado);

    List<Turno> findAllByCirugiaId(Long cirugiaId);

        List<Turno> findAllByUrgenciaId(Long urgenciaId);

    @Query("SELECT t FROM Turno t WHERE t.quirofano.id = :quirofanoId AND t.fechaHoraInicio >= :start AND t.fechaHoraInicio < :end")
    List<Turno> findAllInRangeByQuirofanoId(@Param("start") LocalDateTime start,
            @Param("end") LocalDateTime end,
            @Param("quirofanoId") Long quirofanoId);

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("SELECT t FROM Turno t WHERE t.quirofano.id = :quirofanoId AND t.fechaHoraInicio >= :start AND t.fechaHoraInicio < :end")
    List<Turno> lockAllInRangeByQuirofanoId(@Param("start") LocalDateTime start,
            @Param("end") LocalDateTime end,
            @Param("quirofanoId") Long quirofanoId);
}
