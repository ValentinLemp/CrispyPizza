package com.crispypizza.crispypizza.dataAcces.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "ingredient")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class IngredientEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "Le libellé est obligatoire")
    @Size(max = 40, message = "Le libellé ne peut pas dépasser 40 caractères")
    @Column(nullable = false, length = 40)
    private String libelle;

    @NotNull(message = "Le prix medium est obligatoire")
    @PositiveOrZero(message = "Le prix medium doit être positif ou nul")
    @Column(nullable = false, name = "prixmedium")
    private Double prixMedium;

    @NotNull(message = "Le prix large est obligatoire")
    @PositiveOrZero(message = "Le prix large doit être positif ou nul")
    @Column(nullable = false, name = "prixlarge")
    private Double prixLarge;

    @NotNull(message = "Le statut de forpizza est obligatoire")
    @Column(nullable = false, name = "forpizza")
    private Boolean forPizza;

    @NotNull(message = "Le statut de forpate est obligatoire")
    @Column(nullable = false, name = "forpate")
    private Boolean forPate;

    @NotNull(message = "Le statut de forsalade est obligatoire")
    @Column(nullable = false, name = "forsalade")
    private Boolean forSalade;

    @ManyToOne
    @JoinColumn(name = "idcategorieingredient")
    private CategorieIngredientEntity categorieIngredient;
}
