package com.example.vagascozinhaapi.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;

@Data
@NoArgsConstructor
public class CredenciaisDto {

    @NotEmpty(message = "{campo.email.obrigatorio}")
    private String login;

    @NotEmpty(message = "{campo.password.obrigatorio}")
    private String senha;
}
