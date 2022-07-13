package com.example.vagascozinhaapi.dto;

import lombok.*;

import java.util.List;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class CurriculumDto {
    private Integer idCv;
    private String nome;
    private String emailContatoCV;
    private String telefone;
    private String sobre;
    private String semestre;
    private List<String> experiencias;
    private List<String> qualificacoes;
}
