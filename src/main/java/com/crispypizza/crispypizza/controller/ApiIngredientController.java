package com.crispypizza.crispypizza.controller;

import com.crispypizza.crispypizza.dataAcces.entity.IngredientEntity;
import com.crispypizza.crispypizza.dataAcces.repository.IngredientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/ingredient")
public class ApiIngredientController
{
    private final IngredientRepository ingredientRepository;

    @Autowired
    public ApiIngredientController(IngredientRepository ingredientRepository)
    {
        this.ingredientRepository = ingredientRepository;
    }

    @GetMapping("/pizza")
    public ResponseEntity<List<IngredientEntity>> getIngredientsPizza()
    {
        List<IngredientEntity> ingredients = ingredientRepository.findByForPizzaTrue();
        return ResponseEntity.ok(ingredients);
    }

    @GetMapping("/pate")
    public ResponseEntity<List<IngredientEntity>> getIngredientsPate()
    {
        List<IngredientEntity> ingredients = ingredientRepository.findByForPateTrue();
        return ResponseEntity.ok(ingredients);
    }

    @GetMapping("/salade")
    public ResponseEntity<List<IngredientEntity>> getIngredientsSalade()
    {
        List<IngredientEntity> ingredients = ingredientRepository.findByForSaladeTrue();
        return ResponseEntity.ok(ingredients);
    }
}
