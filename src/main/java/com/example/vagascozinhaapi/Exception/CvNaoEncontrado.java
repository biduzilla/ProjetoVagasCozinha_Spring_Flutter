package com.example.vagascozinhaapi.Exception;

public class CvNaoEncontrado extends RuntimeException{
    public CvNaoEncontrado() {
        super("Curriculum não Encontrado");
    }
}
