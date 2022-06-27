package com.example.vagascozinhaapi.controller;

import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.entidade.User;
import com.example.vagascozinhaapi.repositorio.UserRepositorio;
import com.example.vagascozinhaapi.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@RequestMapping("api/users/")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping("{id}")
    public User getUserById(@PathVariable Integer id) {
            return userService.getUserById(id);
    }

    @GetMapping()
    public List<User> getUser() {
        return userService.getUser();
    }


    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public User salvarUser(@RequestBody User user){
        return userService.salvarUser(user);
    }
}
