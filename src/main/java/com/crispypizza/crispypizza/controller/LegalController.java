package com.crispypizza.crispypizza.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LegalController {

    @GetMapping("/mentions-legales")
    public String mentionsLegales() {
        return "mentions-legales";
    }

    @GetMapping("/cgv")
    public String cgv() {
        return "cgv";
    }

    @GetMapping("/confidentialite")
    public String confidentialite() {
        return "confidentialite";
    }
}
