package com.example.vagascozinhaapi.service;

import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.entidade.User;

import java.util.List;

public interface UserService {

    User salvarUser(User user);
    User getUserById(Integer id);
    List<User> getUser();
}
