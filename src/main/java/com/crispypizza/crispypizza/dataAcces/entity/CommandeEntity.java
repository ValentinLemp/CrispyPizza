package com.crispypizza.crispypizza.dataAcces.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "commande")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommandeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotNull(message = "Le type de commande (livraison/emporter) est obligatoire")
    @Column(nullable = false, name = "estlivraison")
    private Boolean estLivraison;

    @NotBlank(message = "La date et heure sont obligatoires")
    @Size(max = 20, message = "La date/heure ne peut pas dépasser 20 caractères")
    @Column(nullable = false, length = 20, name = "dateheure")
    private String dateHeure;

    @NotNull(message = "Le statut de paiement est obligatoire")
    @Column(nullable = false, name = "estpayer")
    private Boolean estPayer;

    @NotNull(message = "Le prix total est obligatoire")
    @Positive(message = "Le prix total doit être positif")
    @Column(nullable = false, name = "prixtotal")
    private Double prixTotal;

    @Size(max = 255, message = "le commentaire ne peut dépasser 255 caractère")
    @Column(name = "commentaire", length = 255)
    private String commentaire;

    @NotNull(message = "Le restaurant est obligatoire")
    @ManyToOne
    @JoinColumn(name = "idrestaurant", nullable = false)
    private RestaurantEntity restaurant;

    @NotNull(message = "Le statut est obligatoire")
    @ManyToOne
    @JoinColumn(name = "idstatut", nullable = false)
    private StatutEntity statut;

    @ManyToOne
    @JoinColumn(name = "idclient")
    private ClientEntity client;

    @ManyToOne
    @JoinColumn(name = "idtypepayement")
    private TypePayementEntity typePayement;
}
