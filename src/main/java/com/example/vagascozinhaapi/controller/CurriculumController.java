package com.example.vagascozinhaapi.controller;

import com.example.vagascozinhaapi.dto.CurriculumDto;
import com.example.vagascozinhaapi.dto.CurriculumDtoId;
import com.example.vagascozinhaapi.entidade.Curriculum;
import com.example.vagascozinhaapi.service.impl.CurriculumServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/curriculum/")
@RequiredArgsConstructor
public class CurriculumController {

    private final CurriculumServiceImpl curriculumService;

    @PostMapping("salvar/{id}")
    @ResponseStatus(HttpStatus.CREATED)
    public CurriculumDtoId salvarCv(@RequestBody CurriculumDto curriculumDto, @PathVariable Integer id){
        return curriculumService.salvarCv(id, curriculumDto);
    }

    @GetMapping("{id}")
    public Curriculum getCv(@PathVariable Integer id){
        return curriculumService.getCv(id);
    }
}
