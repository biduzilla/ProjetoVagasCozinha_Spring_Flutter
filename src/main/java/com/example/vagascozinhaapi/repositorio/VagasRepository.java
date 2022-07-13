package com.example.vagascozinhaapi.repositorio;

import com.example.vagascozinhaapi.entidade.Vaga;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VagasRepository extends JpaRepository<Vaga, Integer> {
    List<Vaga> findAllByUserId(Integer id);
}
