package com.crispypizza.crispypizza.dataAcces.repository;

import com.crispypizza.crispypizza.dataAcces.entity.TypeProduitEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TypeProduitRepository extends JpaRepository<TypeProduitEntity, Integer> {
    TypeProduitEntity findByLibelle(String libelle);
}
