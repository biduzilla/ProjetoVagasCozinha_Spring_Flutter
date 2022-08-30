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
    public VagaDtoEnviado salvarVaga(@RequestBody @Valid VagaDtoRecebido vagaDtoRecebido){
        return vagaService.salvarVaga(vagaDtoRecebido);
    }

    @PostMapping("aceitar/{idVaga}")
    @ResponseStatus(HttpStatus.CREATED)
    public VagaDtoEnviado aceitarVaga(@PathVariable Integer idVaga, @RequestBody @Valid TokenDTO tokenDTO){
        return vagaService.aceitarVaga(idVaga, tokenDTO);
    }

    @PostMapping("listVagas")
    @ResponseStatus(HttpStatus.OK)
    public VagaDtoId getListVagas(@RequestBody @Valid TokenDTO tokenDTO){
        return vagaService.getListVagaById(tokenDTO);
    }

    @GetMapping("/{idVaga}")
    @ResponseStatus(HttpStatus.OK)
    public VagaDtoEnviado getVagaById(@RequestHeader("Authorization") String token, @PathVariable Integer idVaga){
        return vagaService.getVagaById(token,idVaga);
    }

    @PostMapping("minhasVagas/{idVaga}")
    @ResponseStatus(HttpStatus.OK)
    public VagaDtoEnviado getVagaByIdEmpresa(@RequestBody @Valid TokenDTO tokenDTO,@PathVariable Integer idVaga){
        return vagaService.getVagaByIdEmpresa(tokenDTO,idVaga);
    }

    @PostMapping("/lastVagas")
    @ResponseStatus(HttpStatus.OK)
    public VagaDtoId getLastVagas(@RequestBody @Valid TokenDTO tokenDTO){
        return vagaService.lastTenVagas(tokenDTO);
    }

    @PostMapping("procurar")
    @ResponseStatus(HttpStatus.OK)
    public List<VagaDtoEnviado> searchVaga(@RequestBody TokenDTO tokenDTO, Vaga filtro){
        return vagaService.searchVaga(tokenDTO,filtro);
    }

//    @GetMapping("{idVaga}")
//    @ResponseStatus(HttpStatus.OK)
//    public Vaga getVagaByIdTeste(@PathVariable Integer idVaga){
//        return vagaService.getVagaByIdTeste(idVaga);
//    }

    @PutMapping("update/{idVaga}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void updateVaga(@PathVariable Integer idVaga, @RequestBody @Valid VagaDtoRecebido vagaDtoRecebido){
        vagaService.updateVaga(idVaga, vagaDtoRecebido);
    }

    @DeleteMapping ("/{idVaga}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteVaga(@RequestBody @Valid TokenDTO tokenDTO,@PathVariable Integer idVaga){
        vagaService.deleteVaga(tokenDTO, idVaga);
    }


}
