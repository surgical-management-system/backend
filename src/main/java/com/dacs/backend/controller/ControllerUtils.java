package com.dacs.backend.controller;

import java.time.LocalDate;

/**
 * Shared parsing helpers for controllers.
 */
public final class ControllerUtils {

    private ControllerUtils() {
    }

    public static LocalDate parseFecha(String fecha) {
        if (fecha == null || fecha.isBlank()) {
            return null;
        }
        return LocalDate.parse(fecha);
    }

    public static <E extends Enum<E>> E parseEstado(String estado, Class<E> enumType) {
        if (estado == null || estado.isBlank()) {
            return null;
        }

        try {
            return Enum.valueOf(enumType, estado.trim().toUpperCase());
        } catch (IllegalArgumentException ex) {
            return null;
        }
    }
}
