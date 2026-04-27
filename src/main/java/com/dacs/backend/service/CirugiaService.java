package com.dacs.backend.service;

import com.dacs.backend.model.entity.Cirugia;

import java.time.LocalDate;
import java.util.List;

import com.dacs.backend.dto.CirugiaDTO;
import com.dacs.backend.dto.PaginacionDto;
import com.dacs.backend.dto.ServicioDto;
import com.dacs.backend.model.entity.EstadoCirugia;

public interface CirugiaService extends CommonService<Cirugia> {

    PaginacionDto<CirugiaDTO.Response> getCirugias(int pagina, int tamaño, LocalDate fechaInicio, LocalDate fechaFin,
            EstadoCirugia estado, String search, String sort, String order);

    List<ServicioDto> getServicios(int pagina, int tamaño);

    CirugiaDTO.Response createCirugia(CirugiaDTO.Create cirugiaRequestDto);

    CirugiaDTO.Response updateCirugia(Long id, CirugiaDTO.Update cirugiaDto);

    CirugiaDTO.Response inicializarCirugia(long cirugiaId);

    CirugiaDTO.Response finalizarCirugia(long long1);

    Long countCirugiasRestantesHoy();

    Long countCirugiasEstaSemana();
}
