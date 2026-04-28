package com.dacs.backend.service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.dacs.backend.model.entity.Turno;
import com.dacs.backend.dto.PaginacionDto;
import com.dacs.backend.dto.TurnoDTO;
import com.dacs.backend.model.entity.Cirugia;
import com.dacs.backend.model.entity.EstadoCirugia;
import com.dacs.backend.model.entity.Urgencia;
import com.dacs.backend.model.entity.Quirofano;
import com.dacs.backend.model.repository.TurnoRepository;
import com.dacs.backend.model.repository.CirugiaRepository;
import com.dacs.backend.model.repository.UrgenciaRepository;
import com.dacs.backend.model.repository.QuirofanoRepository;
import com.dacs.backend.model.repository.ServicioRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TurnoServiceImpl implements TurnoService {

    @Autowired
    private TurnoRepository turnoRepository;

    @Autowired
    private CirugiaRepository cirugiaRepository;

    @Autowired
    private UrgenciaRepository urgenciaRepository;

    @Autowired
    private QuirofanoRepository quirofanoRepository;

    @Autowired
    private ServicioRepository servicioRepository;

    @Override
        public PaginacionDto.Response<TurnoDTO> getTurnosDisponibles(int pagina, int tamano, LocalDateTime fechaInicio,
            LocalDateTime fechaFin,
            int quirofanoId, String estado, Integer duracionMinutos, Long servicioId) {
        if (fechaInicio == null) {
            fechaInicio = LocalDateTime.now();
        }
        if (fechaFin == null) {
            fechaFin = fechaInicio.plusDays(30);
        }

        List<Turno> turnos;
        boolean filtrarQuirofano = (quirofanoId != 0);
        if (filtrarQuirofano) {
            turnos = turnoRepository.findAllByFechaHoraInicioBetweenAndQuirofanoId(
                fechaInicio, fechaFin, (long) quirofanoId);
        } else {
            turnos = turnoRepository.findAllByFechaHoraInicioBetween(fechaInicio, fechaFin);
        }

        Integer duracionResuelta = duracionMinutos;
        if ((duracionResuelta == null || duracionResuelta <= 0) && servicioId != null) {
            duracionResuelta = servicioRepository.findById(servicioId)
                    .map(s -> s.getDuracionMinutos())
                    .orElseThrow(() -> new IllegalArgumentException("Servicio no encontrado id=" + servicioId));
        }

        int bloquesNecesarios = 1;
        if (duracionResuelta != null && duracionResuelta > 0) {
            bloquesNecesarios = (duracionResuelta + 29) / 30;
        }

        Map<Long, Map<LocalDateTime, Turno>> turnosPorQuirofanoYFecha = new HashMap<>();
        for (Turno turno : turnos) {
            if (turno.getQuirofano() == null || turno.getQuirofano().getId() == null) {
                continue;
            }
            turnosPorQuirofanoYFecha
                    .computeIfAbsent(turno.getQuirofano().getId(), k -> new HashMap<>())
                    .put(turno.getFechaHoraInicio(), turno);
        }

        List<com.dacs.backend.dto.TurnoDTO> turnoDTOs = new ArrayList<>();
        for (Turno t : turnos) {
            com.dacs.backend.dto.TurnoDTO dto = new com.dacs.backend.dto.TurnoDTO();
            dto.setId(t.getId());
            dto.setFechaHoraInicio(t.getFechaHoraInicio());
            dto.setEstado(t.getEstado());

            boolean disponible = "DISPONIBLE".equalsIgnoreCase(t.getEstado());
            if (disponible && bloquesNecesarios > 1 && t.getQuirofano() != null && t.getQuirofano().getId() != null) {
                Map<LocalDateTime, Turno> turnosDelQuirofano = turnosPorQuirofanoYFecha.get(t.getQuirofano().getId());
                for (int i = 1; i < bloquesNecesarios; i++) {
                    LocalDateTime siguienteBloque = t.getFechaHoraInicio().plusMinutes(i * 30L);
                    Turno turnoSiguiente = turnosDelQuirofano != null ? turnosDelQuirofano.get(siguienteBloque) : null;
                    if (turnoSiguiente == null || !"DISPONIBLE".equalsIgnoreCase(turnoSiguiente.getEstado())) {
                        disponible = false;
                        break;
                    }
                }
            }
            dto.setDisponible(disponible);

            if (t.getQuirofano() != null) {
                dto.setQuirofanoId(t.getQuirofano().getId());
            }
            if (t.getCirugia() != null) {
                dto.setCirugiaId(t.getCirugia().getId());
            }
            if (t.getUrgencia() != null) {
                dto.setUrgenciaId(t.getUrgencia().getId());
            }
            turnoDTOs.add(dto);
        }

        // Pagination logic
        int totalElementos = turnoDTOs.size();
        int fromIndex = Math.min(pagina * tamano, totalElementos);
        int toIndex = Math.min(fromIndex + tamano, totalElementos);
        List<com.dacs.backend.dto.TurnoDTO> pageContent = turnoDTOs.subList(fromIndex, toIndex);

        PaginacionDto.Response<com.dacs.backend.dto.TurnoDTO> resp = new PaginacionDto.Response<>();
        resp.setContenido(pageContent);
        resp.setPagina(pagina);
        resp.setTamaño(tamano);
        resp.setTotalElementos(totalElementos);
        resp.setTotalPaginas((int) Math.ceil((double) totalElementos / tamano));
        return resp;
    }

    @Override
    public Boolean verificarDisponibilidadTurno(Long quirofanoId, LocalDateTime fechaHoraInicio,
            LocalDateTime fechaHoraFin) {
        if (fechaHoraInicio == null || fechaHoraFin == null || !fechaHoraFin.isAfter(fechaHoraInicio)) {
            return false;
        }
        if (fechaHoraInicio.getMinute() % 30 != 0 || fechaHoraInicio.getSecond() != 0 || fechaHoraInicio.getNano() != 0
                || fechaHoraFin.getMinute() % 30 != 0 || fechaHoraFin.getSecond() != 0 || fechaHoraFin.getNano() != 0) {
            return false;
        }

        long minutos = java.time.Duration.between(fechaHoraInicio, fechaHoraFin).toMinutes();
        long cantidad = minutos / 30;
        if (minutos % 30 != 0) {
            cantidad++;
        }
        System.out.println("Cantidad de turnos necesarios: " + cantidad);
        System.out.println("FechaHoraIniciod: " + fechaHoraInicio);
        System.out.println("FechaHoraFin: " + fechaHoraFin);

        // Obtener todos los turnos en el rango [inicio, fin) para el quirófano
        List<Turno> turnos = turnoRepository.findAllInRangeByQuirofanoId(fechaHoraInicio, fechaHoraFin, quirofanoId);

        Map<LocalDateTime, Turno> turnosPorFecha = new HashMap<>();
        for (Turno turno : turnos) {
            turnosPorFecha.put(turno.getFechaHoraInicio(), turno);
        }

        // Verificar que todos los bloques requeridos existan y estén DISPONIBLE
        for (int i = 0; i < cantidad; i++) {
            LocalDateTime actual = fechaHoraInicio.plusMinutes(i * 30);
            Turno bloque = turnosPorFecha.get(actual);
            boolean disponible = bloque != null && "DISPONIBLE".equalsIgnoreCase(bloque.getEstado());
            if (!disponible) {
                return false;
            }
        }
        return true;
    }

    @Override
    @Transactional
    public Turno asignarTurno(Long cirugiaId, Long quirofanoId, LocalDateTime fechaHoraInicio,
            LocalDateTime fechaHoraFin) {
        List<Turno> turnosEnRango = turnoRepository.findAllInRangeByQuirofanoId(fechaHoraInicio, fechaHoraFin, quirofanoId)
                .stream()
                .filter(t -> "DISPONIBLE".equalsIgnoreCase(t.getEstado()))
                .toList();

        System.err.println("Turnos disponibles encontrados: " + turnosEnRango);
        if (turnosEnRango.isEmpty()) {
            throw new IllegalArgumentException(
                    "No hay turnos disponibles para el quirófano en la fecha y hora solicitadas.");
        }
        Cirugia cirugia = cirugiaRepository.findById(cirugiaId)
                .orElseThrow(() -> new IllegalArgumentException("Cirugía no encontrada con ID: " + cirugiaId));

        for (Turno t : turnosEnRango) {
            t.setCirugia(cirugia);
            t.setUrgencia(null);
            t.setEstado("ASIGNADO");
        }
        turnoRepository.saveAll(turnosEnRango);
        return turnosEnRango.get(0);
    }

    @Override
    @Transactional
    public Turno reservarTurnosParaCirugia(Long cirugiaId, Long quirofanoId, LocalDateTime fechaHoraInicio,
            LocalDateTime fechaHoraFin) {
        if (fechaHoraInicio == null || fechaHoraFin == null || !fechaHoraFin.isAfter(fechaHoraInicio)) {
            throw new IllegalArgumentException("El rango de fechas es inválido.");
        }
        if (fechaHoraInicio.getMinute() % 30 != 0 || fechaHoraInicio.getSecond() != 0 || fechaHoraInicio.getNano() != 0
                || fechaHoraFin.getMinute() % 30 != 0 || fechaHoraFin.getSecond() != 0 || fechaHoraFin.getNano() != 0) {
            throw new IllegalArgumentException("Las fechas deben estar alineadas a bloques de 30 minutos.");
        }

        long minutos = java.time.Duration.between(fechaHoraInicio, fechaHoraFin).toMinutes();
        long bloquesNecesarios = minutos / 30;
        if (minutos % 30 != 0) {
            bloquesNecesarios++;
        }

        List<Turno> turnosBloqueados = turnoRepository.lockAllInRangeByQuirofanoId(
                fechaHoraInicio,
                fechaHoraFin,
                quirofanoId);

        Map<LocalDateTime, Turno> turnosPorFecha = new HashMap<>();
        for (Turno turno : turnosBloqueados) {
            turnosPorFecha.put(turno.getFechaHoraInicio(), turno);
        }

        List<Turno> bloquesAAsignar = new ArrayList<>();
        for (int i = 0; i < bloquesNecesarios; i++) {
            LocalDateTime bloqueEsperado = fechaHoraInicio.plusMinutes(i * 30);
            Turno bloque = turnosPorFecha.get(bloqueEsperado);
            if (bloque == null || !"DISPONIBLE".equalsIgnoreCase(bloque.getEstado())) {
                throw new IllegalArgumentException(
                        "No hay turnos disponibles para el quirófano en la fecha y hora solicitadas.");
            }
            bloquesAAsignar.add(bloque);
        }

        Cirugia cirugia = cirugiaRepository.findById(cirugiaId)
                .orElseThrow(() -> new IllegalArgumentException("Cirugía no encontrada con ID: " + cirugiaId));

        for (Turno turno : bloquesAAsignar) {
            turno.setCirugia(cirugia);
            turno.setUrgencia(null);
            turno.setEstado("ASIGNADO");
        }
        turnoRepository.saveAll(bloquesAAsignar);
        return bloquesAAsignar.get(0);
    }

    @Override
    @Transactional
    public Turno reservarTurnosParaUrgencia(Long urgenciaId, Long quirofanoId, LocalDateTime fechaHoraInicio,
            LocalDateTime fechaHoraFin) {
        if (fechaHoraInicio == null || fechaHoraFin == null || !fechaHoraFin.isAfter(fechaHoraInicio)) {
            throw new IllegalArgumentException("El rango de fechas es inválido.");
        }
        if (fechaHoraInicio.getMinute() % 30 != 0 || fechaHoraInicio.getSecond() != 0 || fechaHoraInicio.getNano() != 0
                || fechaHoraFin.getMinute() % 30 != 0 || fechaHoraFin.getSecond() != 0 || fechaHoraFin.getNano() != 0) {
            throw new IllegalArgumentException("Las fechas deben estar alineadas a bloques de 30 minutos.");
        }

        Urgencia urgencia = urgenciaRepository.findById(urgenciaId)
                .orElseThrow(() -> new IllegalArgumentException("Urgencia no encontrada con ID: " + urgenciaId));

        if (urgencia.getServicio() == null || urgencia.getServicio().getDuracionMinutos() == null
            || urgencia.getServicio().getDuracionMinutos() <= 0) {
            throw new IllegalArgumentException("La urgencia no tiene una duración válida asociada.");
        }

        int bloquesNecesarios = (urgencia.getServicio().getDuracionMinutos() + 29) / 30;

        List<Turno> turnosBloqueados = turnoRepository.lockAllInRangeByQuirofanoId(
                fechaHoraInicio,
                fechaHoraFin,
                quirofanoId);

        Map<LocalDateTime, Turno> turnosPorFecha = new HashMap<>();
        for (Turno turno : turnosBloqueados) {
            turnosPorFecha.put(turno.getFechaHoraInicio(), turno);
        }

        List<Turno> bloquesAAsignar = new ArrayList<>();
        Set<Long> cirugiasEnRango = new HashSet<>();
        List<LocalDateTime> bloquesFaltantes = new ArrayList<>();
        Set<Long> cirugiasACancelar = new HashSet<>();
        for (LocalDateTime bloqueEsperado = fechaHoraInicio; bloqueEsperado.isBefore(fechaHoraFin); bloqueEsperado = bloqueEsperado.plusMinutes(30)) {
            Turno bloque = turnosPorFecha.get(bloqueEsperado);
            if (bloque == null) {
                bloquesFaltantes.add(bloqueEsperado);
                continue;
            }
            if (bloque.getUrgencia() != null && !bloque.getUrgencia().getId().equals(urgenciaId)) {
                throw new IllegalArgumentException("Ya existe una urgencia asignada en el rango solicitado.");
            }
            if (bloque.getCirugia() != null) {
                cirugiasEnRango.add(bloque.getCirugia().getId());
                cirugiasACancelar.add(bloque.getCirugia().getId());
            }
            bloquesAAsignar.add(bloque);
        }

        // Also detect cirugias that start before the requested start but whose duration
        // makes them overlap one or more slots in the requested range.
        // This covers cases where a cirugia begins earlier (e.g., 08:00) and occupies the
        // 08:30 slot that an urgencia requests.
        java.util.List<Cirugia> cirugiasEnQuirofano = cirugiaRepository.findByQuirofanoId(quirofanoId);
        for (Cirugia cirugia : cirugiasEnQuirofano) {
            if (cirugia.getFechaHoraInicio() == null || cirugia.getServicio() == null || cirugia.getServicio().getDuracionMinutos() == null) {
                continue;
            }
            LocalDateTime cirugiaStart = cirugia.getFechaHoraInicio();
            LocalDateTime cirugiaEnd = cirugiaStart.plusMinutes(cirugia.getServicio().getDuracionMinutos());
            // Overlap condition: cirugiaStart < fechaHoraFin && cirugiaEnd > fechaHoraInicio
            if (cirugiaStart.isBefore(fechaHoraFin) && cirugiaEnd.isAfter(fechaHoraInicio)) {
                cirugiasEnRango.add(cirugia.getId());
                cirugiasACancelar.add(cirugia.getId());
            }
        }

        if (!bloquesFaltantes.isEmpty()) {
            if (cirugiasEnRango.size() == 1) {
                Long cirugiaId = cirugiasEnRango.iterator().next();
                List<Turno> turnosDeCirugia = turnoRepository.findAllByCirugiaId(cirugiaId);
                if (turnosDeCirugia.isEmpty()) {
                    throw new IllegalArgumentException(
                            "La cirugía existente no tiene turnos asignados para sobreescribir.");
                }

                turnosDeCirugia.sort(Comparator.comparing(Turno::getFechaHoraInicio));
                if (turnosDeCirugia.size() < bloquesNecesarios) {
                    throw new IllegalArgumentException(
                            "La cirugía existente no tiene suficientes turnos para cubrir la duración de la urgencia.");
                }

                Cirugia cirugia = cirugiaRepository.findById(cirugiaId)
                        .orElseThrow(() -> new IllegalArgumentException("Cirugía no encontrada con ID: " + cirugiaId));
                cirugia.setEstado(EstadoCirugia.CANCELADA);
                cirugiaRepository.save(cirugia);

                List<Turno> turnosOcupadosPorUrgencia = turnosDeCirugia.subList(0, bloquesNecesarios);
                List<Turno> turnosLiberados = turnosDeCirugia.subList(bloquesNecesarios, turnosDeCirugia.size());

                for (Turno turno : turnosOcupadosPorUrgencia) {
                    turno.setCirugia(null);
                    turno.setUrgencia(urgencia);
                    turno.setEstado("ASIGNADO_URGENCIA");
                }

                for (Turno turno : turnosLiberados) {
                    turno.setCirugia(null);
                    turno.setUrgencia(null);
                    turno.setEstado("DISPONIBLE");
                }

                List<Turno> turnosActualizados = new ArrayList<>(turnosDeCirugia);
                turnoRepository.saveAll(turnosActualizados);
                return turnosOcupadosPorUrgencia.get(0);
            }

            throw new IllegalArgumentException(
                    "No existe una cirugía única para sobreescribir en el rango solicitado.");
        }

        for (Long cirugiaId : cirugiasACancelar) {
            cancelarCirugiaYLiberarTurnos(cirugiaId);
        }

        for (Turno turno : bloquesAAsignar) {
            turno.setCirugia(null);
            turno.setUrgencia(urgencia);
            turno.setEstado("ASIGNADO_URGENCIA");
        }
        turnoRepository.saveAll(bloquesAAsignar);
        return bloquesAAsignar.get(0);
    }

    @Override
    public void borrarTurno(Long cirugiaId) {
        List<Turno> turnos = turnoRepository.findAllByCirugiaId(cirugiaId);
        for (Turno turno : turnos) {
            turno.setEstado("DISPONIBLE");
            turno.setCirugia(null);
            turno.setUrgencia(null);
            turnoRepository.save(turno);
        }
    }

    @Override
    public void borrarTurnosPorUrgencia(Long urgenciaId) {
        List<Turno> turnos = turnoRepository.findAllByUrgenciaId(urgenciaId);
        for (Turno turno : turnos) {
            turno.setEstado("DISPONIBLE");
            turno.setCirugia(null);
            turno.setUrgencia(null);
            turnoRepository.save(turno);
        }
    }

    private void cancelarCirugiaYLiberarTurnos(Long cirugiaId) {
        Cirugia cirugia = cirugiaRepository.findById(cirugiaId)
                .orElseThrow(() -> new IllegalArgumentException("Cirugía no encontrada con ID: " + cirugiaId));
        cirugia.setEstado(EstadoCirugia.CANCELADA);
        cirugiaRepository.save(cirugia);
        borrarTurno(cirugiaId);
    }

    // Método para generar los turnos
    @Override
    public void generarTurnosAutomaticaMensual() {
        // Borrar todos los turnos existentes
        turnoRepository.deleteAll();

        // Obtención de los quirófanos disponibles
        List<Quirofano> quirofanos = quirofanoRepository.findAll();

        // Obtener la fecha y hora actual
        LocalDateTime ahora = LocalDateTime.now();
        LocalDateTime fechaLimite = ahora.plusDays(30);

        // Generar turnos durante los próximos 30 días
        for (LocalDateTime fecha = ahora.truncatedTo(ChronoUnit.DAYS); fecha
                .isBefore(fechaLimite); fecha = fecha.plusDays(1)) {
            LocalDateTime horaInicio = fecha.withHour(8).withMinute(0).withSecond(0).withNano(0); // 8:00 AM
            LocalDateTime horaFin = fecha.withHour(18).withMinute(0).withSecond(0).withNano(0); // 6:00 PM

            while (horaInicio.isBefore(horaFin)) {
                for (Quirofano quirofano : quirofanos) {
                    Turno turno = new Turno();
                    turno.setFechaHoraInicio(horaInicio);
                    turno.setQuirofano(quirofano);
                    turno.setEstado("DISPONIBLE");
                    turno.setCirugia(null);
                    turno.setUrgencia(null);
                    turnoRepository.save(turno);
                }
                horaInicio = horaInicio.plusMinutes(30);
            }
        }
    }
}
