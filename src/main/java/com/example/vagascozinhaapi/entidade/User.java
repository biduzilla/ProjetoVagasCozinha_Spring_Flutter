package com.example.vagascozinhaapi.entidade;

import com.example.vagascozinhaapi.entidade.Enum.StatusCv;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;
import java.util.List;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
@Table(name = "tab_user")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Integer id;

    @Column(name = "email", length = 100)
    private String email;

    @Column(name = "password", length = 100)
    private String password;

    @Column(name = "cv")
    private StatusCv cv;

    @OneToOne(mappedBy = "user")
    private Curriculum curriculum;

    @OneToMany(mappedBy = "user")
    private List<Vaga> vaga;
}
