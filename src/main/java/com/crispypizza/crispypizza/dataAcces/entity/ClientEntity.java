package com.crispypizza.crispypizza.dataAcces.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "client")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClientEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "Le nom est obligatoire")
    @Size(min = 2, max = 25, message = "Le nom doit contenir entre 2 et 25 caractères")
    @Column(nullable = false, length = 25)
    private String nom;

    @Size(max = 25, message = "Le prénom ne peut pas dépasser 25 caractères")
    @Column(length = 25)
    private String prenom;

    @NotBlank(message = "Le numéro de téléphone est obligatoire")
    @Pattern(regexp = "^[0-9]{10}$", message = "Le numéro doit contenir 10 chiffres")
    @Column(nullable = false, length = 15)
    private String numero;

    @NotNull(message = "L'adresse est obligatoire")
    @ManyToOne
    @JoinColumn(name = "idadresse", nullable = false)
    private AdresseEntity adresse;
}
