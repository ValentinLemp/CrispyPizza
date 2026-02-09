package com.crispypizza.crispypizza.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/commande")
public class CommandeController
{
    @GetMapping
    public String commande(Model model)
    {
        return "commande";
    }
}
