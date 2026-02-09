package com.crispypizza.crispypizza.service;

import com.crispypizza.crispypizza.dataAcces.entity.ProduitEntity;
import com.crispypizza.crispypizza.dataAcces.repository.ProduitRepository;
import com.crispypizza.crispypizza.dataAcces.repository.TypeProduitRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;
import java.util.LinkedHashMap;

@Service
public class MenuService
{
    private final ProduitRepository produitRepository;
    private final TypeProduitRepository typeProduitRepository;


    @Autowired
    public MenuService(ProduitRepository repository, TypeProduitRepository typeRepository)
    {
        produitRepository = repository;
        typeProduitRepository = typeRepository;
    }

    public List<ProduitEntity> getAllProduits(String typeProduit)
    {
        List<ProduitEntity> entities = null;
        if(typeProduit == null)
        {
            entities = produitRepository.findAll();
        }

        // Filtrer les doublons : garder un seul produit par (libelle + typeProduitId)
        if (entities != null)
        {
            entities = entities.stream()
                .collect(Collectors.toMap(
                    p -> p.getLibelle() + "_" + p.getTypeProduit().getId(),  // clé unique
                    p -> p,                                                    // valeur
                    (existing, replacement) -> existing,                       // garder le premier
                    LinkedHashMap::new                                         // préserver l'ordre
                ))
                .values()
                .stream()
                .collect(Collectors.toList());
        }

        return entities;
    }

    public ProduitEntity getProduitById(Integer id)
    {
        return produitRepository.findById(id).orElse(null);
    }
    public List<ProduitEntity> getProduitByLibelle(String libelle)
    {
        return produitRepository.findByLibelle(libelle);
    }

    public String affichePrix(Double prix)
    {
        if (prix == null)
        {
            return "";
        }

        if (prix % 1 == 0)
        {
            return prix.intValue() + "€";
        }
        return prix + "€";
    }
}
