package com.crispypizza.crispypizza.dataAcces.repository;

import com.crispypizza.crispypizza.dataAcces.entity.CommandeEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommandeRepository extends JpaRepository<CommandeEntity, Integer> {
}
