package com.dacs.backend.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;

@Configuration
public class KeycloakConfig {

    @Value("${KEYCLOAK_ISSUER_URI:http://localhost:8080/realms/dacs}")
    private String issuerUri;

    @Bean
    public JwtDecoder jwtDecoder() {
        String jwkSetUri = issuerUri.replaceAll("/$", "") + "/protocol/openid-connect/certs";
        return NimbusJwtDecoder.withJwkSetUri(jwkSetUri).build();
    }
}