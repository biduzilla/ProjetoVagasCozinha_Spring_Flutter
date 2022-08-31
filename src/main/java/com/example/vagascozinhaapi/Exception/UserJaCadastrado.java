package com.example.vagascozinhaapi.Exception;

public class UserJaCadastrado extends RuntimeException{
    public UserJaCadastrado() {
        super("Usuário Já Cadastrado");
    }
}
