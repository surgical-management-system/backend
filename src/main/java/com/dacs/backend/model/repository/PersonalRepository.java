package com.dacs.backend.model.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.dacs.backend.model.entity.Personal;


public interface PersonalRepository extends JpaRepository<Personal, Long> {

    List<Personal> findByNombreContainingIgnoreCaseOrDniContainingIgnoreCase(String param, String param2);
    
    Page<Personal> findByNombreContainingIgnoreCase(String nombre, Pageable pageable);

    boolean existsByLegajoIgnoreCase(String legajo);

    boolean existsByDniIgnoreCase(String dni);

    boolean existsByTelefonoIgnoreCase(String telefono);

    boolean existsByLegajoIgnoreCaseAndIdNot(String legajo, Long id);

    boolean existsByDniIgnoreCaseAndIdNot(String dni, Long id);

    boolean existsByTelefonoIgnoreCaseAndIdNot(String telefono, Long id);
}


