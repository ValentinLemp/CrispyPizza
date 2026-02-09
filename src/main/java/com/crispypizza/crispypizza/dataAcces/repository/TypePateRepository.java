package com.crispypizza.crispypizza.dataAcces.repository;

import com.crispypizza.crispypizza.dataAcces.entity.TypePateEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TypePateRepository extends JpaRepository<TypePateEntity, Integer> {
}
