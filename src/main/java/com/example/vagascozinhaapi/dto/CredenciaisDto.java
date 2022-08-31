package com.example.vagascozinhaapi.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CredenciaisDto {

    @NotEmpty(message = "{campo.email.obrigatorio}")
    private String email;

    @NotEmpty(message = "{campo.password.obrigatorio}")
    private String password;
}
