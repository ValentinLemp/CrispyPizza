package com.crispypizza.crispypizza.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/livraison")
public class LivraisonController
{
    @GetMapping
    public String livraison(Model model)
    {
        return "livraison";
    }
}
