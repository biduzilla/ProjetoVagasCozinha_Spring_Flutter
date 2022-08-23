package com.example.vagascozinhaapi.controller;

import com.example.vagascozinhaapi.Exception.SenhaInvalidaException;
import com.example.vagascozinhaapi.dto.CredenciaisDto;
import com.example.vagascozinhaapi.dto.TokenDTO;
import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.dto.UserDtoId;
import com.example.vagascozinhaapi.entidade.Usuario;
import com.example.vagascozinhaapi.security.JwtService;
import com.example.vagascozinhaapi.service.UserService;
import com.example.vagascozinhaapi.service.impl.UsuarioServiceAuthImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import javax.validation.Valid;

@RestController
@RequestMapping("api/users/")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final PasswordEncoder encoder;
    private final UsuarioServiceAuthImpl usuarioServiceImpl;

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
    public UserDto salvarUser(@RequestBody @Valid Usuario user){
        String senhaCriptografada = encoder.encode(user.getPassword());
        user.setPassword(senhaCriptografada);
        return userService.salvarUser(user);
    }

    @CrossOrigin
    @PostMapping("login")
    @ResponseStatus(HttpStatus.OK)
    public Integer loginUser(@RequestBody @Valid Usuario user){
        return userService.loginUser(user);
    }

    @CrossOrigin
    @PutMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void updateUser(@PathVariable Integer id, @RequestBody @Valid Usuario user){
        userService.updateUser(id, user);
    }

    @CrossOrigin
    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteUser(@PathVariable Integer id){
        userService.deleteUser(id);
    }

}
