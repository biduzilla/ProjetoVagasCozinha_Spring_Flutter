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
    private String nome;
    private String emailContatoCV;
    private String telefone;
    private String sobre;
    private List<String> experiencias;
    private List<String> qualificacoes;
}
