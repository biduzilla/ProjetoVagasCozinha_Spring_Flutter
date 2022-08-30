package com.example.vagascozinhaapi.service;

import com.example.vagascozinhaapi.dto.*;
import com.example.vagascozinhaapi.entidade.Curriculum;
import com.example.vagascozinhaapi.entidade.Usuario;
import com.example.vagascozinhaapi.entidade.Vaga;

import java.util.List;

public interface VagaService {
    VagaDtoEnviado salvarVaga(VagaDtoRecebido vagaDtoRecebido, String token);
    VagaDtoId getListVagaById(String token);
    VagaDtoEnviado getVagaById(String token, Integer idVaga);
    void updateVaga(Integer idVaga, VagaDtoRecebido vagaDtoRecebido, String token);
    void deleteVaga(String token, Integer idVaga);
    VagaDtoEnviado aceitarVaga(Integer idVaga, String token);
    VagaDtoEnviado getVagaByIdEmpresa(String token, Integer idVaga);
    List<VagaDtoEnviado> searchVaga(String token, Vaga filtro);
    VagaDtoId lastTenVagas(String token);
    Curriculum validCv(Usuario user);
}
