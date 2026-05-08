package com.dacs.backend.service.helper;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Component;

import java.util.Locale;
import java.util.Set;
import java.util.stream.Collectors;

@Component
public class CirugiaSecurityHelper {

    /**
     * Determina si se debe filtrar las cirugías por personal asignado.
     * Administrativos ven todas las cirugías; personal médico solo ve sus asignadas.
     * 
     * @return true si el usuario es personal médico (no admin)
     */
    public boolean shouldFilterToAssignedSurgeries() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            return false;
        }

        Set<String> roles = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .map(role -> role == null ? "" : role.toLowerCase(Locale.ROOT))
                .collect(Collectors.toSet());

        if (roles.contains("role_admin")) {
            return false;
        }

        return roles.contains("role_personal_medico");
    }

    /**
     * Obtiene el username actual del usuario autenticado.
     * Primero intenta obtenerlo del Authentication.getName(), luego del JWT.
     *
     * @return el username actual, o null si no disponible
     */
    public String getCurrentUsername() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) {
            return null;
        }

        Object principal = authentication.getPrincipal();
        if (principal instanceof Jwt jwt) {
            String legajo = jwt.getClaimAsString("legajo");
            if (legajo != null && !legajo.isBlank()) {
                return legajo;
            }

            String preferredUsername = jwt.getClaimAsString("preferred_username");
            if (preferredUsername != null && !preferredUsername.isBlank()) {
                return preferredUsername;
            }
        }

        String username = authentication.getName();
        if (username != null && !username.isBlank()) {
            return username;
        }

        return null;
    }
}
