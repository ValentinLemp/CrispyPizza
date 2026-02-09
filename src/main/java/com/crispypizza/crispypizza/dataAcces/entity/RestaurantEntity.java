package com.crispypizza.crispypizza.dataAcces.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "restaurant")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RestaurantEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "Le nom du restaurant est obligatoire")
    @Size(max = 20, message = "Le nom ne peut pas dépasser 20 caractères")
    @Column(nullable = false, length = 20)
    private String nom;

    @NotNull(message = "L'adresse est obligatoire")
    @ManyToOne
    @JoinColumn(name = "idadresse", nullable = false)
    private AdresseEntity adresse;
}
