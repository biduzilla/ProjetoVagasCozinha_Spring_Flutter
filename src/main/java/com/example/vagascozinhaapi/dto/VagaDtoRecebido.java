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
public class VagaDtoRecebido {

    private Integer userId;
    @NotEmpty(message = "{campo.cargo.obrigatorio}")
    private String cargo;
    @NotEmpty(message = "{campo.descricao.obrigatorio}")
    private String descricao;
    @NotEmpty(message = "{campo.local.obrigatorio}")
    private String local;
    @NotEmpty(message = "{campo.horario.obrigatorio}")
    private String horario;
    List<String> requisitos;
    private double remuneracao;
}
