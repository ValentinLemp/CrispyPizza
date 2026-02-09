package com.crispypizza.crispypizza.dataAcces.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "lignecommande")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class LigneCommandeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotNull(message = "La quantité est obligatoire")
    @Positive(message = "La quantité doit être supérieure à 0")
    @Column(nullable = false, name = "quantiteligne")
    private Integer quantiteLigne;

    @NotNull(message = "Le prix de la ligne est obligatoire")
    @PositiveOrZero(message = "Le prix doit être positif ou nul")
    @Column(nullable = false, name = "prixligne")
    private Double prixLigne;

    @Column(name = "estgratiner")
    private Boolean estGratiner;

    @Column(name = "taillemedium")
    private Boolean tailleMedium;

    @Column(name = "typepate")
    private String typePate;

    @ManyToOne
    @JoinColumn(name = "idproduit")
    private ProduitEntity produit;

    @ManyToOne
    @JoinColumn(name = "idcommande")
    private CommandeEntity commande;
}
