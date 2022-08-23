package com.example.vagascozinhaapi.service.impl;

import com.example.vagascozinhaapi.Exception.SenhaInvalidaException;
import com.example.vagascozinhaapi.entidade.Usuario;
import com.example.vagascozinhaapi.repositorio.UserRepositorio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UsuarioServiceAuthImpl implements UserDetailsService {
    @Autowired
    private PasswordEncoder encoder;

    @Autowired
    private UserRepositorio usuarioRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Usuario usuario = usuarioRepository.findByEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException("Usuário não encontrado!"));

        String[] roles = usuario.isAdmin() ?
                new String[]{"ADMIN", "USER"} : new String[]{"USER"};


        return User
                .builder()
                .username(usuario.getEmail())
                .password(usuario.getPassword())
                .roles(roles)
                .build();
    }

    public UserDetails autenticar(Usuario usuario){
        UserDetails user = loadUserByUsername(usuario.getEmail());
        boolean senhaBatem = encoder.matches(usuario.getPassword(), user.getPassword());

        if(senhaBatem){
            return user;
        }
        throw new SenhaInvalidaException();
    }
}
