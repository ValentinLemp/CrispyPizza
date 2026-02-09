package com.crispypizza.crispypizza.dataAcces.repository;

import com.crispypizza.crispypizza.dataAcces.entity.IngredientEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IngredientRepository extends JpaRepository<IngredientEntity, Integer> {
    List<IngredientEntity> findByCategorieIngredientId(Integer categorieId);
    List<IngredientEntity> findByForPizzaTrue();
    List<IngredientEntity> findByForPateTrue();
    List<IngredientEntity> findByForSaladeTrue();
}
