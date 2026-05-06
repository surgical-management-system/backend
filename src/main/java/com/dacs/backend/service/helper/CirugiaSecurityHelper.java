package com.dacs.backend.service.helper;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Component;

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
                .collect(Collectors.toSet());

        if (roles.contains("ROLE_admin")) {
            return false;
        }

        return roles.contains("ROLE_personal_medico");
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

        String username = authentication.getName();
        if (username != null && !username.isBlank()) {
            return username;
        }

        Object principal = authentication.getPrincipal();
        if (principal instanceof Jwt jwt) {
            return jwt.getClaimAsString("preferred_username");
        }

        return null;
    }
}
