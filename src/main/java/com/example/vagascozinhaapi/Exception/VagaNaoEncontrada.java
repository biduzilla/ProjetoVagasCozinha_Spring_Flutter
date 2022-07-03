package com.example.vagascozinhaapi.Exception;

public class VagaNaoEncontrada extends RuntimeException{
    public VagaNaoEncontrada() {
        super("Vaga não Encontrado");
    }
}
