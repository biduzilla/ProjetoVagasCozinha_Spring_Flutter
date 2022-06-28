package com.example.vagascozinhaapi.errors;

import lombok.Data;
import lombok.Getter;

import java.util.List;

@Data
public class ApiError {
    @Getter
    private List<String> errors;

    public ApiError(String mensagemErro){
        this.errors = List.of(mensagemErro);
    }
}
