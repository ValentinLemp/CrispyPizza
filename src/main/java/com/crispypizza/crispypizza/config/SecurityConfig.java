package com.crispypizza.crispypizza.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig
{
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception
    {
        http
            // Autoriser toutes les pages (pas de login pour l'instant)
            .authorizeHttpRequests(auth -> auth
                .anyRequest().permitAll()
            )
            // Désactiver le formulaire de login par défaut
            .formLogin(form -> form.disable())
            // Désactiver HTTP Basic
            .httpBasic(basic -> basic.disable())
            // CSRF activé par défaut - protection contre les attaques CSRF
            .csrf(csrf -> csrf
                .ignoringRequestMatchers("/api/**") // Désactiver CSRF pour les API REST si besoin
            );

        return http.build();
    }
}
