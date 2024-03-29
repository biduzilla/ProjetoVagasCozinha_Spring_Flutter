package com.example.vagascozinhaapi.entidade;

import com.example.vagascozinhaapi.entidade.Enum.StatusCv;
import lombok.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import java.util.List;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
@Builder
@Table(name = "tab_user")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "token")
    private String token;

    @NotEmpty(message = "{campo.email.obrigatorio}")
    @Column(name = "email", length = 100)
    private String email;

    @NotEmpty(message = "{campo.password.obrigatorio}")
    @Column(name = "password", length = 100)
    private String password;

    @Column(name = "cv")
    private StatusCv cv;

    @OneToOne(mappedBy = "user",cascade = CascadeType.ALL, orphanRemoval=true)
    private Curriculum curriculum;

    @OneToMany(mappedBy = "user",cascade = CascadeType.ALL)
    private List<Vaga> vaga;

    @ElementCollection
    @Column(name = "candidaturas")
    @CollectionTable(name = "tab_user_candidaturas", joinColumns = @JoinColumn(name = "user_id"))
    private List<Integer> candidaturas;

    @Column(name = "admin")
    private boolean admin;
}
