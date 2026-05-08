package com.dacs.backend.model.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.dacs.backend.model.entity.Personal;


public interface PersonalRepository extends JpaRepository<Personal, Long> {

    List<Personal> findByNombreContainingIgnoreCaseOrDniContainingIgnoreCase(String param, String param2);
    
    Page<Personal> findByNombreContainingIgnoreCase(String nombre, Pageable pageable);

        @Query("""
            SELECT p
            FROM Personal p
            WHERE LOWER(COALESCE(p.nombre, '')) LIKE LOWER(CONCAT('%', :search, '%'))
               OR LOWER(COALESCE(p.legajo, '')) LIKE LOWER(CONCAT('%', :search, '%'))
            """)
        Page<Personal> findByNombreOrLegajoContainingIgnoreCase(
            @Param("search") String search,
            Pageable pageable);

        @Query("""
            SELECT p
            FROM Personal p
            WHERE LOWER(REPLACE(COALESCE(p.rol, ''), '_', ' ')) = :normalizedRole
            """)
        Page<Personal> findByNormalizedRol(@Param("normalizedRole") String normalizedRole, Pageable pageable);

        @Query("""
            SELECT p
            FROM Personal p
            WHERE (
                    LOWER(COALESCE(p.nombre, '')) LIKE LOWER(CONCAT('%', :search, '%'))
                 OR LOWER(COALESCE(p.legajo, '')) LIKE LOWER(CONCAT('%', :search, '%'))
                  )
              AND LOWER(REPLACE(COALESCE(p.rol, ''), '_', ' ')) = :normalizedRole
            """)
        Page<Personal> findByNombreOrLegajoContainingIgnoreCaseAndNormalizedRol(
            @Param("search") String search,
            @Param("normalizedRole") String normalizedRole,
            Pageable pageable);

    boolean existsByLegajoIgnoreCase(String legajo);

    boolean existsByDniIgnoreCase(String dni);

    boolean existsByTelefonoIgnoreCase(String telefono);

    boolean existsByLegajoIgnoreCaseAndIdNot(String legajo, Long id);

    boolean existsByDniIgnoreCaseAndIdNot(String dni, Long id);

    boolean existsByTelefonoIgnoreCaseAndIdNot(String telefono, Long id);
}


