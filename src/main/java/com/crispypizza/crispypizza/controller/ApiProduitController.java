package com.crispypizza.crispypizza.controller;

import com.crispypizza.crispypizza.dataAcces.entity.ProduitEntity;
import com.crispypizza.crispypizza.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/produit")
public class ApiProduitController
{
    private final MenuService menuService;

    @Autowired
    public ApiProduitController(MenuService menuService)
    {
        this.menuService = menuService;
    }

    @GetMapping("/id/{id}")
    public ResponseEntity<ProduitEntity> getProduitById(@PathVariable Integer id)
    {
        ProduitEntity produit = menuService.getProduitById(id);

        if (produit == null)
        {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(produit);
    }

    @GetMapping("/libelle/{libelle}")
    public ResponseEntity<List<ProduitEntity>> getProduitByLibelle(@PathVariable String libelle)
    {
        List<ProduitEntity> produits = menuService.getProduitByLibelle(libelle);

        if (produits == null)
        {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(produits);
    }


}
