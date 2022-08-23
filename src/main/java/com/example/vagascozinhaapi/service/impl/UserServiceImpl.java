package com.example.vagascozinhaapi.service.impl;

import com.example.vagascozinhaapi.Exception.RegrasNegocioException;
import com.example.vagascozinhaapi.Exception.UserNaoEncontrado;
import com.example.vagascozinhaapi.dto.CredenciaisDto;
import com.example.vagascozinhaapi.dto.TokenDTO;
import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.dto.UserDtoId;
import com.example.vagascozinhaapi.entidade.Enum.StatusCv;
import com.example.vagascozinhaapi.entidade.Usuario;
import com.example.vagascozinhaapi.repositorio.UserRepositorio;
import com.example.vagascozinhaapi.security.JwtService;
import com.example.vagascozinhaapi.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepositorio userRepositorio;
    private final UsuarioServiceAuthImpl usuarioServiceImpl;
    private final JwtService jwtService;

    @Autowired
    private PasswordEncoder encoder;

    public UserDto salvarUser(Usuario user) {

        if (!userRepositorio.existsByEmail(user.getEmail())) {
            user.setCv(StatusCv.NAO_CADASTRADO);

            userRepositorio.save(user);
            UserDto userDto = new UserDto();
            userDto.setEmail(user.getEmail());
            userDto.setIdUser(user.getId());
            userDto.setCv(StatusCv.NAO_CADASTRADO.name());
            return userDto;
        } else {
            throw new RegrasNegocioException("Usuário já cadastrado");
        }
    }


    public UserDto getUserById(Integer id) {
        Usuario user = userRepositorio.findById(id)
                .orElseThrow(UserNaoEncontrado::new);

        return UserDto.builder()
                .idUser(user.getId())
                .email(user.getEmail())
                .cv(user.getCv().name())
                .build();
    }

    public List<Usuario> getUser() {
        return userRepositorio.findAll();
    }


    public UserDtoId getUserListId() {
        UserDtoId userDtoId = new UserDtoId();

        var listaUsers = userRepositorio.findAll()
                .stream()
                .map(
                        Usuario::getId
                ).collect(Collectors.toList());
        userDtoId.setIdUser(listaUsers);
        return userDtoId;
    }

    public Integer loginUser(Usuario user) {
        Usuario userExist = userRepositorio.findByEmailAndAndPassword(user.getEmail(), user.getPassword());

        if (userExist == null) {
            throw new RegrasNegocioException("Dados Incorretos");
        }

        return userExist.getId();
    }

    public void salvarTokenUser(Usuario user, String token) {
        Usuario userExist = userRepositorio.findByEmailAndAndPassword(user.getEmail(), user.getPassword());
        userExist.setToken(token);
        userRepositorio.save(userExist);

    }

    public void deleteUser(Integer id) {
        userRepositorio.findById(id)
                .map(user -> {
                    userRepositorio.delete(user);
                    return user;
                }).orElseThrow(UserNaoEncontrado::new);
    }

    @Transactional
    public void updateUser(Integer id, Usuario user) {
        userRepositorio.findById(id)
                .map(userExistente -> {
                    user.setId(userExistente.getId());
                    userRepositorio.save(user);
                    return userExistente;
                }).orElseThrow(UserNaoEncontrado::new);
    }

    public TokenDTO authUser(CredenciaisDto credenciaisDto) {
        try {
            Usuario usuario =
                    Usuario.builder()
                            .email(credenciaisDto.getLogin())
                            .password(credenciaisDto.getSenha())
                            .build();

            UserDetails userAutentificado = usuarioServiceImpl.autenticar(usuario);
            String token = jwtService.gerarToken(usuario);

            Usuario userPronto = userRepositorio.findByEmail(usuario.getEmail()).orElseThrow(UserNaoEncontrado::new);
            userPronto.setToken(token);
            userRepositorio.save(userPronto);

            return new TokenDTO(usuario.getEmail(), token);

        } catch (UsernameNotFoundException e) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, e.getMessage());
        }
    }

}
