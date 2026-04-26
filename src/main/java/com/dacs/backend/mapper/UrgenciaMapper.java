package com.dacs.backend.mapper;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.dacs.backend.dto.PacienteDTO;
import com.dacs.backend.dto.QuirofanoDTO;
import com.dacs.backend.dto.ServicioDto;
import com.dacs.backend.dto.UrgenciaDTO;
import com.dacs.backend.model.entity.Paciente;
import com.dacs.backend.model.entity.Quirofano;
import com.dacs.backend.model.entity.Servicio;
import com.dacs.backend.model.entity.Urgencia;
import com.dacs.backend.model.repository.PacienteRepository;
import com.dacs.backend.model.repository.QuirofanoRepository;
import com.dacs.backend.model.repository.ServicioRepository;

@Component
public class UrgenciaMapper {

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private PacienteRepository pacienteRepository;

    @Autowired
    private ServicioRepository servicioRepository;

    @Autowired
    private QuirofanoRepository quirofanoRepository;

    public Urgencia toEntity(UrgenciaDTO.Create dto) {
        validateNivelUrgencia(dto.getNivelUrgencia());

        Urgencia entity = new Urgencia();
        entity.setPrioridad(dto.getPrioridad());
        entity.setNivelUrgencia(dto.getNivelUrgencia());
        entity.setFechaHoraInicio(dto.getFechaHoraInicio());
        entity.setEstado(dto.getEstado() != null ? dto.getEstado() : com.dacs.backend.model.entity.EstadoUrgencia.PENDIENTE);
        entity.setAnestesia(dto.getAnestesia());
        entity.setTipo(dto.getTipo());

        if (dto.getServicioId() != null) {
            Servicio servicio = servicioRepository.findById(dto.getServicioId())
                    .orElseThrow(() -> new IllegalArgumentException("Servicio no encontrado id=" + dto.getServicioId()));
            entity.setServicio(servicio);
        }

        if (dto.getPacienteId() != null) {
            Paciente paciente = pacienteRepository.findById(dto.getPacienteId())
                    .orElseThrow(() -> new IllegalArgumentException("Paciente no encontrado id=" + dto.getPacienteId()));
            entity.setPaciente(paciente);
        }

        if (dto.getQuirofanoId() != null) {
            Quirofano quirofano = quirofanoRepository.findById(dto.getQuirofanoId())
                    .orElseThrow(() -> new IllegalArgumentException("Quirofano no encontrado id=" + dto.getQuirofanoId()));
            entity.setQuirofano(quirofano);
        }

        return entity;
    }

    public UrgenciaDTO.Response toResponseDto(Urgencia entity) {
        UrgenciaDTO.Response dto = modelMapper.map(entity, UrgenciaDTO.Response.class);
        if (entity.getPaciente() != null) {
            dto.setPaciente(modelMapper.map(entity.getPaciente(), PacienteDTO.Response.class));
        }
        if (entity.getQuirofano() != null) {
            dto.setQuirofano(modelMapper.map(entity.getQuirofano(), QuirofanoDTO.class));
        }
        if (entity.getServicio() != null) {
            dto.setServicio(modelMapper.map(entity.getServicio(), ServicioDto.class));
        }
        return dto;
    }

    private void validateNivelUrgencia(Integer nivelUrgencia) {
        if (nivelUrgencia == null) {
            throw new IllegalArgumentException("nivelUrgencia es obligatorio");
        }
        if (nivelUrgencia < 1 || nivelUrgencia > 3) {
            throw new IllegalArgumentException("nivelUrgencia debe estar entre 1 y 3");
        }
    }
}