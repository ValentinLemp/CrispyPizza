package com.crispypizza.crispypizza.dataAcces.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "adresse")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdresseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotNull(message = "Le code postal est obligatoire")
    @Min(value = 1000, message = "Code postal invalide")
    @Max(value = 9999, message = "Code postal invalide")
    @Column(name = "codepostal", nullable = false)
    private Integer codePostal;

    @NotBlank(message = "Le nom de rue est obligatoire")
    @Size(max = 25, message = "Le nom de rue ne peut pas dépasser 25 caractères")
    @Column(name = "nomrue", nullable = false, length = 25)
    private String nomRue;

    @NotBlank(message = "Le numéro de rue est obligatoire")
    @Size(max = 10, message = "Le numéro de rue ne peut pas dépasser 10 caractères")
    @Column(name = "numerorue", nullable = false, length = 10)
    private String numeroRue;

    @NotBlank(message = "La localité est obligatoire")
    @Size(max = 25, message = "La localité ne peut pas dépasser 25 caractères")
    @Column(nullable = false, length = 25)
    private String localite;
}
