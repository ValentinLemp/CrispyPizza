package com.crispypizza.crispypizza.dataAcces.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "statut")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class StatutEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Size(max = 15, message = "Le libellé ne peut pas dépasser 15 caractères")
    @Column(length = 15)
    private String libelle;
}
