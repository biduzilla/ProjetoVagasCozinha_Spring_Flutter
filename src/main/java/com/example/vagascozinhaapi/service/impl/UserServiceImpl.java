package com.example.vagascozinhaapi.service.impl;

import com.example.vagascozinhaapi.Exception.RegrasNegocioException;
import com.example.vagascozinhaapi.Exception.UserNaoEncontrado;
import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.dto.UserDtoId;
import com.example.vagascozinhaapi.entidade.Enum.StatusCv;
import com.example.vagascozinhaapi.entidade.Usuario;
import com.example.vagascozinhaapi.repositorio.UserRepositorio;
import com.example.vagascozinhaapi.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepositorio userRepositorio;

    @Autowired
    private PasswordEncoder encoder;

    public UserDto salvarUser(Usuario user) {

        if (!userRepositorio.existsByEmail(user.getEmail())) {
            user.setCv(StatusCv.NAO_CADASTRADO);

            userRepositorio.save(user);
            UserDto userDto = new UserDto();
            userDto.setEmail(user.getEmail());
            userDto.setIdUser(user.getId());
            userDto.setSenha(user.getPassword());
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

        if(userExist == null){
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

}
