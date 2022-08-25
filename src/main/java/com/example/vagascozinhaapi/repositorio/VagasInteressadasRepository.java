package com.example.vagascozinhaapi.repositorio;

import com.example.vagascozinhaapi.entidade.Vaga;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface VagasInteressadasRepository extends JpaRepository<Vaga, Integer> {
    List<Vaga> findAllByUserId(Integer id);

    @Query(value = " select * from vaga c where c.cargo like '%:cargo%' ", nativeQuery = true)
    List<Vaga> encontrarPorCargo( @Param("cargo") String cargo );
}
