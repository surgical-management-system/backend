package com.dacs.backend.controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dacs.backend.dto.PaginacionDto;
import com.dacs.backend.dto.UrgenciaDTO;
import com.dacs.backend.model.entity.EstadoUrgencia;
import com.dacs.backend.service.UrgenciaService;

@RestController
@RequestMapping("/urgencia")
public class UrgenciaController {

    @Autowired
    private UrgenciaService urgenciaService;

    @GetMapping("")
    public ResponseEntity<PaginacionDto<UrgenciaDTO.Response>> getByPage(
            @RequestParam(name = "pagina", required = false, defaultValue = "0") int pagina,
            @RequestParam(name = "tamano", required = false, defaultValue = "20") int tamano,
            @RequestParam(name = "fechaInicio", required = false) String fechaInicio,
            @RequestParam(name = "fechaFin", required = false) String fechaFin,
            @RequestParam(name = "estado", required = false) String estado,
            @RequestParam(name = "search", required = false) String search,
            @RequestParam(name = "sort", required = false, defaultValue = "fechaHoraInicio") String sort,
            @RequestParam(name = "order", required = false, defaultValue = "asc") String order) {
        EstadoUrgencia estadoEnum = parseEstado(estado);
        PaginacionDto<UrgenciaDTO.Response> urgencias = urgenciaService.getUrgencias(pagina, tamano, parseFecha(fechaInicio), parseFecha(fechaFin), estadoEnum, search, sort, order);
        return ResponseEntity.ok(urgencias);
    }

    private EstadoUrgencia parseEstado(String estado) {
        if (estado == null || estado.isBlank()) {
            return null;
        }
        try {
            return EstadoUrgencia.valueOf(estado.toUpperCase());
        } catch (IllegalArgumentException e) {
            return null;
        }
    }

    @PostMapping("")
    public ResponseEntity<UrgenciaDTO.Response> create(@RequestBody UrgenciaDTO.Create urgenciaRequestDto) {
        UrgenciaDTO.Response urgenciaResponse = urgenciaService.createUrgencia(urgenciaRequestDto);
        return ResponseEntity.status(HttpStatus.CREATED).body(urgenciaResponse);
    }

    @PutMapping("/{id}")
    public ResponseEntity<UrgenciaDTO.Response> update(@PathVariable Long id,
            @RequestBody UrgenciaDTO.Update urgenciaDto) {
        UrgenciaDTO.Response response = urgenciaService.updateUrgencia(id, urgenciaDto);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        urgenciaService.delete(id);
        return ResponseEntity.noContent().build();
    }

    public static LocalDate parseFecha(String fecha) {
        if (fecha == null || fecha.isEmpty()) {
            return null;
        }
        return LocalDate.parse(fecha);
    }
}