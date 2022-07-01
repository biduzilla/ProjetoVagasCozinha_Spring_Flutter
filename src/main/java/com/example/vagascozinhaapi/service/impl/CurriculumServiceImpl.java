package com.example.vagascozinhaapi.service.impl;

import com.example.vagascozinhaapi.Exception.CvNaoEncontrado;
import com.example.vagascozinhaapi.Exception.RegrasNegocioException;
import com.example.vagascozinhaapi.Exception.UserNaoEncontrado;
import com.example.vagascozinhaapi.dto.CurriculumDto;
import com.example.vagascozinhaapi.dto.CurriculumDtoId;
import com.example.vagascozinhaapi.entidade.Curriculum;
import com.example.vagascozinhaapi.entidade.User;
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

    @Override
    public CurriculumDtoId salvarCv(Integer id, CurriculumDto curriculumDto) {
        User user = userRepositorio.findById(id).orElseThrow(UserNaoEncontrado::new);
        if (!user.getCv()) {
            user.setCv(true);

            Curriculum cv = new Curriculum();
            cv.setNome(curriculumDto.getNome());
            cv.setEmailContatoCV(curriculumDto.getEmailContatoCV());
            cv.setSobre(curriculumDto.getSobre());
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
    public Curriculum getCv(Integer id) {
        User user = userRepositorio.findById(id).orElseThrow(UserNaoEncontrado::new);
        return curriculumRepository.findById(user.getCurriculum().getId()).orElseThrow(CvNaoEncontrado::new);
    }
}
