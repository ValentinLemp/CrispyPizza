package com.crispypizza.crispypizza.dataAcces.repository;

import com.crispypizza.crispypizza.dataAcces.entity.AdresseEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AdresseRepository extends JpaRepository<AdresseEntity, Integer> {
}
