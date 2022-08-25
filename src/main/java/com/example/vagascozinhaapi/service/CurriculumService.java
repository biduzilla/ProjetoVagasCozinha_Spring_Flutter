package com.example.vagascozinhaapi.service;

import com.example.vagascozinhaapi.dto.CurriculumDto;
import com.example.vagascozinhaapi.dto.CurriculumDtoId;
import com.example.vagascozinhaapi.dto.TokenDTO;


public interface CurriculumService {

    CurriculumDtoId salvarCv(CurriculumDto curriculumDto);
    CurriculumDto getCv(TokenDTO tokenDTO);
    void updateCv(CurriculumDto curriculumDto);
    void deleteCv(TokenDTO tokenDTO);
}
