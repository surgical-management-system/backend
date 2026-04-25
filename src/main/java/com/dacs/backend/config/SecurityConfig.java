package com.dacs.backend.config;

import java.util.Collection;
import java.util.Collections;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableMethodSecurity(prePostEnabled = true)
public class SecurityConfig {

	@Bean
	public JwtAuthenticationConverter jwtAuthenticationConverter() {
		JwtAuthenticationConverter converter = new JwtAuthenticationConverter();
		converter.setJwtGrantedAuthoritiesConverter(this::extractRolesFromKeycloak);
		converter.setPrincipalClaimName("preferred_username");
		return converter;
	}

	private Collection<GrantedAuthority> extractRolesFromKeycloak(Jwt jwt) {
		if (jwt.hasClaim("realm_access")) {
			Object realmAccessClaim = jwt.getClaim("realm_access");
			if (realmAccessClaim instanceof Map<?, ?> realmAccess) {
				Object rolesClaim = realmAccess.get("roles");
				if (rolesClaim instanceof Collection<?> roles) {
					return roles.stream()
							.filter(String.class::isInstance)
							.map(String.class::cast)
							.map(role -> new SimpleGrantedAuthority("ROLE_" + role))
							.collect(Collectors.toList());
				}
			}
		}
		return Collections.emptyList();
	}


	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.csrf(csrf -> csrf.disable())
				.sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
				.authorizeHttpRequests(authorize -> authorize
						.requestMatchers(HttpMethod.OPTIONS, "/**").permitAll()
						.requestMatchers("/metrics/health", "/metrics/info", "/actuator/**", "/error", "/ping", "/version", "/conectorping", "/backendping").permitAll()
						.requestMatchers("/turnos/generar-turnos").permitAll()
						.anyRequest().authenticated()
				)
				.oauth2ResourceServer(oauth2 -> oauth2
						.jwt(jwt -> jwt.jwtAuthenticationConverter(jwtAuthenticationConverter()))
				);

		return http.build();
	}

}
