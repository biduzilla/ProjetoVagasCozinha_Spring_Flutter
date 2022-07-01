package com.example.vagascozinhaapi.service;

import com.example.vagascozinhaapi.dto.CurriculumDto;
import com.example.vagascozinhaapi.dto.CurriculumDtoId;
import com.example.vagascozinhaapi.entidade.Curriculum;

public interface CurriculumService {

    CurriculumDtoId salvarCv(Integer id, CurriculumDto curriculumDto);
    Curriculum getCv(Integer id);
}
