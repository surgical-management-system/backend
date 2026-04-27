package com.dacs.backend.model.entity;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;

@Data
@Entity
public class EquipoMedico {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_cirugia", nullable = true)
    private Cirugia cirugia;

    @ManyToOne
    @JoinColumn(name = "id_urgencia", nullable = true)
    private Urgencia urgencia;

    @ManyToOne
    @JoinColumn(name = "id_personal", nullable = false)
    private Personal personal;  

    @CreationTimestamp
    private LocalDateTime fechaAsignacion;

    private String rol;
}
  