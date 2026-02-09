package com.crispypizza.crispypizza.dataAcces.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "typepate")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TypePateEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "Le libellé est obligatoire")
    @Size(max = 20, message = "Le libellé ne peut pas dépasser 20 caractères")
    @Column(nullable = false, length = 20)
    private String libelle;
}
