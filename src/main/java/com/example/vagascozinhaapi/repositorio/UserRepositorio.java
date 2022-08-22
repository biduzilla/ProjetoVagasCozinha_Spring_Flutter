package com.example.vagascozinhaapi.repositorio;

import com.example.vagascozinhaapi.entidade.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepositorio extends JpaRepository<User, Integer> {
    boolean existsByEmail(String email);

    User findByEmailAndAndPassword(String email, String password);
    Optional<User> findByEmail(String login);

}

