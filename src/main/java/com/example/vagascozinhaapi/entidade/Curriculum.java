package com.example.vagascozinhaapi.entidade;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "tab_curriculum")
public class Curriculum {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Integer id;

    @Column(name = "nome")
    private String nome;

    @Column(name = "telefone")
    private String telefone;

    @Column(name = "emailContatoCV")
    private String emailContatoCV;

    @Column(name = "Sobre")
    private String Sobre;

    
    private List<Formacao> formacoes;
    private String xp;
    private List<Qualificacao> qualificacoes;

}
