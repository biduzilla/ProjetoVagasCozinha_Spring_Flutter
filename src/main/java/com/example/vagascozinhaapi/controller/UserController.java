package com.example.vagascozinhaapi.controller;

import com.example.vagascozinhaapi.Exception.SenhaInvalidaException;
import com.example.vagascozinhaapi.dto.CredenciaisDto;
import com.example.vagascozinhaapi.dto.TokenDTO;
import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.dto.UserDtoId;
import com.example.vagascozinhaapi.entidade.Usuario;
import com.example.vagascozinhaapi.repositorio.UserRepositorio;
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
import java.util.List;

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
    @GetMapping("{id}")
    public UserDto getUserById(@PathVariable Integer id) {
        return userService.getUserById(id);
    }

    @CrossOrigin
    @PutMapping("/atualizar")
    @ResponseStatus(HttpStatus.OK)
    public TokenDTO acharToken(@RequestBody Usuario user) {
        return userService.atualizar(user);
    }

    @CrossOrigin
    @GetMapping()
    public UserDtoId getUserListId() {
        return userService.getUserListId();
    }

    @GetMapping("/mostrarUser")
    public List<Usuario> mostrarUser() {
        return userRepositorio.findAll();
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
    @PostMapping("login")
    @ResponseStatus(HttpStatus.OK)
    public Integer loginUser(@RequestBody @Valid Usuario user) {
        return userService.loginUser(user);
    }

    @CrossOrigin
    @PostMapping("/auth")
    @ResponseStatus(HttpStatus.OK)
    public TokenDTO authUser(@RequestBody @Valid CredenciaisDto credenciaisDto) {
        return userService.authUser(credenciaisDto);
//        try {
//            Usuario usuario =
//                    Usuario.builder()
//                            .email(credenciaisDto.getLogin())
//                            .password(credenciaisDto.getSenha())
//                            .build();
//
//            UserDetails userAutentificado = usuarioServiceImpl.autenticar(usuario);
//            String token = jwtService.gerarToken(usuario);
//
//            return new TokenDTO(usuario.getEmail(), token);
//        } catch (UsernameNotFoundException e) {
//            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, e.getMessage());
//        }
    }

    @CrossOrigin
    @PutMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void updateUser(@PathVariable Integer id, @RequestBody @Valid Usuario user) {
        userService.updateUser(id, user);
    }

    @CrossOrigin
    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteUser(@PathVariable Integer id) {
        userService.deleteUser(id);
    }

}
