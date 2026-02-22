package com.crispypizza.crispypizza.service;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

@Service
public class CommandeService {

    private final JdbcTemplate ramilliesJdbcTemplate;
    private final JdbcTemplate meuxJdbcTemplate;

    public CommandeService(
            @Qualifier("ramilliesJdbcTemplate") JdbcTemplate ramilliesJdbcTemplate,
            @Qualifier("meuxJdbcTemplate") JdbcTemplate meuxJdbcTemplate) {
        this.ramilliesJdbcTemplate = ramilliesJdbcTemplate;
        this.meuxJdbcTemplate = meuxJdbcTemplate;
    }

    private JdbcTemplate getJdbcTemplate(int restaurantId) {
        return restaurantId == 1 ? ramilliesJdbcTemplate : meuxJdbcTemplate;
    }

    public void sauvegarderCommande(Map<String, Object> paymentData) {
        int restaurantId = Integer.parseInt(paymentData.get("restaurant").toString());
        JdbcTemplate jdbc = getJdbcTemplate(restaurantId);

        String nom = paymentData.get("nom").toString();
        String prenom = paymentData.get("prenom") != null ? paymentData.get("prenom").toString() : "";
        String heure = paymentData.get("heure") != null ? paymentData.get("heure").toString() : null;
        String commentaire = paymentData.get("commentaire") != null ? paymentData.get("commentaire").toString() : "";
        double prixTotal = Double.parseDouble(paymentData.get("total").toString());
        List<Map<String, Object>> articles = (List<Map<String, Object>>) paymentData.get("articles");

        // dateHeure = aujourd'hui + heure sélectionnée
        LocalDateTime dateHeure;
        if (heure != null && !heure.isEmpty()) {
            dateHeure = LocalDateTime.of(LocalDate.now(), LocalTime.parse(heure));
        } else {
            dateHeure = LocalDateTime.now();
        }

        // numeroCommande = nombre de lignes + 1
        Integer count = jdbc.queryForObject("SELECT COUNT(*) FROM commande", Integer.class);
        int numeroCommande = (count != null ? count : 0) + 1;

        // INSERT commande
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbc.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(
                    "INSERT INTO commande (numeroCommande, nom, prenom, estLivraison, dateHeure, prixTotal, commentaire, idStatut, idClient, estVu, estCloture) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, numeroCommande);
            ps.setString(2, nom);
            ps.setString(3, prenom);
            ps.setBoolean(4, false);
            ps.setTimestamp(5, Timestamp.valueOf(dateHeure));
            ps.setDouble(6, prixTotal);
            ps.setString(7, commentaire);
            ps.setInt(8, 2);
            ps.setNull(9, java.sql.Types.INTEGER);
            ps.setBoolean(10, false);
            ps.setBoolean(11, false);
            return ps;
        }, keyHolder);

        int commandeId = keyHolder.getKey().intValue();

        // INSERT lignecommande pour chaque article
        for (Map<String, Object> article : articles) {
            int produitId = ((Number) article.get("id")).intValue();
            int quantite = ((Number) article.get("quantite")).intValue();
            double prixUnitaire = ((Number) article.get("prixUnitaire")).doubleValue();
            boolean isLarge = article.get("isLarge") != null && (boolean) article.get("isLarge");
            int typeProduitId = article.get("typeProduitId") != null ? ((Number) article.get("typeProduitId")).intValue() : 0;

            // typePate : seulement pour les pâtes (typeProduitId == 2), avec espace à la fin
            String typePate = "";
            if (typeProduitId == 2 && article.get("taille") != null && !article.get("taille").toString().isEmpty()) {
                typePate = article.get("taille").toString() + " ";
            }

            // prixProduit = prixUnitaire + somme des ingrédients ajoutés
            double prixSupplements = 0;
            List<Map<String, Object>> ingredientsAjoutes = (List<Map<String, Object>>) article.get("ingredientsAjoutes");
            if (ingredientsAjoutes != null) {
                for (Map<String, Object> ing : ingredientsAjoutes) {
                    if (ing.get("prix") != null) {
                        prixSupplements += ((Number) ing.get("prix")).doubleValue();
                    }
                }
            }
            double prixProduit = prixUnitaire + prixSupplements;

            List<Map<String, Object>> ingredientsEnleves = (List<Map<String, Object>>) article.get("ingredientsEnleves");

            // Créer une ligne par unité (quantite fois)
            for (int i = 0; i < quantite; i++) {
                KeyHolder ligneKeyHolder = new GeneratedKeyHolder();
                final double finalPrixProduit = prixProduit;
                final boolean finalIsLarge = isLarge;
                final String finalTypePate = typePate;

                jdbc.update(connection -> {
                    PreparedStatement ps = connection.prepareStatement(
                            "INSERT INTO lignecommande (prixProduit, tailleLarge, typePate, note, idProduit, idCommande) " +
                            "VALUES (?, ?, ?, ?, ?, ?)",
                            Statement.RETURN_GENERATED_KEYS);
                    ps.setDouble(1, finalPrixProduit);
                    ps.setBoolean(2, finalIsLarge);
                    ps.setString(3, finalTypePate);
                    ps.setString(4, "");
                    ps.setInt(5, produitId);
                    ps.setInt(6, commandeId);
                    return ps;
                }, ligneKeyHolder);

                int ligneId = ligneKeyHolder.getKey().intValue();

                // INSERT ligneingredient pour les ingrédients ajoutés
                if (ingredientsAjoutes != null) {
                    for (Map<String, Object> ing : ingredientsAjoutes) {
                        String ingredientNom = ing.get("libelle").toString();
                        jdbc.update(
                                "INSERT INTO ligneingredient (idLigne, ingredient, ingredientEnPlus) VALUES (?, ?, ?)",
                                ligneId, ingredientNom, true);
                    }
                }

                // INSERT ligneingredient pour les ingrédients enlevés
                if (ingredientsEnleves != null) {
                    for (Map<String, Object> ing : ingredientsEnleves) {
                        String ingredientNom = ing.get("libelle").toString();
                        jdbc.update(
                                "INSERT INTO ligneingredient (idLigne, ingredient, ingredientEnPlus) VALUES (?, ?, ?)",
                                ligneId, ingredientNom, false);
                    }
                }
            }
        }
    }
}
