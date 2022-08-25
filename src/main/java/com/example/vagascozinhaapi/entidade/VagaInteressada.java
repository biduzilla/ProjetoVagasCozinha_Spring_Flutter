package com.example.vagascozinhaapi.entidade;


import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
@Builder
@Table(name = "tab_vagaInteressada")
public class VagaInteressada {

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "user_id")
    private Usuario user;

    @Id
    private Integer id;

    @Column(name = "cargo")
    private String cargo;

    @Column(name = "descricao")
    private String descricao;

    @Column(name = "local")
    private String local;

    @Column(name = "horario")
    private String horario;

    @Column(name = "requisitos")
    @ElementCollection
    List<String> requisitos;

    @Column(name = "remuneracao")
    private double remuneracao;

    @Column(name = "dataPedido")
    private LocalDate dataPostada;
}
