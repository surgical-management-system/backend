package com.dacs.backend.controller;

import com.dacs.backend.dto.MiembroEquipoMedicoDto;
import com.dacs.backend.dto.CirugiaDTO;
import com.dacs.backend.service.CirugiaService;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.dacs.backend.dto.PaginacionDto;
import com.dacs.backend.dto.ServicioDto;
import com.dacs.backend.model.entity.EstadoCirugia;
import com.dacs.backend.service.EquipoMedicoService;

import java.util.List;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequestMapping(value = "/cirugia")
public class CirugiaController {

    @Autowired
    private CirugiaService cirugiaService;

    @Autowired
    private EquipoMedicoService equipoMedicoService;

    @GetMapping("")
    public ResponseEntity<PaginacionDto<CirugiaDTO.Response>> getByPage(
            @RequestParam(name = "pagina", required = false, defaultValue = "0") int pagina,
            @RequestParam(name = "tamano", required = false, defaultValue = "20") int tamano,
            @RequestParam(name = "fechaInicio", required = false) String fechaInicio,
            @RequestParam(name = "fechaFin", required = false) String fechaFin,
            @RequestParam(name = "estado", required = false) String estado,
            @RequestParam(name = "search", required = false) String search,
            @RequestParam(name = "sort", required = false, defaultValue = "fechaHoraInicio") String sort,
            @RequestParam(name = "order", required = false, defaultValue = "asc") String order) {
        EstadoCirugia estadoEnum = ControllerUtils.parseEstado(estado, EstadoCirugia.class);
        PaginacionDto<CirugiaDTO.Response> cirugias = cirugiaService.getCirugias(pagina, tamano,
                ControllerUtils.parseFecha(fechaInicio), ControllerUtils.parseFecha(fechaFin), estadoEnum, search,
                sort, order);
        return ResponseEntity.ok(cirugias);
    }

    @PostMapping("")
    public ResponseEntity<CirugiaDTO.Response> create(@RequestBody CirugiaDTO.Create cirugiaRequestDto) {
        CirugiaDTO.Response cirugiaResponse = cirugiaService.createCirugia(cirugiaRequestDto);
        return ResponseEntity.status(HttpStatus.CREATED).body(cirugiaResponse);
    }

    @PutMapping("/{id}")
    public ResponseEntity<CirugiaDTO.Response> update(@PathVariable Long id,
            @RequestBody CirugiaDTO.Update cirugiaDto) {
        CirugiaDTO.Response response = cirugiaService.updateCirugia(id, cirugiaDto);
        return ResponseEntity.ok(response);
    }

    @PutMapping("/{id}/inicializar")
    public ResponseEntity<CirugiaDTO.Response> inicializarCirugia(@PathVariable Long id) {
        CirugiaDTO.Response entity = cirugiaService.inicializarCirugia(id);
        return ResponseEntity.ok(entity);
    }
    @GetMapping("/{id}/equipo-medico")
    public ResponseEntity<List<MiembroEquipoMedicoDto.Response>> getEquipoMedico(@PathVariable Long id) {

        List<MiembroEquipoMedicoDto.Response> equipo = equipoMedicoService.getEquipoMedicoCirugia(id);
        return ResponseEntity.ok(equipo);
    }

    @PostMapping("/{id}/equipo-medico")
    public ResponseEntity<List<MiembroEquipoMedicoDto.Response>> postEquipoMedico(@PathVariable Long id,
            @RequestBody List<MiembroEquipoMedicoDto.Create> entityEquipoMedico) {

        List<MiembroEquipoMedicoDto.Response> resp = equipoMedicoService.saveEquipoMedicoCirugia(id, entityEquipoMedico);
        return ResponseEntity.status((HttpStatus.CREATED)).body(resp);
    }

    @GetMapping("/servicios")
    public ResponseEntity<List<ServicioDto>> getServicios(@RequestParam int pagina, @RequestParam int tamano) {
        return ResponseEntity.ok(cirugiaService.getServicios(pagina, tamano));
    }

    @PutMapping("/{id}/finalizar")
    public ResponseEntity<CirugiaDTO.Response> finalizarCirugia(@PathVariable String id) {
        CirugiaDTO.Response entity = cirugiaService.finalizarCirugia(Long.parseLong(id));        
        return ResponseEntity.ok(entity);
    }
}
