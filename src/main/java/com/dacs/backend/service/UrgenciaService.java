package com.dacs.backend.service;

import java.time.LocalDate;

import com.dacs.backend.dto.PaginacionDto;
import com.dacs.backend.dto.UrgenciaDTO;
import com.dacs.backend.model.entity.EstadoUrgencia;
import com.dacs.backend.model.entity.Urgencia;

public interface UrgenciaService extends CommonService<Urgencia> {

    PaginacionDto<UrgenciaDTO.Response> getUrgencias(int pagina, int tamano, LocalDate fechaInicio, LocalDate fechaFin,
            EstadoUrgencia estado, String search, String sort, String order);

    UrgenciaDTO.Response createUrgencia(UrgenciaDTO.Create urgenciaRequestDto);

    UrgenciaDTO.Response updateUrgencia(Long id, UrgenciaDTO.Update urgenciaDto);

    UrgenciaDTO.Response inicializarUrgencia(long urgenciaId);
}