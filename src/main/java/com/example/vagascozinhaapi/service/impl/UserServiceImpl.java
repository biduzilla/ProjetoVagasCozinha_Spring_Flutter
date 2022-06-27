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
    public UserDto salvarUser(User user) {
        userRepositorio.save(user);
        UserDto userDto = new UserDto();
        userDto.setEmail(user.getEmail());
        userDto.setIdUser(user.getId());
        return userDto;
    }

    @Override
    public User getUserById(Integer id) {
        return userRepositorio.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Pedido Não Encontrado"));
    }

    @Override
    public List<UserDto> getUser() {

        List<UserDto> userDto = [];
        return userDto;
    }

    @Override
    public void deleteUser(Integer id) {
        userRepositorio.findById(id)
                .map(user -> {
                    userRepositorio.delete(user);
                    return user;
                }).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));
    }

    @Override
    public void updateUser(Integer id, User user) {
        userRepositorio.findById(id)
                .map(userExistente -> {
                    user.setId(userExistente.getId());
                    userRepositorio.save(user);
                    return userExistente;
                }).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));
    }
}
