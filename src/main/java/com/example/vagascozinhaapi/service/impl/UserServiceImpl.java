package com.example.vagascozinhaapi.service.impl;

import com.example.vagascozinhaapi.Exception.RegrasNegocioException;
import com.example.vagascozinhaapi.Exception.UserJaCadastrado;
import com.example.vagascozinhaapi.Exception.UserNaoEncontrado;
import com.example.vagascozinhaapi.dto.CredenciaisDto;
import com.example.vagascozinhaapi.dto.TokenDTO;
import com.example.vagascozinhaapi.dto.UserDto;
import com.example.vagascozinhaapi.entidade.Enum.StatusCv;
import com.example.vagascozinhaapi.entidade.Usuario;
import com.example.vagascozinhaapi.repositorio.UserRepositorio;
import com.example.vagascozinhaapi.security.JwtService;
import com.example.vagascozinhaapi.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
            userDto.setToken(user.getToken());
            userDto.setCv(StatusCv.NAO_CADASTRADO.name());

            return userDto;
        } else {
            throw new RegrasNegocioException("Usuário já cadastrado");
        }
    }

    public void deleteUser(String token) {
        token = token.split(" ")[1];
        userRepositorio.findByToken(token)
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
                            .email(credenciaisDto.getEmail())
                            .password(credenciaisDto.getPassword())
                            .build();

            UserDetails userAutentificado = usuarioServiceImpl.autenticar(usuario);
            String token = jwtService.gerarToken(usuario);

            Usuario userPronto = userRepositorio.findByEmail(usuario.getEmail()).orElseThrow(UserNaoEncontrado::new);
            userPronto.setToken(token);
            userRepositorio.save(userPronto);

            return new TokenDTO(usuario.getEmail(), token);

        } catch (UsernameNotFoundException e) {
            throw new UserNaoEncontrado();
        }
    }

    @Transactional
    public TokenDTO atualizar(Usuario user) {
        Usuario usuario = usuarioServiceImpl.searchUserbyToken(user.getToken());

        if (userRepositorio.existsByEmail(user.getEmail())) {
            throw new UserJaCadastrado();
        }

        String senhaCriptografada = encoder.encode(user.getPassword());
        user.setPassword(senhaCriptografada);

        usuario.setId(usuario.getId());

        usuario.setPassword(user.getPassword());
        usuario.setEmail(user.getEmail());
        String token = jwtService.gerarToken(usuario);
        usuario.setToken(token);
        userRepositorio.save(usuario);

        return new TokenDTO(usuario.getEmail(), token);
    }

    public UserDto getDadosUser(String token) {
        Usuario usuario = usuarioServiceImpl.searchUserbyToken(token);

        return UserDto.builder()
                .email(usuario.getEmail())
                .cv(usuario.getCv().name())
                .vagasAceitas(usuario.getCandidaturas())
                .admin(usuario.isAdmin())
                .build();
    }
}
