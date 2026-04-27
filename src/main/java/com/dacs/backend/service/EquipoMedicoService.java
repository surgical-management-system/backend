package com.dacs.backend.service;

import java.util.List;

import com.dacs.backend.dto.MiembroEquipoMedicoDto;

public interface EquipoMedicoService {

    List<MiembroEquipoMedicoDto.Response> getEquipoMedicoCirugia(Long cirugiaId);

    List<MiembroEquipoMedicoDto.Response> saveEquipoMedicoCirugia(Long cirugiaId,
            List<MiembroEquipoMedicoDto.Create> entity);

    List<MiembroEquipoMedicoDto.Response> getEquipoMedicoUrgencia(Long urgenciaId);

    List<MiembroEquipoMedicoDto.Response> saveEquipoMedicoUrgencia(Long urgenciaId,
            List<MiembroEquipoMedicoDto.Create> entity);
}