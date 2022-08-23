package com.example.vagascozinhaapi.service;

import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.dto.UserDtoId;
import com.example.vagascozinhaapi.entidade.Usuario;

import java.util.List;

public interface UserService {

    UserDto salvarUser(Usuario user);

    UserDto getUserById(Integer id);

    List<Usuario> getUser();

    void deleteUser(Integer id);

    void updateUser(Integer id, Usuario user);

    UserDtoId getUserListId();

    Integer loginUser(Usuario user);

    void salvarTokenUser(Usuario user, String token);
}
