package com.dacs.backend.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dacs.backend.dto.MiembroEquipoMedicoDto;
import com.dacs.backend.dto.PersonalDto;
import com.dacs.backend.model.entity.Cirugia;
import com.dacs.backend.model.entity.EquipoMedico;
import com.dacs.backend.model.entity.Personal;
import com.dacs.backend.model.entity.Urgencia;
import com.dacs.backend.model.repository.CirugiaRepository;
import com.dacs.backend.model.repository.EquipoMedicoRepository;
import com.dacs.backend.model.repository.PersonalRepository;
import com.dacs.backend.model.repository.UrgenciaRepository;

@Service
public class EquipoMedicoServiceImpl implements EquipoMedicoService {

    @Autowired
    private EquipoMedicoRepository equipoMedicoRepository;

    @Autowired
    private CirugiaRepository cirugiaRepository;

    @Autowired
    private UrgenciaRepository urgenciaRepository;

    @Autowired
    private PersonalRepository personalRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    public List<MiembroEquipoMedicoDto.Response> getEquipoMedicoCirugia(Long cirugiaId) {
        List<EquipoMedico> equipo = equipoMedicoRepository.findByCirugiaId(cirugiaId);
        return mapearEquipoMedicoAResponse(equipo);
    }

    @Override
    public List<MiembroEquipoMedicoDto.Response> getEquipoMedicoUrgencia(Long urgenciaId) {
        List<EquipoMedico> equipo = equipoMedicoRepository.findByUrgenciaId(urgenciaId);
        return mapearEquipoMedicoAResponse(equipo);
    }

    @Override
    @Transactional
    public List<MiembroEquipoMedicoDto.Response> saveEquipoMedicoCirugia(Long cirugiaId,
            List<MiembroEquipoMedicoDto.Create> entity) {
        Cirugia cirugia = cirugiaRepository.findById(cirugiaId)
                .orElseThrow(() -> new IllegalArgumentException("Cirugia no encontrada id=" + cirugiaId));
        equipoMedicoRepository.deleteByCirugiaId(cirugiaId);
        return saveEquipoMedico(entity, cirugia, null);
    }

    @Override
    @Transactional
    public List<MiembroEquipoMedicoDto.Response> saveEquipoMedicoUrgencia(Long urgenciaId,
            List<MiembroEquipoMedicoDto.Create> entity) {
        Urgencia urgencia = urgenciaRepository.findById(urgenciaId)
                .orElseThrow(() -> new IllegalArgumentException("Urgencia no encontrada id=" + urgenciaId));
        equipoMedicoRepository.deleteByUrgenciaId(urgenciaId);
        return saveEquipoMedico(entity, null, urgencia);
    }

    private List<MiembroEquipoMedicoDto.Response> saveEquipoMedico(List<MiembroEquipoMedicoDto.Create> req,
            Cirugia cirugia, Urgencia urgencia) {
        List<Long> personalIds = req.stream()
                .map(MiembroEquipoMedicoDto.Create::getPersonalId)
                .filter(java.util.Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());

        final Map<Long, Personal> personalMap;
        if (!personalIds.isEmpty()) {
            List<Personal> personals = personalRepository.findAllById(personalIds);
            personalMap = personals.stream().collect(Collectors.toMap(Personal::getId, p -> p));
        } else {
            personalMap = Map.of();
        }

        List<EquipoMedico> toSave = construirEquipoMedico(req, cirugia, urgencia, personalMap);
        if (toSave.isEmpty()) {
            return java.util.Collections.emptyList();
        }

        List<EquipoMedico> saved = equipoMedicoRepository.saveAll(toSave);
        return mapearEquipoMedicoAResponse(saved);
    }

    private List<EquipoMedico> construirEquipoMedico(List<MiembroEquipoMedicoDto.Create> req, Cirugia cirugia,
            Urgencia urgencia, Map<Long, Personal> personalMap) {
        List<EquipoMedico> toSave = new java.util.ArrayList<>();
        for (MiembroEquipoMedicoDto.Create item : req) {
            Personal personal = personalMap.get(item.getPersonalId());
            if (personal == null) {
                throw new IllegalArgumentException("Personal no encontrado id=" + item.getPersonalId());
            }

            EquipoMedico equipoMedico = new EquipoMedico();
            equipoMedico.setFechaAsignacion(LocalDateTime.now());
            equipoMedico.setCirugia(cirugia);
            equipoMedico.setUrgencia(urgencia);
            equipoMedico.setPersonal(personal);
            equipoMedico.setRol(item.getRol());
            toSave.add(equipoMedico);
        }
        return toSave;
    }

    private List<MiembroEquipoMedicoDto.Response> mapearEquipoMedicoAResponse(List<EquipoMedico> saved) {
        return saved.stream().map(e -> {
            MiembroEquipoMedicoDto.Response dto = modelMapper.map(e, MiembroEquipoMedicoDto.Response.class);
            dto.setRol(e.getRol());
            dto.setCirugiaId(e.getCirugia() != null ? e.getCirugia().getId() : null);
            dto.setUrgenciaId(e.getUrgencia() != null ? e.getUrgencia().getId() : null);
            dto.setFechaAsignacion(e.getFechaAsignacion());

            Personal p = e.getPersonal();
            if (p != null) {
                PersonalDto.Response pDto = modelMapper.map(p, PersonalDto.Response.class);
                dto.setPersonal(pDto);
            }
            return dto;
        }).collect(Collectors.toList());
    }
}