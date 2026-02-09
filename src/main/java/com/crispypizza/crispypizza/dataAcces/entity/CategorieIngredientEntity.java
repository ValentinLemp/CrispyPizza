package com.crispypizza.crispypizza.dataAcces.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "categorieingredient")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CategorieIngredientEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Size(max = 20, message = "Le libellé ne peut pas dépasser 20 caractères")
    @Column(length = 20)
    private String libelle;
}
