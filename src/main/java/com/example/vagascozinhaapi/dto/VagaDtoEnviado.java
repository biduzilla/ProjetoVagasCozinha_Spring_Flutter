package com.example.vagascozinhaapi.dto;

import lombok.*;

import java.util.List;
import java.util.Set;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class VagaDtoEnviado {
    private Integer userId;
    private Integer vagaId;
    private String cargo;
    private String descricao;
    private String local;
    List<String> requisitos;
    private double remuneracao;
    private String dataPostada;
    private List<CurriculumDto> curriculumDtos;
}
