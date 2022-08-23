package com.example.vagascozinhaapi.repositorio;

import com.example.vagascozinhaapi.entidade.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepositorio extends JpaRepository<Usuario, Integer> {
    boolean existsByEmail(String email);

    Usuario findByEmailAndAndPassword(String email, String password);
    Optional<Usuario> findByEmail(String login);

}

