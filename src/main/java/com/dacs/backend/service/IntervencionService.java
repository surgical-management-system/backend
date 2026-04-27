package com.dacs.backend.service;

import com.dacs.backend.dto.IntervencionDto;
import java.util.List;

public interface IntervencionService {
    List<IntervencionDto> getByCirugiaId(Long cirugiaId);
    List<IntervencionDto> getByUrgenciaId(Long urgenciaId);
    IntervencionDto createIntervencion(Long cirugiaId, IntervencionDto intervencion);
    IntervencionDto createIntervencionForUrgencia(Long urgenciaId, IntervencionDto intervencion);
    IntervencionDto updateIntervencion(Long cirugiaId, Long intervencionId, IntervencionDto intervencion);
    void deleteIntervencion(Long cirugiaId, Long intervencionId);
}
