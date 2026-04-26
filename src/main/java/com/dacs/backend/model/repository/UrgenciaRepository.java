package com.dacs.backend.model.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.dacs.backend.model.entity.Urgencia;

public interface UrgenciaRepository extends JpaRepository<Urgencia, Long>, JpaSpecificationExecutor<Urgencia> {
}