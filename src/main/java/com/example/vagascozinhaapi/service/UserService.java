package com.example.vagascozinhaapi.service;

import com.example.vagascozinhaapi.dto.CredenciaisDto;
import com.example.vagascozinhaapi.dto.TokenDTO;
import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.entidade.Usuario;

public interface UserService {

    TokenDTO authUser(CredenciaisDto credenciaisDto);

    UserDto salvarUser(Usuario user);

    void deleteUser(String token);

    TokenDTO atualizar(Usuario user);

    UserDto getDadosUser(String token);
}
