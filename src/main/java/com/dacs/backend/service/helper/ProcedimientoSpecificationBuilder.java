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
import java.util.List;

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
        if (username == null || username.isBlank()) {
            return (root, query, cb) -> cb.conjunction();
        }

        String normalizedUsername = username.toLowerCase();
        return (root, query, cb) -> {
            Subquery<Long> subquery = query.subquery(Long.class);
            var equipoRoot = subquery.from(EquipoMedico.class);
            var personalJoin = equipoRoot.join("personal");

            subquery.select(cb.literal(1L));
            subquery.where(
                    cb.equal(equipoRoot.get("cirugia"), root),
                    cb.equal(cb.lower(personalJoin.get("legajo")), normalizedUsername));

            return cb.exists(subquery);
        };
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
        predicates.add(cb.like(cb.lower(cb.coalesce(root.get("estado").as(String.class), "")), likePattern));
        predicates.add(cb.like(cb.lower(cb.coalesce(root.get("tipo"), "")), likePattern));
        predicates.add(cb.like(cb.lower(cb.coalesce(root.get(priorityField).as(String.class), "")), likePattern));
        predicates.add(cb.like(cb.lower(cb.coalesce(quirofanoJoin.get("nombre"), "")), likePattern));

        return cb.or(predicates.toArray(new Predicate[0]));
    }
}
