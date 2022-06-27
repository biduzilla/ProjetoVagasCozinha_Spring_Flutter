package com.example.vagascozinhaapi.repositorio;

import com.example.vagascozinhaapi.entidade.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepositorio extends JpaRepository<User, Integer> {
}
