package com.example.vagascozinhaapi.dto.service.impl;

import com.example.vagascozinhaapi.Exception.RegrasNegocioException;
import com.example.vagascozinhaapi.Exception.UserNaoEncontrado;
import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.dto.UserDtoId;
import com.example.vagascozinhaapi.entidade.Enum.StatusCv;
import com.example.vagascozinhaapi.entidade.User;
import com.example.vagascozinhaapi.repositorio.UserRepositorio;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserDetailsService {

    private final UserRepositorio userRepositorio;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    private PasswordEncoder encoder;

    @Transactional
    public UserDto salvarUser(User user) {

        if (!userRepositorio.existsByEmail(user.getEmail())) {
            user.setCv(StatusCv.NAO_CADASTRADO);

            String senhaCriptografada = passwordEncoder.encode(user.getPassword());
            user.setPassword(senhaCriptografada);

            userRepositorio.save(user);
            UserDto userDto = new UserDto();
            userDto.setEmail(user.getEmail());
            userDto.setIdUser(user.getId());
            userDto.setPassword(user.getPassword());
            userDto.setCv(StatusCv.NAO_CADASTRADO.name());
            return userDto;
        } else {
            throw new RegrasNegocioException("Usuário já cadastrado");
        }
    }


    public UserDto getUserById(Integer id) {
        User user = userRepositorio.findById(id)
                .orElseThrow(UserNaoEncontrado::new);

        return UserDto.builder()
                .idUser(user.getId())
                .email(user.getEmail())
                .cv(user.getCv().name())
                .build();
    }

    public List<User> getUser() {
        return userRepositorio.findAll();
    }


    public UserDtoId getUserListId() {
        UserDtoId userDtoId = new UserDtoId();

        var listaUsers = userRepositorio.findAll()
                .stream()
                .map(
                        User::getId
                ).collect(Collectors.toList());
        userDtoId.setIdUser(listaUsers);
        return userDtoId;
    }

    public String loginUser(User user) {
        User userExist = userRepositorio.findByEmailAndAndPassword(user.getEmail(), user.getPassword());

        if (userExist == null) {
            throw new RegrasNegocioException("Dados Incorretos");
        }
        return userExist.getPassword();
    }


    public void deleteUser(Integer id) {
        userRepositorio.findById(id)
                .map(user -> {
                    userRepositorio.delete(user);
                    return user;
                }).orElseThrow(UserNaoEncontrado::new);
    }

    @Transactional
    public void updateUser(Integer id, User user) {
        userRepositorio.findById(id)
                .map(userExistente -> {
                    user.setId(userExistente.getId());
                    userRepositorio.save(user);
                    return userExistente;
                }).orElseThrow(UserNaoEncontrado::new);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepositorio.findByEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException("Usuário não encontrado na base de dados."));

        String[] roles = user.isAdmin() ?
                new String[]{"ADMIN", "USER"} : new String[]{"USER"};

        return org.springframework.security.core.userdetails.User
                .builder()
                .username(user.getEmail())
                .password(user.getPassword())
                .roles(roles)
                .build();
    }
}
