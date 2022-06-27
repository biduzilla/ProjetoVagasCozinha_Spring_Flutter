package com.example.vagascozinhaapi.entidade;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "tab_experiencia")
public class Experiencia {

    @GeneratedValue(strategy = GenerationType.AUTO)
    @Id
    @Column(name = "id")
    private Integer id;

    @Column(name = "experiencia")
    private String experiencia;

   @ManyToOne(targetEntity = Curriculum.class)
   @JoinColumn(name = "experiencia_curriculum_id")
   private Curriculum curriculum;
}
