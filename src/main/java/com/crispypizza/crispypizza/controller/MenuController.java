package com.crispypizza.crispypizza.controller;

import com.crispypizza.crispypizza.dataAcces.entity.ProduitEntity;
import com.crispypizza.crispypizza.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/menu")
public class MenuController
{
    private final MenuService service;

    @Autowired
    public MenuController(MenuService menuService)
    {
        service = menuService;
    }

    @GetMapping
    public String menu(Model model)
    {
        String libelle = null;
        List<ProduitEntity> entities = service.getAllProduits(libelle);

        List<ProduitEntity> produitPizzas = new ArrayList<>();
        List<ProduitEntity> produitPates = new ArrayList<>();
        List<ProduitEntity> produitSalades = new ArrayList<>();
        List<ProduitEntity> produitPains = new ArrayList<>();
        List<ProduitEntity> produitSnackings = new ArrayList<>();
        List<ProduitEntity> produitDesserts = new ArrayList<>();
        List<ProduitEntity> produitBoissons = new ArrayList<>();
        List<ProduitEntity> produitDipys = new ArrayList<>();

        for(ProduitEntity entity : entities)
        {
            if(entity.getTypeProduit().getId() == 1)
            {
                produitPizzas.add(entity);
            }
            if(entity.getTypeProduit().getId() == 2)
            {
                produitPates.add(entity);
            }
            if(entity.getTypeProduit().getId() == 3)
            {
                produitSalades.add(entity);
            }
            if(entity.getTypeProduit().getId() == 4)
            {
                produitPains.add(entity);
            }
            if(entity.getTypeProduit().getId() == 5)
            {
                produitSnackings.add(entity);
            }
            if(entity.getTypeProduit().getId() == 6)
            {
                produitDesserts.add(entity);
            }
            if(entity.getTypeProduit().getId() == 7)
            {
                produitBoissons.add(entity);
            }
            if(entity.getTypeProduit().getId() == 8)
            {
                produitDipys.add(entity);
            }
        }
        model.addAttribute("produitPizzas", produitPizzas);
        model.addAttribute("produitPates", produitPates);
        model.addAttribute("produitSalades", produitSalades);
        model.addAttribute("produitPains", produitPains);
        model.addAttribute("produitSnackings", produitSnackings);
        model.addAttribute("produitDesserts", produitDesserts);
        model.addAttribute("produitBoissons", produitBoissons);
        model.addAttribute("produitDipys", produitDipys);
        model.addAttribute("menuService", service);

        return "menu";
    }
}
