package com.example.vagascozinhaapi.controller;

import com.example.vagascozinhaapi.Exception.*;
import com.example.vagascozinhaapi.errors.ApiError;
import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.List;
import java.util.stream.Collectors;

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
    public ApiError handleUserNotFoundException(UserNaoEncontrado ex){
        return new ApiError(ex.getMessage());
    }

    @ExceptionHandler(CvNaoEncontrado.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ApiError handleCVNotFoundException(CvNaoEncontrado ex){
        return new ApiError(ex.getMessage());
    }

    @ExceptionHandler(SenhaInvalidaException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiError handleSenhaInvalidaException(SenhaInvalidaException ex){
        return new ApiError(ex.getMessage());
    }

    @ExceptionHandler(VagaNaoEncontrada.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ApiError handleVagaNotFoundException(VagaNaoEncontrada ex){
        return new ApiError(ex.getMessage());
    }

    @ExceptionHandler(VagaApagadaNaoEncontrada.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ApiError handleVagaNotFoundException(VagaApagadaNaoEncontrada ex){
        return new ApiError(ex.getMessage());
    }

    @ExceptionHandler(UserJaCadastrado.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiError handleUserFoundException(UserJaCadastrado ex){
        return new ApiError(ex.getMessage());
    }

    @ExceptionHandler(TokenInvalidoException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public ApiError handleInvalidTOkenException(TokenInvalidoException ex){
        return new ApiError(ex.getMessage());
    }

    @ExceptionHandler
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiError handleMethodNotValidException(MethodArgumentNotValidException ex) {
        List<String> erros = ex.getBindingResult().getAllErrors()
                .stream()
                .map(DefaultMessageSourceResolvable::getDefaultMessage).collect(Collectors.toList());

        return new ApiError(erros);
    }
}
