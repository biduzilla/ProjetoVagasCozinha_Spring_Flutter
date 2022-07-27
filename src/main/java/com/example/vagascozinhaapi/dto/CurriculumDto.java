package com.example.vagascozinhaapi.dto;

import lombok.*;

import javax.validation.constraints.NotEmpty;
import java.util.List;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class CurriculumDto {
    private Integer idCv;

    @NotEmpty(message = "{campo.nome.obrigatorio}")
    private String nome;
    @NotEmpty(message = "{campo.email.obrigatorio}")
    private String emailContatoCV;
    @NotEmpty(message = "{campo.telefone.obrigatorio}")
    private String telefone;
    @NotEmpty(message = "{campo.sobre.obrigatorio}")
    private String sobre;
    @NotEmpty(message = "{campo.semestre.obrigatorio}")
    private String semestre;
    private List<String> experiencias;
    private List<String> qualificacoes;
}
