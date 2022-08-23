package com.example.vagascozinhaapi.entidade;

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.*;

import javax.persistence.*;
import java.util.List;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
@Table(name = "tab_curriculum")
public class Curriculum {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Integer id;

    @JsonBackReference
    @OneToOne
    @JoinColumn(name = "user_id")
    private Usuario user;

//    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "vaga_id")
    private Vaga vaga;

    @Column(name = "nome")
    private String nome;

    @Column(name = "telefone")
    private String telefone;

    @Column(name = "emailcontatocv")
    private String emailContatoCV;

    @Column(name = "sobre")
    private String sobre;

    @Column(name = "semestre")
    private String semestre;

    @Column(name = "experiencias")
    @ElementCollection
    private List<String> experiencias;

    @Column(name = "qualificacoes")
    @ElementCollection
    private List<String> qualificacoes;

}
