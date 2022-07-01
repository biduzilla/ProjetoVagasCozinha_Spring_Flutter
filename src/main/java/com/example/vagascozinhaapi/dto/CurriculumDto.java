package com.example.vagascozinhaapi.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CurriculumDto {
    private String nome;
    private String emailContatoCV;
    private String telefone;
    private String sobre;
    private List<String> experiencias;
    private List<String> qualificacoes;
}
