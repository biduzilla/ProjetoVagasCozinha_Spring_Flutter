package com.example.vagascozinhaapi.service;

import com.example.vagascozinhaapi.dto.CurriculumDto;
import com.example.vagascozinhaapi.dto.CurriculumDtoId;


public interface CurriculumService {

    CurriculumDtoId salvarCv(CurriculumDto curriculumDto, String token);
    CurriculumDto getCv(String token);
    void updateCv(CurriculumDto curriculumDto, String token);
    void deleteCv(String token);
}
