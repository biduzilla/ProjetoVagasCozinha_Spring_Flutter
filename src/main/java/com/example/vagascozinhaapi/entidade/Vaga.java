package com.example.vagascozinhaapi.entidade;


import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
@Table(name = "tab_vaga")
public class Vaga {

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "user_id")
    private Usuario user;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="vaga_id")
    private Integer id;

    @Column(name = "cargo", length = 100)
    private String cargo;

    @Column(name = "descricao",length = 1000)
    private String descricao;

    @Column(name = "local", length = 50)
    private String local;

    @Column(name = "horario", length = 50)
    private String horario;


    @ElementCollection
    @Column(name = "requisitos")
    @CollectionTable(name = "tab_vaga_requisitos", joinColumns = @JoinColumn(name = "vaga_id"))
    List<String> requisitos;

    @Column(name = "remuneracao")
    private double remuneracao;

    @Column(name = "data_postada")
    private LocalDate dataPostada;

    @ElementCollection
    @Column(name = "curriculum_id")
    @CollectionTable(name = "tab_vaga_curriculum_id", joinColumns = @JoinColumn(name = "vaga_id"))
    List<Integer> curriculumId;
}
