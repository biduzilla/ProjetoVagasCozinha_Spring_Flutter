package com.example.vagascozinhaapi.service;

import com.example.vagascozinhaapi.dto.TokenDTO;
import com.example.vagascozinhaapi.dto.VagaDtoEnviado;
import com.example.vagascozinhaapi.dto.VagaDtoId;
import com.example.vagascozinhaapi.dto.VagaDtoRecebido;
import com.example.vagascozinhaapi.entidade.Vaga;

import java.util.List;

public interface VagaService {
    VagaDtoEnviado salvarVaga(VagaDtoRecebido vagaDtoRecebido);
    VagaDtoId getListVagaById(TokenDTO tokenDTO);
    VagaDtoEnviado getVagaById(String token, Integer idVaga);
    void updateVaga(Integer idVaga, VagaDtoRecebido vagaDtoRecebido);
    void deleteVaga(TokenDTO tokenDTO, Integer idVaga);
    VagaDtoEnviado aceitarVaga(Integer idVaga, TokenDTO tokenDTO);
    VagaDtoEnviado getVagaByIdEmpresa(TokenDTO tokenDTO, Integer idVaga);
    List<VagaDtoEnviado> searchVaga(TokenDTO tokenDTO, Vaga filtro);
    VagaDtoId lastTenVagas(TokenDTO tokenDTO);
}
