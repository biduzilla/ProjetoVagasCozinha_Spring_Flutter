package com.example.vagascozinhaapi.controller;

import com.example.vagascozinhaapi.dto.TokenDTO;
import com.example.vagascozinhaapi.dto.VagaDtoEnviado;
import com.example.vagascozinhaapi.dto.VagaDtoId;
import com.example.vagascozinhaapi.dto.VagaDtoRecebido;
import com.example.vagascozinhaapi.entidade.Vaga;
import com.example.vagascozinhaapi.repositorio.VagasRepository;
import com.example.vagascozinhaapi.service.impl.VagaServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("api/vagas/")
@RequiredArgsConstructor
public class VagaController {

    private final VagaServiceImpl vagaService;

    @PostMapping("cadastrar")
    @ResponseStatus(HttpStatus.CREATED)
    public VagaDtoEnviado salvarVaga(@RequestBody @Valid VagaDtoRecebido vagaDtoRecebido, @RequestHeader("Authorization") String token){
        return vagaService.salvarVaga(vagaDtoRecebido, token);
    }

    @PostMapping("aceitar/{idVaga}")
    @ResponseStatus(HttpStatus.CREATED)
    public VagaDtoEnviado aceitarVaga(@PathVariable Integer idVaga, @RequestHeader("Authorization") String token){
        return vagaService.aceitarVaga(idVaga, token);
    }

    @GetMapping("minhasVagas")
    @ResponseStatus(HttpStatus.OK)
    public VagaDtoId getListVagas(@RequestHeader("Authorization") String token){
        return vagaService.getListVagaById(token);
    }

    @GetMapping("/{idVaga}")
    @ResponseStatus(HttpStatus.OK)
    public VagaDtoEnviado getVagaById(@RequestHeader("Authorization") String token, @PathVariable Integer idVaga){
        return vagaService.getVagaById(token,idVaga);
    }

    @GetMapping("verMinhasVagas/{idVaga}")
    @ResponseStatus(HttpStatus.OK)
    public VagaDtoEnviado getVagaByIdEmpresa(@RequestHeader("Authorization") String token,@PathVariable Integer idVaga){
        return vagaService.getVagaByIdEmpresa(token,idVaga);
    }

    @GetMapping("/lastVagas")
    @ResponseStatus(HttpStatus.OK)
    public VagaDtoId getLastVagas(@RequestHeader("Authorization") String token){
        return vagaService.lastTenVagas(token);
    }

    @GetMapping("procurar")
    @ResponseStatus(HttpStatus.OK)
    public List<VagaDtoEnviado> searchVaga(@RequestHeader("Authorization") String token, Vaga filtro){
        return vagaService.searchVaga(token,filtro);
    }

//    @GetMapping("{idVaga}")
//    @ResponseStatus(HttpStatus.OK)
//    public Vaga getVagaByIdTeste(@PathVariable Integer idVaga){
//        return vagaService.getVagaByIdTeste(idVaga);
//    }

    @PutMapping("update/{idVaga}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void updateVaga(@PathVariable Integer idVaga, @RequestBody @Valid VagaDtoRecebido vagaDtoRecebido, @RequestHeader("Authorization") String token){
        vagaService.updateVaga(idVaga, vagaDtoRecebido, token);
    }

    @DeleteMapping ("/{idVaga}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteVaga(@RequestHeader("Authorization") String token,@PathVariable Integer idVaga){
        vagaService.deleteVaga(token, idVaga);
    }


}
