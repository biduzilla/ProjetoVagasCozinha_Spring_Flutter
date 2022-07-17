package com.example.vagascozinhaapi.controller;

import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.dto.UserDtoId;
import com.example.vagascozinhaapi.entidade.User;
import com.example.vagascozinhaapi.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/users/")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping("{id}")
    public UserDto getUserById(@PathVariable Integer id) {
            return userService.getUserById(id);
    }

    @GetMapping()
    public UserDtoId getUserListId() {
        return userService.getUserListId();
    }

    @CrossOrigin
    @PostMapping("salvar")
    @ResponseStatus(HttpStatus.CREATED)
    public UserDto salvarUser(@RequestBody User user){
        return userService.salvarUser(user);
    }

    @CrossOrigin
    @PostMapping("login")
    @ResponseStatus(HttpStatus.OK)
    public Integer loginUser(@RequestBody User user){
        return userService.loginUser(user);
    }

    @PutMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void updateUser(@PathVariable Integer id, @RequestBody User user){
        userService.updateUser(id, user);
    }

    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteUser(@PathVariable Integer id){
        userService.deleteUser(id);
    }
}
