package com.dacs.backend.model.repository;

import com.dacs.backend.model.entity.Intervencion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface IntervencionRepository extends JpaRepository<Intervencion, Long> {
    List<Intervencion> findByCirugiaId(Long cirugiaId);
    List<Intervencion> findByUrgenciaId(Long urgenciaId);
}
