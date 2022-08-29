package com.example.vagascozinhaapi.Exception;

public class VagaApagadaNaoEncontrada extends RuntimeException{
    public VagaApagadaNaoEncontrada() {
        super("Vaga apagada não encontrada!");
    }
}
