package com.crispypizza.crispypizza.dataAcces.repository;

import com.crispypizza.crispypizza.dataAcces.entity.ProduitEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProduitRepository extends JpaRepository<ProduitEntity, Integer> {
    List<ProduitEntity> findAll();
    List<ProduitEntity> findByLibelle(String libelle);
}
