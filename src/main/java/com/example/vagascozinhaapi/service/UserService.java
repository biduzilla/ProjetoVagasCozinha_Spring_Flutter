package com.example.vagascozinhaapi.service;

import com.example.vagascozinhaapi.dto.CredenciaisDto;
import com.example.vagascozinhaapi.dto.TokenDTO;
import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.dto.UserDtoId;
import com.example.vagascozinhaapi.entidade.Usuario;

import java.util.List;

public interface UserService {

    TokenDTO authUser(CredenciaisDto credenciaisDto);

    UserDto salvarUser(Usuario user);

    UserDto getUserById(Integer id);

    List<Usuario> getUser();

    void deleteUser(String token);

    UserDtoId getUserListId();

    Integer loginUser(Usuario user);

    TokenDTO atualizar(Usuario user);

    UserDto getDadosUser(String token);
}
