package com.example.vagascozinhaapi.repositorio;

import com.example.vagascozinhaapi.entidade.User;
import com.example.vagascozinhaapi.entidade.Vaga;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface UserRepositorio extends JpaRepository<User, Integer> {
    boolean existsByEmail(String email);

    User findByEmailAndAndPassword(String email, String password);
    Optional<User> findByEmail(String login);

}

