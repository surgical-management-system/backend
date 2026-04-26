package com.dacs.backend.dto;

import java.time.LocalDateTime;

import com.dacs.backend.model.entity.EstadoUrgencia;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class UrgenciaDTO {

    @Data
    public static class Response {
        private Long id;
        private String prioridad;
        private Integer nivelUrgencia;
        private LocalDateTime fechaHoraInicio;
        private EstadoUrgencia estado;
        private String anestesia;
        private String tipo;
        private ServicioDto servicio;
        private PacienteDTO.Response paciente;
        private QuirofanoDTO quirofano;
    }

    @Data
    public static class Create {
        private String prioridad;
        private Integer nivelUrgencia;
        private LocalDateTime fechaHoraInicio;
        private EstadoUrgencia estado;
        private String anestesia;
        private String tipo;
        private Long pacienteId;
        private Long servicioId;
        private Long quirofanoId;
    }

    @Getter
    @Setter
    public static class Update extends Create {
    }
}