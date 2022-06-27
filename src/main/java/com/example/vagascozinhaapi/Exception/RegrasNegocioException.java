package com.example.vagascozinhaapi.Exception;

public class RegrasNegocioException extends RuntimeException {
    public RegrasNegocioException(String message) {
        super(message);
    }

    public RegrasNegocioException(String message, Throwable cause) {
        super(message, cause);
    }
}
