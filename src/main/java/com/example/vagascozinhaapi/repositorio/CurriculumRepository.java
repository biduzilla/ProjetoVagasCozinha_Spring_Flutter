package com.example.vagascozinhaapi.repositorio;

import com.example.vagascozinhaapi.entidade.Curriculum;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CurriculumRepository extends JpaRepository<Curriculum, Integer> {
}
