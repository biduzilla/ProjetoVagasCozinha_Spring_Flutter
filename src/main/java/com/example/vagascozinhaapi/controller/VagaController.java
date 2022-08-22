package com.example.vagascozinhaapi.controller;

import com.example.vagascozinhaapi.dto.VagaDtoEnviado;
import com.example.vagascozinhaapi.dto.VagaDtoId;
import com.example.vagascozinhaapi.dto.VagaDtoRecebido;
import com.example.vagascozinhaapi.entidade.Vaga;
import com.example.vagascozinhaapi.repositorio.CurriculumRepository;
import com.example.vagascozinhaapi.repositorio.UserRepositorio;
import com.example.vagascozinhaapi.repositorio.VagasRepository;
import com.example.vagascozinhaapi.dto.service.impl.VagaServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("api/vagas/")
@RequiredArgsConstructor
public class VagaController {

    private final VagaServiceImpl vagaService;
    private final VagasRepository vagasRepository;
    private final UserRepositorio userRepositorio;
    private final CurriculumRepository curriculumRepository;

    @PostMapping("cadastrar")
    @ResponseStatus(HttpStatus.CREATED)
    public VagaDtoEnviado salvarVaga(@RequestBody @Valid VagaDtoRecebido vagaDtoRecebido){
        return vagaService.salvarVaga(vagaDtoRecebido);
    }

    @PostMapping("aceitar/{idUser}/{idVaga}")
    @ResponseStatus(HttpStatus.CREATED)
    public VagaDtoEnviado aceitarVaga(@PathVariable Integer idUser,@PathVariable Integer idVaga){
        return vagaService.aceitarVaga(idUser, idVaga);
    }

    @GetMapping("listVagas/{id}")
    @ResponseStatus(HttpStatus.OK)
    public VagaDtoId getListVagas(@PathVariable Integer id){
        return vagaService.getListVagaById(id);
    }

    @GetMapping("{idUser}/{idVaga}")
    @ResponseStatus(HttpStatus.OK)
    public VagaDtoEnviado getVagaById(@PathVariable Integer idUser,@PathVariable Integer idVaga){
        return vagaService.getVagaById(idUser,idVaga);
    }

    @GetMapping("verVaga/{idUser}/{idVaga}")
    @ResponseStatus(HttpStatus.OK)
    public VagaDtoEnviado getVagaByIdEmpresa(@PathVariable Integer idUser,@PathVariable Integer idVaga){
        return vagaService.getVagaByIdEmpresa(idUser,idVaga);
    }

    @GetMapping("lastVagas/{idUser}")
    @ResponseStatus(HttpStatus.OK)
    public VagaDtoId getLastVagas(@PathVariable Integer idUser){
        return vagaService.lastTenVagas(idUser);
    }

    @GetMapping("procurar/{idUser}")
    @ResponseStatus(HttpStatus.OK)
    public List<VagaDtoEnviado> searchVaga(@PathVariable Integer idUser, Vaga filtro){
        return vagaService.searchVaga(idUser,filtro);
    }

    @GetMapping("{idVaga}")
    @ResponseStatus(HttpStatus.OK)
    public Vaga getVagaByIdTeste(@PathVariable Integer idVaga){
        return vagaService.getVagaByIdTeste(idVaga);
    }

    @PutMapping("update/{idVaga}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void updateVaga(@PathVariable Integer idVaga, @RequestBody @Valid VagaDtoRecebido vagaDtoRecebido){
        vagaService.updateVaga(idVaga, vagaDtoRecebido);
    }

    @DeleteMapping ("{idUser}/{idVaga}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteVaga(@PathVariable Integer idUser,@PathVariable Integer idVaga){
        vagaService.deleteVaga(idUser, idVaga);
    }
}
