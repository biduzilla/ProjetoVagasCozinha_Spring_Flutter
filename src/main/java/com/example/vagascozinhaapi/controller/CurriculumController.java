package com.example.vagascozinhaapi.controller;

import com.example.vagascozinhaapi.dto.CurriculumDto;
import com.example.vagascozinhaapi.dto.CurriculumDtoId;
import com.example.vagascozinhaapi.dto.service.impl.CurriculumServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("api/curriculum/")
@RequiredArgsConstructor
public class CurriculumController {

    private final CurriculumServiceImpl curriculumService;

    @PostMapping("salvarCv/{id}")
    @ResponseStatus(HttpStatus.CREATED)
    public CurriculumDtoId salvarCv(@RequestBody @Valid CurriculumDto curriculumDto, @PathVariable Integer id){
        return curriculumService.salvarCv(id, curriculumDto);
    }

    @GetMapping("getCv/{id}")
    public CurriculumDto getCv(@PathVariable Integer id){
        return curriculumService.getCv(id);
    }

    @PutMapping("updateCv/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void updateCv(@PathVariable Integer id,@RequestBody @Valid CurriculumDto curriculumDto){
        curriculumService.updateCv(id, curriculumDto);
    }

    @DeleteMapping("deleteCv/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteCv(@PathVariable Integer id){
        curriculumService.deleteCv(id);
    }
}
