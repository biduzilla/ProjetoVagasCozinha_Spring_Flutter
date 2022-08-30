package com.example.vagascozinhaapi.controller;

import com.example.vagascozinhaapi.dto.CurriculumDto;
import com.example.vagascozinhaapi.dto.CurriculumDtoId;
import com.example.vagascozinhaapi.dto.TokenDTO;
import com.example.vagascozinhaapi.service.impl.CurriculumServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("api/curriculum/")
@RequiredArgsConstructor
public class CurriculumController {

    private final CurriculumServiceImpl curriculumService;

    @PostMapping("/salvarCv")
    @ResponseStatus(HttpStatus.CREATED)
    public CurriculumDtoId salvarCv(@RequestBody @Valid CurriculumDto curriculumDto, @RequestHeader("Authorization") String token){
        return curriculumService.salvarCv(curriculumDto, token);
    }

    @GetMapping("/getCv")
    public CurriculumDto getCv(@RequestHeader("Authorization") String token){
        return curriculumService.getCv(token);
    }

    @PutMapping("/updateCv")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void updateCv(@RequestBody @Valid CurriculumDto curriculumDto, @RequestHeader("Authorization") String token){
        curriculumService.updateCv(curriculumDto, token);
    }

    @DeleteMapping("/deleteCv")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteCv(@RequestHeader("Authorization") String token){
        curriculumService.deleteCv(token);
    }
}
