package com.example.vagascozinhaapi.controller;

import com.example.vagascozinhaapi.dto.CredenciaisDto;
import com.example.vagascozinhaapi.dto.TokenDTO;
import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.entidade.Usuario;
import com.example.vagascozinhaapi.repositorio.UserRepositorio;
import com.example.vagascozinhaapi.security.JwtService;
import com.example.vagascozinhaapi.service.UserService;
import com.example.vagascozinhaapi.service.impl.UsuarioServiceAuthImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("api/users/")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final PasswordEncoder encoder;
    private final UsuarioServiceAuthImpl usuarioServiceImpl;
    private final JwtService jwtService;
    private final UserRepositorio userRepositorio;

    @CrossOrigin
    @PutMapping("/atualizar")
    @ResponseStatus(HttpStatus.OK)
    public TokenDTO updateUser(@RequestBody Usuario user) {
        return userService.atualizar(user);
    }

    @CrossOrigin
    @PostMapping("salvar")
    @ResponseStatus(HttpStatus.CREATED)
    public UserDto salvarUser(@RequestBody @Valid Usuario user) {
        String senhaCriptografada = encoder.encode(user.getPassword());
        user.setPassword(senhaCriptografada);
        return userService.salvarUser(user);
    }

    @CrossOrigin
    @GetMapping("getDados")
    @ResponseStatus(HttpStatus.OK)
    public UserDto getDados(@RequestHeader("Authorization") String token) {
        return userService.getDadosUser(token);
    }

    @CrossOrigin
    @PostMapping("/auth")
    @ResponseStatus(HttpStatus.OK)
    public TokenDTO authUser(@RequestBody @Valid CredenciaisDto credenciaisDto) {
        return userService.authUser(credenciaisDto);
    }


    @CrossOrigin
    @DeleteMapping("/deletar")
    @ResponseStatus(HttpStatus.OK)
    public void deleteUser(@RequestHeader("Authorization") String token) {
        userService.deleteUser(token);
    }

}
