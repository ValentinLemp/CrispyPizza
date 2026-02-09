package com.crispypizza.crispypizza.dataAcces.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "ligneingrediant")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class LigneIngrediantEntity
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @NotNull(message = "la ligne doit obligatoirement être lier")
    @JoinColumn(name = "idligne")
    private LigneCommandeEntity ligne;

    @ManyToOne
    @NotNull(message = "le type d'ingredient doit être obligatoirement")
    @JoinColumn(name = "idingredient")
    private IngredientEntity ingredient;

    @NotNull(message = "L'ingrédient doit obligatoirement être enlever ou ajouter")
    @Column(nullable = false, name = "ingredientenplus")
    private Boolean ingrediendEnPlus;
}
