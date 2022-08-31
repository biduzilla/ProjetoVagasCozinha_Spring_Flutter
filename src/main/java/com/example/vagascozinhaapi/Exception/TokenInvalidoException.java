package com.example.vagascozinhaapi.Exception;

public class TokenInvalidoException extends RuntimeException{
    public TokenInvalidoException() {
        super("Token Inválido!");
    }
}
