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

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Column(name = "nome")
    private String nome;

    @Column(name = "telefone")
    private String telefone;

    @Column(name = "emailcontatocv")
    private String emailContatoCV;

    @Column(name = "sobre")
    private String Sobre;

    @OneToMany(mappedBy = "curriculum")
    private List<Experiencia> experiencias;

    @OneToMany(mappedBy = "curriculum")
    private List<Qualificacao> qualificacoes;

}
