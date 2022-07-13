package com.example.vagascozinhaapi.dto;

import lombok.*;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class UserDto {
    private Integer idUser;
    private String email;
    private String cv;
}
