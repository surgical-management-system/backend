package com.dacs.backend.service.helper;

import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.function.Function;

@Component
public class ProcedimientoSortBuilder {

    public Sort build(String sort, String order, String priorityField) {
        Sort.Direction direction = "desc".equalsIgnoreCase(order) ? Sort.Direction.DESC : Sort.Direction.ASC;
        String key = sort == null ? "fechaHoraInicio" : sort.trim();

        Map<String, Function<Sort.Direction, Sort>> sortMap = Map.ofEntries(
                Map.entry("paciente", dir -> Sort.by(dir, "paciente.apellido").and(Sort.by(dir, "paciente.nombre"))),
                Map.entry("servicio", dir -> Sort.by(dir, "servicio.nombre")),
                Map.entry("estado", dir -> Sort.by(dir, "estado")),
                Map.entry("tipo", dir -> Sort.by(dir, "tipo")),
                Map.entry("prioridad", dir -> Sort.by(dir, priorityField)),
                Map.entry("nivelUrgencia", dir -> Sort.by(dir, priorityField)),
                Map.entry("quirofano", dir -> Sort.by(dir, "quirofano.nombre")),
                Map.entry("fechaHoraInicio", dir -> Sort.by(dir, "fechaHoraInicio").and(Sort.by(dir, "id"))),
                Map.entry("fecha", dir -> Sort.by(dir, "fechaHoraInicio").and(Sort.by(dir, "id"))),
                Map.entry("hora", dir -> Sort.by(dir, "fechaHoraInicio").and(Sort.by(dir, "id")))
        );

        return sortMap.getOrDefault(key, sortMap.get("fechaHoraInicio")).apply(direction);
    }
}
