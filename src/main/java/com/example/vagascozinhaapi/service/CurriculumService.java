package com.example.vagascozinhaapi.service;

import com.example.vagascozinhaapi.dto.CurriculumDto;
import com.example.vagascozinhaapi.dto.CurriculumDtoId;


public interface CurriculumService {

    CurriculumDtoId salvarCv(Integer id, CurriculumDto curriculumDto);
    CurriculumDto getCv(Integer id);
    void updateCv(Integer id, CurriculumDto curriculumDto);
    void deleteCv(Integer id);
}
