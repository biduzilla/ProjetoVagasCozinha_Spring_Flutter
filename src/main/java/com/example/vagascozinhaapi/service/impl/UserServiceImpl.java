package com.example.vagascozinhaapi.service.impl;

import com.example.vagascozinhaapi.Exception.RegrasNegocioException;
import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.entidade.User;
import com.example.vagascozinhaapi.repositorio.UserRepositorio;
import com.example.vagascozinhaapi.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepositorio userRepositorio;

    @Override
    public User salvarUser(User user) {
        return userRepositorio.save(user);
    }

    @Override
    public User getUserById(Integer id) {
        return userRepositorio.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Pedido Não Encontrado"));
    }

    @Override
    public List<User> getUser() {
        return userRepositorio.findAll();
    }
}
