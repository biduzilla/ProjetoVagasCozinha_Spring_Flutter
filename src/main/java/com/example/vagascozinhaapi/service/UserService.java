package com.example.vagascozinhaapi.service;

import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.dto.UserDtoId;
import com.example.vagascozinhaapi.entidade.User;

import java.util.List;

public interface UserService {

    UserDto salvarUser(User user);

    UserDto getUserById(Integer id);

    List<User> getUser();

    void deleteUser(Integer id);

    void updateUser(Integer id, User user);

    UserDtoId getUserListId();

    Integer loginUser(User user);
}
