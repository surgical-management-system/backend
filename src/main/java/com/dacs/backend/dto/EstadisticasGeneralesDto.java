package com.dacs.backend.dto;

import java.util.List;

import com.dacs.backend.model.entity.Quirofano;

import lombok.Data;

@Data
public class EstadisticasGeneralesDto {
    private Long totalPacientes;
    private Long cirugiasPendientes;
    private Long cirugiasHoy;
    private Long cirugiasEstaSemana;
    private Long urgenciasHoy;
    private Long urgenciasEstaSemana;
    private List<Quirofano> quirofanosDisponibles;
    private List<Quirofano> quirofanosEnUso;

}