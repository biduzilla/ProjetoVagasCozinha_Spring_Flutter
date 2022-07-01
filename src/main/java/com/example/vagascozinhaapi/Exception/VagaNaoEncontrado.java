package com.example.vagascozinhaapi.Exception;

public class VagaNaoEncontrado extends RuntimeException{
    public VagaNaoEncontrado() {
        super("Vaga não Encontrado");
    }
}
