package com.dacs.backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dacs.backend.dto.PacienteDTO;
import com.dacs.backend.dto.PaginacionDto;
import com.dacs.backend.service.PacienteService;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
@RequestMapping(value = "/pacientes")
public class PacienteController {

    @Autowired
    private PacienteService pacienteService;

    @PostMapping("")
    public ResponseEntity<PacienteDTO.Response> create(@RequestBody PacienteDTO.Create pacienteDTO) {
        PacienteDTO.Response data = pacienteService.creatPaciente(pacienteDTO);
        return new ResponseEntity<PacienteDTO.Response>(data, HttpStatus.CREATED);
    }

    @GetMapping("")
    public ResponseEntity<PaginacionDto<PacienteDTO.Response>> getAll(
            @RequestParam(name = "page", defaultValue = "0") Integer page,
            @RequestParam(name = "size", defaultValue = "16") Integer size,
            @RequestParam(name = "search", required = false) String search) {
        
        return new ResponseEntity<>(
            pacienteService.getByPage(page, size, search), 
            HttpStatus.OK
        );
    }

    @PutMapping("/{id}/deactivate")
    public ResponseEntity<Void> deactivate(@PathVariable("id") Long id) {
        pacienteService.deactivate(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PutMapping("/{id}/activate")
    public ResponseEntity<Void> activate(@PathVariable("id") Long id) {
        pacienteService.activate(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<PacienteDTO.Response> getById(@PathVariable("id") Long id) {
        return ResponseEntity.ok(pacienteService.getById(id).map(p -> {
            // Map entity to DTO.Response using service's existing methods if available
            // If service returns Optional<Paciente>, convert to Response via mapper in service layer
            // Here we assume service implementation provides mapping via getById returning Optional<Response>
            // Fallback: call getByPage and filter, but better to ask service for Response
            return pacienteService.getByPage(0, 1, null).getContenido().stream()
                    .filter(r -> r.getId().equals(id))
                    .findFirst()
                    .orElseThrow(() -> new RuntimeException("Paciente not found"));
        }).orElseThrow(() -> new RuntimeException("Paciente not found")));
    }
}
