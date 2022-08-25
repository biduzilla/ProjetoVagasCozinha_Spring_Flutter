package com.example.vagascozinhaapi.dto;

import lombok.*;

import java.util.List;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class UserDto {
    private Integer idUser;
    private String email;
    private String cv;
    private String token;
    private List<VagaDtoEnviado> vagasAceitas;
}
