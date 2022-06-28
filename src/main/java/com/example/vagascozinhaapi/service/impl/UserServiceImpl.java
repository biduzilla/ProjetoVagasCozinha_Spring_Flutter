package com.example.vagascozinhaapi.service.impl;

import com.example.vagascozinhaapi.Exception.RegrasNegocioException;
import com.example.vagascozinhaapi.Exception.UserNaoEncontrado;
import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.dto.UserDtoId;
import com.example.vagascozinhaapi.entidade.User;
import com.example.vagascozinhaapi.repositorio.UserRepositorio;
import com.example.vagascozinhaapi.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepositorio userRepositorio;

    @Override
    public UserDto salvarUser(User user) {

        if (!userRepositorio.existsByEmail(user.getEmail())){
            userRepositorio.save(user);
            UserDto userDto = new UserDto();
            userDto.setEmail(user.getEmail());
            userDto.setIdUser(user.getId());
            return userDto;
        }else {
            throw new RegrasNegocioException("Usuário já cadastrado");
        }
    }


    @Override
    public UserDto getUserById(Integer id) {
        User user =  userRepositorio.findById(id)
                .orElseThrow(UserNaoEncontrado::new);
        UserDto userDto = new UserDto();
        userDto.setIdUser(user.getId());
        userDto.setEmail(user.getEmail());
        return userDto;
    }

    @Override
    public List<User> getUser() {
        return userRepositorio.findAll();
    }

    public List<UserDtoId> getUserListId() {
        List<User> listaUsers = userRepositorio.findAll();
        return converter(listaUsers);
    }

    public List<UserDtoId> converter(List<User> listUser){
        if (CollectionUtils.isEmpty(listUser)) {
            return java.util.Collections.emptyList();
        }

         return listUser.stream().map(user -> UserDtoId.builder()
                 .idUser(user.getId())
                 .build()).collect(Collectors.toList());
    }

    @Override
    public void deleteUser(Integer id) {
        userRepositorio.findById(id)
                .map(user -> {
                    userRepositorio.delete(user);
                    return user;
                }).orElseThrow(UserNaoEncontrado::new);
    }

    @Override
    @Transactional
    public void updateUser(Integer id, User user) {
        userRepositorio.findById(id)
                .map(userExistente -> {
                    user.setId(userExistente.getId());
                    userRepositorio.save(user);
                    return userExistente;
                }).orElseThrow(UserNaoEncontrado::new);
    }
}
