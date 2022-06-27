package com.example.vagascozinhaapi.service;

import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.entidade.User;

import java.util.List;

public interface UserService {

    UserDto salvarUser(User user);
    User getUserById(Integer id);
    List<UserDto> getUser();
    void deleteUser(Integer id);
    void updateUser(Integer id, User user);
}
