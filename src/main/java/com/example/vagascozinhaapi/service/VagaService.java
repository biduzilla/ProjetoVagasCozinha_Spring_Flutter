package com.example.vagascozinhaapi.service;

import com.example.vagascozinhaapi.dto.VagaDtoEnviado;
import com.example.vagascozinhaapi.dto.VagaDtoId;
import com.example.vagascozinhaapi.dto.VagaDtoRecebido;

public interface VagaService {
    VagaDtoEnviado salvarVaga(VagaDtoRecebido vagaDtoRecebido);
    VagaDtoId getListVagaById(Integer id);
    VagaDtoEnviado getVagaById(Integer idUSer, Integer idVaga);
}
