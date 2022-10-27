package com.example.vagascozinhaapi.entidade;

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "curriculum_id")
    private Integer id;

    @JsonBackReference
    @OneToOne
    @JoinColumn(name = "user_id")
    private Usuario user;

//    @JsonBackReference
    @ManyToMany(mappedBy = "curriculum", cascade = CascadeType.ALL)
    private List<Vaga> vaga;

    @Column(name = "nome",length = 50)
    private String nome;

    @Column(name = "telefone",length = 20)
    private String telefone;

    @Column(name = "emailcontatocv",length = 50)
    private String emailContatoCV;

    @Column(name = "sobre", length = 1200)
    private String sobre;

    @Column(name = "semestre", length = 20)
    private String semestre;

    @ElementCollection
    @Column(name = "experiencias", length = 1000)
    @CollectionTable(name = "tab_curriculum_experiencias", joinColumns = @JoinColumn(name = "curriculum_id"))
    private List<String> experiencias;

    @ElementCollection
    @Column(name = "qualificacoes")
    @CollectionTable(name = "tab_curriculum_qualificacoes", joinColumns = @JoinColumn(name = "curriculum_id"))
    private List<String> qualificacoes;
}
