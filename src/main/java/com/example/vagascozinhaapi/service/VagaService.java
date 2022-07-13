package com.example.vagascozinhaapi.service;

import com.example.vagascozinhaapi.dto.VagaDtoEnviado;
import com.example.vagascozinhaapi.dto.VagaDtoId;
import com.example.vagascozinhaapi.dto.VagaDtoRecebido;

public interface VagaService {
    VagaDtoEnviado salvarVaga(VagaDtoRecebido vagaDtoRecebido);
    VagaDtoId getListVagaById(Integer id);
    VagaDtoEnviado getVagaById(Integer idUSer, Integer idVaga);
    void updateVaga(Integer idVaga, VagaDtoRecebido vagaDtoRecebido);
    void deleteVaga(Integer idUser, Integer idVaga);
    VagaDtoEnviado aceitarVaga(Integer idUser, Integer idVaga);
    VagaDtoEnviado getVagaByIdEmpresa(Integer idUSer, Integer idVaga);
}
