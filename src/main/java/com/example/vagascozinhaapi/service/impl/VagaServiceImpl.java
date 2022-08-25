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


    @Override
    public VagaDtoEnviado salvarVaga(VagaDtoRecebido vagaDtoRecebido) {
        Usuario user = userRepositorio.findByToken(vagaDtoRecebido.getToken()).orElseThrow(TokenInvalidoException::new);

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
    public VagaDtoId getListVagaById(TokenDTO tokenDTO) {
        Usuario user = userRepositorio.findByToken(tokenDTO.getToken()).orElseThrow(TokenInvalidoException::new);

        var listVagas = user.getVaga()
                .stream()
                .map(Vaga::getId)
                .collect(Collectors.toList());

//        VagaDtoId vagaDtoId = new VagaDtoId();
//        vagaDtoId.setVagaId(listVagas);
        return VagaDtoId.builder()
                .vagaId(listVagas)
                .build();

    }

    @Override
    public VagaDtoEnviado getVagaById(TokenDTO tokenDTO, Integer idVaga) {
        Usuario user = userRepositorio.findByToken(tokenDTO.getToken()).orElseThrow(TokenInvalidoException::new);
        Vaga vaga = vagasRepository.findById(idVaga).orElseThrow(VagaNaoEncontrado::new);


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
    public VagaDtoEnviado getVagaByIdEmpresa(TokenDTO tokenDTO, Integer idVaga) {
        Usuario user = userRepositorio.findByToken(tokenDTO.getToken()).orElseThrow(TokenInvalidoException::new);
        Vaga vaga = vagasRepository.findById(idVaga).orElseThrow(VagaNaoEncontrada::new);

        List<Integer> listVagasId = vagasRepository.findAllByUserId(user.getId())
                .stream()
                .map(
                        Vaga::getId
                ).collect(Collectors.toList());
        if (!listVagasId.contains(idVaga)) {
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

    public Vaga getVagaByIdTeste(Integer idVaga) {
        return vagasRepository.findById(idVaga).orElseThrow(VagaNaoEncontrada::new);
    }

    @Override
    public void updateVaga(Integer idVaga, VagaDtoRecebido vagaDtoRecebido) {
        Usuario user = userRepositorio.findByToken(vagaDtoRecebido.getToken()).orElseThrow(TokenInvalidoException::new);

        if (user.getVaga() == null) {
            throw new RegrasNegocioException("Vaga não cadastrado, cadastre um");
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
    public void deleteVaga(TokenDTO tokenDTO, Integer idVaga) {
        Usuario user = userRepositorio.findByToken(tokenDTO.getToken()).orElseThrow(TokenInvalidoException::new);
        vagasRepository.findById(idVaga).map(
                        vaga -> {
                            vagasRepository.delete(vaga);
                            return vaga;
                        })
                .orElseThrow(VagaNaoEncontrada::new);

        userRepositorio.save(user);
    }

    @Override
    public VagaDtoEnviado aceitarVaga(Integer idVaga, TokenDTO tokenDTO) {
        Usuario user = userRepositorio.findByToken(tokenDTO.getToken()).orElseThrow(TokenInvalidoException::new);
        Vaga vaga = vagasRepository.findById(idVaga).orElseThrow(VagaNaoEncontrada::new);
        Curriculum curriculum = curriculumRepository.findById(user.getCurriculum().getId()).orElseThrow(CvNaoEncontrado::new);

        List<Curriculum> cv = vaga.getCurriculum();
        if (cv.contains(curriculum)) {
            throw new RegrasNegocioException("Você já está participando desta vaga!");
        }
        cv.add(curriculum);
        vaga.setCurriculum(cv);
        vagasRepository.save(vaga);

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
    public List<VagaDtoEnviado> searchVaga(TokenDTO tokenDTO, Vaga filtro) {
        Usuario user = userRepositorio.findByToken(tokenDTO.getToken()).orElseThrow(TokenInvalidoException::new);

        ExampleMatcher matcher = ExampleMatcher
                .matchingAny()
                .withIgnoreCase()
                .withStringMatcher(
                        ExampleMatcher.StringMatcher.CONTAINING);

        Example<Vaga> example = Example.of(filtro, matcher);
        List<Vaga> lista = vagasRepository.findAll(example);

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

    @Override
    public VagaDtoId lastTenVagas(TokenDTO tokenDTO) {
        Usuario user = userRepositorio.findByToken(tokenDTO.getToken()).orElseThrow(TokenInvalidoException::new);

        VagaDtoId vagaDtoId = new VagaDtoId();

        List<Integer> listVagas = vagasRepository.findAll()
                .stream()
                .map(
                        Vaga::getId
                ).collect(Collectors.toList());
        vagaDtoId.setVagaId(listVagas);

        if (vagaDtoId.getVagaId().size() > 10) {
            vagaDtoId.setVagaId(vagaDtoId
                    .getVagaId()
                    .subList(vagaDtoId
                            .getVagaId()
                            .size() - 10, vagaDtoId.getVagaId()
                            .size()));
        }
        return vagaDtoId;
    }
}
