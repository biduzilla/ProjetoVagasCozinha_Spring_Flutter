package com.example.vagascozinhaapi.repositorio;

import com.example.vagascozinhaapi.entidade.Vaga;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VagasRepository extends JpaRepository<Vaga, Integer> {
}
