package com.example.vagascozinhaapi.controller;

import com.example.vagascozinhaapi.Exception.CvNaoEncontrado;
import com.example.vagascozinhaapi.Exception.RegrasNegocioException;
import com.example.vagascozinhaapi.Exception.UserNaoEncontrado;
import com.example.vagascozinhaapi.Exception.VagaNaoEncontrada;
import com.example.vagascozinhaapi.errors.ApiError;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ApplicationControllerAdvice {

    @ExceptionHandler(RegrasNegocioException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiError handleRegraNegocioException(RegrasNegocioException ex){
        String msg = ex.getMessage();
        return new ApiError(msg);
    }

    @ExceptionHandler(UserNaoEncontrado.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ApiError handlePedidoNotFoundException(UserNaoEncontrado ex){
        return new ApiError(ex.getMessage());
    }

    @ExceptionHandler(CvNaoEncontrado.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ApiError handlePedidoNotFoundException(CvNaoEncontrado ex){
        return new ApiError(ex.getMessage());
    }

    @ExceptionHandler(VagaNaoEncontrada.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ApiError handlePedidoNotFoundException(VagaNaoEncontrada ex){
        return new ApiError(ex.getMessage());
    }
}
