package com.dacs.backend.service;

import java.time.LocalDateTime;

import com.dacs.backend.dto.PaginacionDto;
import com.dacs.backend.dto.TurnoDTO;
import com.dacs.backend.model.entity.Turno;


public interface TurnoService {

    PaginacionDto.Response<TurnoDTO> getTurnosDisponibles(int pagina, int tamano, LocalDateTime fechaInicio,
            LocalDateTime fechaFin, int quirofanoId, String estado, Integer duracionMinutos, Long servicioId);

    Boolean verificarDisponibilidadTurno(Long quirofanoId, LocalDateTime fechaHoraInicio, LocalDateTime fechaHoraFin);

    Turno asignarTurno(Long cirugiaId, Long quirofanoId, LocalDateTime fechaHoraInicio, LocalDateTime fechaHoraFin);

    Turno reservarTurnosParaCirugia(Long cirugiaId, Long quirofanoId, LocalDateTime fechaHoraInicio,
            LocalDateTime fechaHoraFin);

        Turno reservarTurnosParaUrgencia(Long urgenciaId, Long quirofanoId, LocalDateTime fechaHoraInicio,
            LocalDateTime fechaHoraFin);

    void borrarTurno(Long cirugiaId);

        void borrarTurnosPorUrgencia(Long urgenciaId);

    void generarTurnosAutomaticaMensual();
}
