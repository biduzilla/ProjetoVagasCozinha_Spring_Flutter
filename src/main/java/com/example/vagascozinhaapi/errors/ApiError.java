package com.example.vagascozinhaapi.errors;

import lombok.Data;
import lombok.Getter;

import java.util.List;

@Data
public class ApiError {
    @Getter
    private List<String> error;

    public ApiError(String mensagemErro){
        this.error = List.of(mensagemErro);
    }
}
