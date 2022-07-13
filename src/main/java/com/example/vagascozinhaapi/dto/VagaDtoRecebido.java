package com.example.vagascozinhaapi.dto;

import lombok.*;

import java.util.List;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class VagaDtoRecebido {
    private Integer userId;
    private String cargo;
    private String descricao;
    private String local;
    List<String> requisitos;
    private double remuneracao;
}
