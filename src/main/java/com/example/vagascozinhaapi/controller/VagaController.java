package com.example.vagascozinhaapi.controller;

import com.example.vagascozinhaapi.dto.VagaDtoEnviado;
import com.example.vagascozinhaapi.dto.VagaDtoId;
import com.example.vagascozinhaapi.dto.VagaDtoRecebido;
import com.example.vagascozinhaapi.service.impl.VagaServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/vagas/")
@RequiredArgsConstructor
public class VagaController {

    private final VagaServiceImpl vagaService;

    @PostMapping("cadastrar")
    @ResponseStatus(HttpStatus.CREATED)
    public VagaDtoEnviado salvarVaga(@RequestBody VagaDtoRecebido vagaDtoRecebido){
        return vagaService.salvarVaga(vagaDtoRecebido);
    }

    @GetMapping("listVagas/{id}")
    @ResponseStatus(HttpStatus.OK)
    public VagaDtoId getListVagas(@PathVariable Integer id){
        return vagaService.getListVagaById(id);
    }

    @GetMapping("{idUser}/{idVaga}")
    @ResponseStatus(HttpStatus.OK)
    public VagaDtoEnviado getListVagas(@PathVariable Integer idUser,@PathVariable Integer idVaga){
        return vagaService.getVagaById(idUser,idVaga);
    }
}
