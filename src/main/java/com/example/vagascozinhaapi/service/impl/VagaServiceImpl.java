package com.example.vagascozinhaapi.service.impl;

import com.example.vagascozinhaapi.Exception.UserNaoEncontrado;
import com.example.vagascozinhaapi.Exception.VagaNaoEncontrado;
import com.example.vagascozinhaapi.dto.VagaDtoEnviado;
import com.example.vagascozinhaapi.dto.VagaDtoId;
import com.example.vagascozinhaapi.dto.VagaDtoRecebido;
import com.example.vagascozinhaapi.entidade.User;
import com.example.vagascozinhaapi.entidade.Vaga;
import com.example.vagascozinhaapi.repositorio.UserRepositorio;
import com.example.vagascozinhaapi.repositorio.VagasRepository;
import com.example.vagascozinhaapi.service.VagaService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class VagaServiceImpl implements VagaService {

    private final VagasRepository vagasRepository;
    private final UserRepositorio userRepositorio;


    @Override
    public VagaDtoEnviado salvarVaga(VagaDtoRecebido vagaDtoRecebido) {
        System.out.println("IdUSer: " + vagaDtoRecebido.getUserId());
        User user = userRepositorio.findById(vagaDtoRecebido.getUserId()).orElseThrow(UserNaoEncontrado::new);

        Vaga vaga = new Vaga();
        vaga.setCargo(vagaDtoRecebido.getCargo());
        vaga.setDataPostada(LocalDate.now());
        vaga.setDescricao(vagaDtoRecebido.getDescricao());
        vaga.setLocal(vagaDtoRecebido.getLocal());
        vaga.setRemuneracao(vagaDtoRecebido.getRemuneracao());
        vaga.setRequisitos(vagaDtoRecebido.getRequisitos());
        vaga.setUser(user);

        vagasRepository.save(vaga);

        return VagaDtoEnviado.builder()
                .userId(user.getId())
                .cargo(vaga.getCargo())
                .dataPostada(vaga.getDataPostada().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")))
                .local(vaga.getLocal())
                .remuneracao(vaga.getRemuneracao())
                .requisitos(vaga.getRequisitos())
                .descricao(vaga.getDescricao())
                .build();

//         VagaDtoEnviado vagaDtoEnviado = new VagaDtoEnviado();
//         return vagaDtoEnviado;
    }

    @Override
    public VagaDtoId getListVagaById(Integer id) {
        User user = userRepositorio.findById(id).orElseThrow(UserNaoEncontrado::new);

        var listVagas = user.getVaga()
                .stream()
                .map(Vaga::getId)
                .collect(Collectors.toList());

        VagaDtoId vagaDtoId = new VagaDtoId();
        vagaDtoId.setVagaId(listVagas);
        return vagaDtoId;
    }

    @Override
    public VagaDtoEnviado getVagaById(Integer idUSer, Integer idVaga) {
        User user = userRepositorio.findById(idUSer).orElseThrow(UserNaoEncontrado::new);

        Vaga vaga = vagasRepository.findById(idVaga).orElseThrow(VagaNaoEncontrado::new);

        return VagaDtoEnviado.builder()
                .userId(idUSer)
                .cargo(vaga.getCargo())
                .descricao(vaga.getDescricao())
                .local(vaga.getLocal())
                .requisitos(vaga.getRequisitos())
                .remuneracao(vaga.getRemuneracao())
                .dataPostada(vaga.getDataPostada().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")))
                .build();
    }
}
