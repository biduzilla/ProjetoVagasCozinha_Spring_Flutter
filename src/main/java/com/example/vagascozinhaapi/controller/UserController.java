package com.example.vagascozinhaapi.controller;

import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.dto.UserDtoId;
import com.example.vagascozinhaapi.entidade.User;
import com.example.vagascozinhaapi.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("api/users/")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @CrossOrigin
    @GetMapping("{id}")
    public UserDto getUserById(@PathVariable Integer id) {
            return userService.getUserById(id);
    }

    @CrossOrigin
    @GetMapping()
    public UserDtoId getUserListId() {
        return userService.getUserListId();
    }

    @CrossOrigin
    @PostMapping("salvar")
    @ResponseStatus(HttpStatus.CREATED)
    public UserDto salvarUser(@RequestBody @Valid User user){
        return userService.salvarUser(user);
    }

    @CrossOrigin
    @PostMapping("login")
    @ResponseStatus(HttpStatus.OK)
    public Integer loginUser(@RequestBody @Valid User user){
        return userService.loginUser(user);
    }

    @CrossOrigin
    @PutMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void updateUser(@PathVariable Integer id, @RequestBody @Valid User user){
        userService.updateUser(id, user);
    }

    @CrossOrigin
    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteUser(@PathVariable Integer id){
        userService.deleteUser(id);
    }
}
