package com.example.vagascozinhaapi.service.impl;

import com.example.vagascozinhaapi.Exception.CvNaoEncontrado;
import com.example.vagascozinhaapi.Exception.RegrasNegocioException;
import com.example.vagascozinhaapi.dto.CurriculumDto;
import com.example.vagascozinhaapi.dto.CurriculumDtoId;
import com.example.vagascozinhaapi.entidade.Curriculum;
import com.example.vagascozinhaapi.entidade.Enum.StatusCv;
import com.example.vagascozinhaapi.entidade.Usuario;
import com.example.vagascozinhaapi.repositorio.CurriculumRepository;
import com.example.vagascozinhaapi.repositorio.UserRepositorio;
import com.example.vagascozinhaapi.service.CurriculumService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@Service
@RequiredArgsConstructor
public class CurriculumServiceImpl implements CurriculumService {

    private final CurriculumRepository curriculumRepository;
    private final UserRepositorio userRepositorio;
    private final UsuarioServiceAuthImpl usuarioServiceAuth;

    @Override
    public CurriculumDtoId salvarCv(CurriculumDto curriculumDto, String token) {
        Usuario user = usuarioServiceAuth.searchUserbyToken(token);
        if (user.getCv() == StatusCv.NAO_CADASTRADO) {
            user.setCv(StatusCv.CADASTRADO);

            Curriculum cv = new Curriculum();
            cv.setNome(curriculumDto.getNome());
            cv.setEmailContatoCV(curriculumDto.getEmailContatoCV());
            cv.setSobre(curriculumDto.getSobre());
            cv.setSemestre(curriculumDto.getSemestre());
            cv.setExperiencias(curriculumDto.getExperiencias());
            cv.setQualificacoes(curriculumDto.getQualificacoes());
            cv.setTelefone(curriculumDto.getTelefone());
            cv.setUser(user);
            curriculumRepository.save(cv);

            CurriculumDtoId curriculumDtoId = new CurriculumDtoId();
            curriculumDtoId.setId(cv.getId());
            return curriculumDtoId;
        }
        throw new RegrasNegocioException("Curriculo já cadastrado, atualize ele");
    }



    @Override
    public CurriculumDto getCv(String token) {
        Usuario user = usuarioServiceAuth.searchUserbyToken(token);
        if(user.getCurriculum() == null) {
            throw new RegrasNegocioException("Curriculo não cadastrado, cadastre um");
        }
        Curriculum cv =  curriculumRepository.findById(user.getCurriculum().getId()).orElseThrow(CvNaoEncontrado::new);

        return CurriculumDto.builder()
                .idCv(cv.getId())
                .nome(cv.getNome())
                .emailContatoCV(cv.getEmailContatoCV())
                .telefone(cv.getTelefone())
                .semestre(cv.getSemestre())
                .sobre(cv.getSobre())
                .experiencias(cv.getExperiencias())
                .qualificacoes(cv.getQualificacoes())
                .build();
    }

     @Override
    public void updateCv(CurriculumDto curriculumDto, String token) {
         Usuario user = usuarioServiceAuth.searchUserbyToken(token);

        if(user.getCurriculum() == null) {
            throw new RegrasNegocioException("Curriculo não cadastrado, cadastre um");
        }

        Curriculum cv = curriculumRepository.findById(user.getCurriculum().getId()).orElseThrow(CvNaoEncontrado::new);
        cv.setNome(curriculumDto.getNome());
        cv.setEmailContatoCV(curriculumDto.getEmailContatoCV());
        cv.setTelefone(curriculumDto.getTelefone());
        cv.setSemestre(curriculumDto.getSemestre());
        cv.setSobre(curriculumDto.getSobre());
        cv.setExperiencias(curriculumDto.getExperiencias());
        cv.setQualificacoes(curriculumDto.getQualificacoes());
        curriculumRepository.save(cv);
    }

    @Override
    public void deleteCv(String token) {
        Usuario usuario = usuarioServiceAuth.searchUserbyToken(token);
        curriculumRepository.findById(usuario.getCurriculum().getId())
                .map(curriculum -> {
                    curriculumRepository.delete(curriculum);
                    return curriculum;
                })
                .orElseThrow(CvNaoEncontrado::new);
        usuario.setCv(StatusCv.NAO_CADASTRADO);
        userRepositorio.save(usuario);
    }
}
