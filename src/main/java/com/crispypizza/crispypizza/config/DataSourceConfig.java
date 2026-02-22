package com.crispypizza.crispypizza.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;

@Configuration
public class DataSourceConfig {

    @Bean
    public JdbcTemplate ramilliesJdbcTemplate(
            @Value("${datasource.ramillies.url}") String url,
            @Value("${datasource.ramillies.username}") String username,
            @Value("${datasource.ramillies.password}") String password,
            @Value("${datasource.ramillies.driver-class-name}") String driver) {
        return new JdbcTemplate(DataSourceBuilder.create()
                .url(url)
                .username(username)
                .password(password)
                .driverClassName(driver)
                .build());
    }

    @Bean
    public JdbcTemplate meuxJdbcTemplate(
            @Value("${datasource.meux.url}") String url,
            @Value("${datasource.meux.username}") String username,
            @Value("${datasource.meux.password}") String password,
            @Value("${datasource.meux.driver-class-name}") String driver) {
        return new JdbcTemplate(DataSourceBuilder.create()
                .url(url)
                .username(username)
                .password(password)
                .driverClassName(driver)
                .build());
    }
}
