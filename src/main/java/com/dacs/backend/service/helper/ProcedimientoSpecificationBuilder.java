package com.dacs.backend.service.helper;

import com.dacs.backend.model.entity.EquipoMedico;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;
import jakarta.persistence.criteria.Subquery;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

@Component
public class ProcedimientoSpecificationBuilder {

    public <T> Specification<T> build(LocalDate fechaInicio, LocalDate fechaFin, Object estado, String search) {
        return build(fechaInicio, fechaFin, estado, search, "prioridad");
    }

    public <T> Specification<T> build(LocalDate fechaInicio, LocalDate fechaFin, Object estado, String search,
            String priorityField) {
        return (root, query, cb) -> {
            query.distinct(true);
            List<Predicate> predicates = new ArrayList<>();

            if (fechaInicio != null) {
                predicates.add(cb.greaterThanOrEqualTo(root.get("fechaHoraInicio"), fechaInicio.atStartOfDay()));
            }

            if (fechaFin != null) {
                predicates.add(cb.lessThanOrEqualTo(root.get("fechaHoraInicio"), fechaFin.atTime(23, 59, 59)));
            }

            if (estado != null) {
                predicates.add(cb.equal(root.get("estado"), estado));
            }

            if (search != null && !search.isBlank()) {
                predicates.add(buildSearchPredicate(root, cb, search, priorityField));
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }

    public Specification<com.dacs.backend.model.entity.Cirugia> assignedToMedicalStaff(String username) {
        return assignedToMedicalStaffByField(username, "cirugia");
    }

    public Specification<com.dacs.backend.model.entity.Urgencia> assignedToMedicalStaffUrgencia(String username) {
        return assignedToMedicalStaffByField(username, "urgencia");
    }

    private <T> Specification<T> assignedToMedicalStaffByField(String username, String relationField) {
        Set<String> candidates = buildUsernameCandidates(username);
        if (candidates.isEmpty()) {
            // Missing user identity should never return all surgeries for medical users.
            return (root, query, cb) -> cb.disjunction();
        }

        return (root, query, cb) -> {
            Subquery<Long> subquery = query.subquery(Long.class);
            var equipoRoot = subquery.from(EquipoMedico.class);
            var personalJoin = equipoRoot.join("personal");

            subquery.select(cb.literal(1L));
            Predicate[] candidatePredicates = candidates.stream()
                    .map(candidate -> cb.equal(cb.lower(personalJoin.get("legajo")), candidate))
                    .toArray(Predicate[]::new);

            subquery.where(
                    cb.equal(equipoRoot.get(relationField), root),
                    cb.or(candidatePredicates));

            return cb.exists(subquery);
        };
    }

    private Set<String> buildUsernameCandidates(String username) {
        Set<String> candidates = new LinkedHashSet<>();
        if (username == null || username.isBlank()) {
            return candidates;
        }

        String normalized = username.trim().toLowerCase(Locale.ROOT);
        candidates.add(normalized);

        int atIndex = normalized.indexOf('@');
        if (atIndex > 0) {
            candidates.add(normalized.substring(0, atIndex));
        }

        return candidates;
    }

    private <T> Predicate buildSearchPredicate(Root<T> root, CriteriaBuilder cb, String search, String priorityField) {
        String likePattern = "%" + search.trim().toLowerCase() + "%";

        var pacienteJoin = root.join("paciente", jakarta.persistence.criteria.JoinType.LEFT);
        var servicioJoin = root.join("servicio", jakarta.persistence.criteria.JoinType.LEFT);
        var quirofanoJoin = root.join("quirofano", jakarta.persistence.criteria.JoinType.LEFT);

        List<Predicate> predicates = new ArrayList<>();
        predicates.add(cb.like(cb.lower(cb.coalesce(pacienteJoin.get("nombre"), "")), likePattern));
        predicates.add(cb.like(cb.lower(cb.coalesce(pacienteJoin.get("apellido"), "")), likePattern));
        predicates.add(cb.like(cb.lower(cb.coalesce(pacienteJoin.get("dni"), "")), likePattern));
        predicates.add(cb.like(cb.lower(cb.coalesce(servicioJoin.get("nombre"), "")), likePattern));
        predicates.add(cb.like(cb.lower(root.get("estado").as(String.class)), likePattern));
        predicates.add(cb.like(cb.lower(cb.coalesce(root.get("tipo"), "")), likePattern));
        Class<?> priorityJavaType = root.get(priorityField).getJavaType();
        if (Number.class.isAssignableFrom(priorityJavaType)
                || priorityJavaType == int.class
                || priorityJavaType == long.class
                || priorityJavaType == short.class) {
            Integer numericSearch = tryParseInteger(search);
            if (numericSearch != null) {
                predicates.add(cb.equal(root.get(priorityField), numericSearch));
            }
        } else {
            predicates.add(cb.like(cb.lower(root.get(priorityField).as(String.class)), likePattern));
        }
        predicates.add(cb.like(cb.lower(cb.coalesce(quirofanoJoin.get("nombre"), "")), likePattern));

        return cb.or(predicates.toArray(new Predicate[0]));
    }

    private Integer tryParseInteger(String value) {
        try {
            return Integer.valueOf(value.trim());
        } catch (NumberFormatException ex) {
            return null;
        }
    }
}
