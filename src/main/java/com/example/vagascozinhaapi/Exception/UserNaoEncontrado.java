package com.example.vagascozinhaapi.Exception;

public class UserNaoEncontrado extends RuntimeException{
    public UserNaoEncontrado() {
        super("Usuário não Encontrado");
    }
}
