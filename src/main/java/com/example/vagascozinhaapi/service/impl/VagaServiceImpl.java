package com.example.vagascozinhaapi.service.impl;

import com.example.vagascozinhaapi.Exception.*;
import com.example.vagascozinhaapi.dto.CurriculumDto;
import com.example.vagascozinhaapi.dto.VagaDtoEnviado;
import com.example.vagascozinhaapi.dto.VagaDtoId;
import com.example.vagascozinhaapi.dto.VagaDtoRecebido;
import com.example.vagascozinhaapi.entidade.Curriculum;
import com.example.vagascozinhaapi.entidade.User;
import com.example.vagascozinhaapi.entidade.Vaga;
import com.example.vagascozinhaapi.repositorio.CurriculumRepository;
import com.example.vagascozinhaapi.repositorio.UserRepositorio;
import com.example.vagascozinhaapi.repositorio.VagasRepository;
import com.example.vagascozinhaapi.service.VagaService;
import lombok.RequiredArgsConstructor;
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
        System.out.println("IdUSer: " + vagaDtoRecebido.getUserId());
        User user = userRepositorio.findById(vagaDtoRecebido.getUserId()).orElseThrow(UserNaoEncontrado::new);

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
    public VagaDtoId getListVagaById(Integer id) {
        User user = userRepositorio.findById(id).orElseThrow(UserNaoEncontrado::new);

        var listVagas = user.getVaga()
                .stream()
                .map(Vaga::getId)
                .collect(Collectors.toList());

        VagaDtoId vagaDtoId = new VagaDtoId();
        vagaDtoId.setVagaId(listVagas);
        return vagaDtoId;
    }

    @Override
    public VagaDtoEnviado getVagaById(Integer idUSer, Integer idVaga) {
        User user = userRepositorio.findById(idUSer).orElseThrow(UserNaoEncontrado::new);
        Vaga vaga = vagasRepository.findById(idVaga).orElseThrow(VagaNaoEncontrado::new);


        return VagaDtoEnviado.builder()
                .vagaId(idVaga)
                .userId(idUSer)
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
    public VagaDtoEnviado getVagaByIdEmpresa(Integer idUSer, Integer idVaga) {
        User user = userRepositorio.findById(idUSer).orElseThrow(UserNaoEncontrado::new);
        Vaga vaga = vagasRepository.findById(idVaga).orElseThrow(VagaNaoEncontrado::new);

        List<Integer> listVagasId = vagasRepository.findAllByUserId(idUSer)
                .stream()
                .map(
                        Vaga::getId
                ).collect(Collectors.toList());
        if(!listVagasId.contains(idVaga)){
            throw new RegrasNegocioException("Essa vaga não te pertence!");
        }

        List<CurriculumDto> cvDtoList = converter(idVaga);

        return VagaDtoEnviado.builder()
                .vagaId(idVaga)
                .userId(idUSer)
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
        User user = userRepositorio.findById(vagaDtoRecebido.getUserId()).orElseThrow(UserNaoEncontrado::new);

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
    public void deleteVaga(Integer idUser, Integer idVaga) {
        User user = userRepositorio.findById(idUser).orElseThrow(UserNaoEncontrado::new);
        vagasRepository.findById(idVaga).map(
                        vaga -> {
                            vagasRepository.delete(vaga);
                            return vaga;
                        })
                .orElseThrow(VagaNaoEncontrada::new);

        userRepositorio.save(user);
    }

    @Override
    public VagaDtoEnviado aceitarVaga(Integer idUser, Integer idVaga) {
        User user = userRepositorio.findById(idUser).orElseThrow(UserNaoEncontrado::new);
        Vaga vaga = vagasRepository.findById(idVaga).orElseThrow(VagaNaoEncontrada::new);
        Curriculum curriculum = curriculumRepository.findById(user.getCurriculum().getId()).orElseThrow(CvNaoEncontrado::new);

        List<Curriculum> cv = vaga.getCurriculum();
        cv.add(curriculum);
        vaga.setCurriculum(cv);
        vagasRepository.save(vaga);

        List<CurriculumDto> cvDtoList = converter(idVaga);

        return VagaDtoEnviado.builder()
                .vagaId(idVaga)
                .userId(idUser)
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

    public Vaga DtoToVaga(VagaDtoRecebido vagaDtoRecebido, User user) {

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
}
