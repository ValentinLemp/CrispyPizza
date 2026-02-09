package com.crispypizza.crispypizza.dataAcces.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "produit")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProduitEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Size(max = 40, message = "Le libellé ne peut pas dépasser 40 caractères")
    @Column(name = "libelle", length = 40)
    private String libelle;

    @Size(max = 150, message = "La description ne peut pas dépasser 150 caractères")
    @Column(name = "description", length = 150)
    private String description;

    @PositiveOrZero(message = "La quantité doit être positive ou nulle")
    @Column(name = "quantite")
    private Integer quantite;

    @PositiveOrZero(message = "Le prix doit être positif ou nul")
    @Column(name = "prix")
    private Double prix;

    @PositiveOrZero(message = "Le prix large doit être positif ou nul")
    @Column(name = "prixlarge")
    private Double prixLarge;

    @Size(max = 10, message = "Le centilitre ne peut pas dépasser 10 caractères")
    @Column(name = "centilitre", length = 10)
    private String centilitre;

    @Size(max = 100, message = "L'URL de l'image ne peut pas dépasser 100 caractères")
    @Column(name = "urlimage", length = 100)
    private String urlImage;

    @ManyToOne
    @JoinColumn(name = "idtypepizza")
    private TypePizzaEntity typePizza;

    @ManyToOne
    @JoinColumn(name = "idtypeproduit")
    private TypeProduitEntity typeProduit;

    @NotNull(message = "Le champ suggestsion est obligatoire")
    @Column(name = "estsuggestion")
    private Boolean estSuggestion;
}
