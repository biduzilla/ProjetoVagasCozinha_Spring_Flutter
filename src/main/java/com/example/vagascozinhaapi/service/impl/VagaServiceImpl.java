package com.example.vagascozinhaapi.service.impl;

import com.example.vagascozinhaapi.Exception.*;
import com.example.vagascozinhaapi.dto.*;
import com.example.vagascozinhaapi.entidade.Curriculum;
import com.example.vagascozinhaapi.entidade.Usuario;
import com.example.vagascozinhaapi.entidade.Vaga;
import com.example.vagascozinhaapi.repositorio.CurriculumRepository;
import com.example.vagascozinhaapi.repositorio.UserRepositorio;
import com.example.vagascozinhaapi.repositorio.VagasRepository;
import com.example.vagascozinhaapi.service.VagaService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class VagaServiceImpl implements VagaService {

    private final VagasRepository vagasRepository;
    private final UserRepositorio userRepositorio;
    private final CurriculumRepository curriculumRepository;
    private final UsuarioServiceAuthImpl usuarioServiceAuth;


    @Override
    public VagaDtoEnviado salvarVaga(VagaDtoRecebido vagaDtoRecebido, String token) {
        Usuario user = usuarioServiceAuth.searchUserbyToken(token);

        Vaga vaga = DtoToVaga(vagaDtoRecebido, user);

        vagasRepository.save(vaga);

        return VagaDtoEnviado.builder()
                .vagaId(vaga.getId())
                .userId(user.getId())
                .cargo(vaga.getCargo())
                .dataPostada(vaga.getDataPostada().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")))
                .local(vaga.getLocal())
                .horario(vaga.getHorario())
                .remuneracao(vaga.getRemuneracao())
                .requisitos(vaga.getRequisitos())
                .descricao(vaga.getDescricao())
                .build();

    }

    @Override
    public VagaDtoId getListVagaById(String token) {
        Usuario user = usuarioServiceAuth.searchUserbyToken(token);

        var listVagas = user.getVaga()
                .stream()
                .map(Vaga::getId)
                .collect(Collectors.toList());

        return VagaDtoId.builder()
                .vagaId(listVagas)
                .build();

    }

    @Override
    @Transactional(noRollbackFor = VagaApagadaNaoEncontrada.class)
    public VagaDtoEnviado getVagaById(String token, Integer idVaga) {
        Usuario user = usuarioServiceAuth.searchUserbyToken(token);

        if (user.getCandidaturas().contains(idVaga) && !vagasRepository.existsById(idVaga)) {
            List<Integer> listCandidaturas = user.getCandidaturas();
            listCandidaturas.removeAll(List.of(idVaga));
            userRepositorio.save(user);
            throw new VagaApagadaNaoEncontrada();

        }

        Vaga vaga = vagasRepository.findById(idVaga).orElseThrow(VagaNaoEncontrada::new);


        return VagaDtoEnviado.builder()
                .vagaId(idVaga)
                .userId(user.getId())
                .cargo(vaga.getCargo())
                .descricao(vaga.getDescricao())
                .local(vaga.getLocal())
                .horario(vaga.getHorario())
                .requisitos(vaga.getRequisitos())
                .remuneracao(vaga.getRemuneracao())
                .dataPostada(vaga.getDataPostada().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")))
                .build();
    }

    @Override
    public VagaDtoEnviado getVagaByIdEmpresa(String token, Integer idVaga) {
        Usuario user = usuarioServiceAuth.searchUserbyToken(token);
        Vaga vaga = vagasRepository.findById(idVaga).orElseThrow(VagaNaoEncontrada::new);

        if (verificarDonoVaga(user, idVaga)) {
            throw new RegrasNegocioException("Essa vaga não te pertence!");
        }

        List<CurriculumDto> cvDtoList = converter(idVaga);

        return VagaDtoEnviado.builder()
                .vagaId(idVaga)
                .userId(user.getId())
                .cargo(vaga.getCargo())
                .descricao(vaga.getDescricao())
                .local(vaga.getLocal())
                .horario(vaga.getHorario())
                .requisitos(vaga.getRequisitos())
                .remuneracao(vaga.getRemuneracao())
                .dataPostada(vaga.getDataPostada().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")))
                .curriculumDtos(cvDtoList)
                .build();
    }
    public boolean verificarDonoVaga(Usuario user, Integer idVaga) {
        List<Integer> listVagasId = vagasRepository.findAllByUserId(user.getId())
                .stream()
                .map(
                        Vaga::getId
                ).collect(Collectors.toList());
        return !listVagasId.contains(idVaga);
    }

    @Override
    public void updateVaga(Integer idVaga, VagaDtoRecebido vagaDtoRecebido, String token) {
        Usuario user = usuarioServiceAuth.searchUserbyToken(token);

        if (user.getVaga() == null) {
            throw new RegrasNegocioException("Vaga não cadastrado, cadastre um");
        }

        if (verificarDonoVaga(user, idVaga)) {
            throw new RegrasNegocioException("Essa vaga não te pertence!");
        }

        Vaga vaga = vagasRepository.findById(idVaga).orElseThrow(VagaNaoEncontrada::new);
        vaga.setId(idVaga);
        vaga.setUser(user);
        vaga.setRemuneracao(vagaDtoRecebido.getRemuneracao());
        vaga.setCargo(vagaDtoRecebido.getCargo());
        vaga.setHorario(vagaDtoRecebido.getHorario());
        vaga.setDescricao(vagaDtoRecebido.getDescricao());
        vaga.setLocal(vagaDtoRecebido.getLocal());
        vaga.setRequisitos(vagaDtoRecebido.getRequisitos());

        vagasRepository.save(vaga);
    }

    @Override
    public void deleteVaga(String token, Integer idVaga) {
        Usuario user = usuarioServiceAuth.searchUserbyToken(token);

        if (verificarDonoVaga(user, idVaga)) {
            throw new RegrasNegocioException("Essa vaga não te pertence!");
        }

        vagasRepository.findById(idVaga).map(
                        vaga -> {
                            vagasRepository.delete(vaga);
                            return vaga;
                        })
                .orElseThrow(VagaNaoEncontrada::new);

        userRepositorio.save(user);
    }

    public Curriculum validCv(Usuario user) {
        if (user.getCurriculum() == null) {
            throw new CvNaoEncontrado();
        }
        return curriculumRepository.findById(user.getCurriculum().getId()).orElseThrow(CvNaoEncontrado::new);
    }

    @Override
    @Transactional
    public VagaDtoEnviado aceitarVaga(Integer idVaga, String token) {
        Usuario user = usuarioServiceAuth.searchUserbyToken(token);
        Vaga vaga = vagasRepository.findById(idVaga).orElseThrow(VagaNaoEncontrada::new);
        Curriculum curriculum = validCv(user);


        List<Curriculum> cv = vaga.getCurriculum();
        if (cv.contains(curriculum)) {
            throw new RegrasNegocioException("Você já está participando desta vaga!");
        }
        cv.add(curriculum);
        vaga.setCurriculum(cv);
        vagasRepository.save(vaga);

        List<Integer> addVagaToList = user.getCandidaturas();
        addVagaToList.add(vaga.getId());
        user.setCandidaturas(addVagaToList);
        userRepositorio.save(user);

        return VagaDtoEnviado.builder()
                .vagaId(idVaga)
                .userId(user.getId())
                .cargo(vaga.getCargo())
                .descricao(vaga.getDescricao())
                .local(vaga.getLocal())
                .horario(vaga.getHorario())
                .requisitos(vaga.getRequisitos())
                .remuneracao(vaga.getRemuneracao())
                .dataPostada(vaga.getDataPostada().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")))
                .build();
    }

    public List<CurriculumDto> converter(Integer idVaga) {
        Vaga vaga = vagasRepository.findById(idVaga).orElseThrow(VagaNaoEncontrada::new);
        List<Curriculum> cv = vaga.getCurriculum();

        return cv
                .stream()
                .map(dto -> {
                    CurriculumDto cvDto = new CurriculumDto();
                    cvDto.setIdCv(dto.getId());
                    cvDto.setNome(dto.getNome());
                    cvDto.setEmailContatoCV(dto.getEmailContatoCV());
                    cvDto.setTelefone(dto.getTelefone());
                    cvDto.setQualificacoes(dto.getQualificacoes());
                    cvDto.setExperiencias(dto.getExperiencias());
                    cvDto.setSobre(dto.getSobre());
                    cvDto.setSemestre(dto.getSemestre());
                    return cvDto;
                }).collect(Collectors.toList());
    }

    public Vaga DtoToVaga(VagaDtoRecebido vagaDtoRecebido, Usuario user) {

        Vaga vaga = new Vaga();
        vaga.setCargo(vagaDtoRecebido.getCargo());
        vaga.setDataPostada(LocalDate.now());
        vaga.setDescricao(vagaDtoRecebido.getDescricao());
        vaga.setLocal(vagaDtoRecebido.getLocal());
        vaga.setHorario(vagaDtoRecebido.getHorario());
        vaga.setRemuneracao(vagaDtoRecebido.getRemuneracao());
        vaga.setRequisitos(vagaDtoRecebido.getRequisitos());
        vaga.setUser(user);

        return vaga;
    }

    @Override
    public List<VagaDtoEnviado> searchVaga(String token, Vaga filtro) {
        Usuario user = usuarioServiceAuth.searchUserbyToken(token);

        ExampleMatcher matcher = ExampleMatcher
                .matchingAny()
                .withIgnoreCase()
                .withStringMatcher(
                        ExampleMatcher.StringMatcher.CONTAINING);

        Example<Vaga> example = Example.of(filtro, matcher);

        List<Vaga> lista = vagasRepository.findAll(example);
        if (lista.isEmpty()){
            throw new VagaNaoEncontrada();
        }

        return lista
                .stream()
                .map(
                        vaga -> {
                            VagaDtoEnviado vagaDto = new VagaDtoEnviado();
                            vagaDto.setUserId(user.getId());
                            vagaDto.setVagaId(vaga.getId());
                            vagaDto.setCargo(vaga.getCargo());
                            vagaDto.setDescricao(vaga.getCargo());
                            vagaDto.setLocal(vaga.getLocal());
                            vagaDto.setHorario(vaga.getHorario());
                            vagaDto.setRequisitos(vaga.getRequisitos());
                            vagaDto.setRemuneracao(vaga.getRemuneracao());
                            vagaDto.setDataPostada(vaga.getDataPostada().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")));
                            return vagaDto;
                        }
                ).collect(Collectors.toList());
    }

    public VagaDtoId getAllVagasId() {
        VagaDtoId vagaDtoId = new VagaDtoId();
        List<Integer> listVagas = vagasRepository.findAll()
                .stream()
                .map(
                        Vaga::getId
                ).collect(Collectors.toList());
        vagaDtoId.setVagaId(listVagas);
        return vagaDtoId;
    }

    @Override
    public VagaDtoId lastTenVagas(String token) {
        Usuario user = usuarioServiceAuth.searchUserbyToken(token);

        VagaDtoId vagaDtoId = getAllVagasId();

        if (vagaDtoId.getVagaId().size() > 20) {
            vagaDtoId.setVagaId(vagaDtoId
                    .getVagaId()
                    .subList(vagaDtoId
                            .getVagaId()
                            .size() - 20, vagaDtoId.getVagaId()
                            .size()));
        }
        return vagaDtoId;
    }
}
