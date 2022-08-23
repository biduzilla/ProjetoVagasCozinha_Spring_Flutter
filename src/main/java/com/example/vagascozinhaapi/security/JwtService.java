package com.example.vagascozinhaapi.security;

import com.example.vagascozinhaapi.VagasCozinhaApiApplication;
import com.example.vagascozinhaapi.entidade.Usuario;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.ConfigurablePropertyAccessor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.Objects;

@Service
public class JwtService {

    @Value("${security.jwt.expiracao}")
    private String expiracao;
    @Value("${security.jwt.key}")
    private String key;

    private String gerarToken(Usuario usuario) {
        long expString = Long.valueOf(expiracao);
        LocalDateTime dataHoraExpiracao = LocalDateTime.now().plusMinutes(expString);
        Date data = Date.from(dataHoraExpiracao.atZone(ZoneId.systemDefault()).toInstant());


        return Jwts.builder()
                .setSubject(usuario.getEmail())
                .setExpiration(data)
                .signWith(SignatureAlgorithm.HS512, key)
                .compact();

    }

    public Claims obterClaims(String token) throws ExpiredJwtException {
        return Jwts.parser()
                .setSigningKey(key)
                .parseClaimsJws(token)
                .getBody();
    }

    public boolean validarToken(String token) {
        try {
            Claims claims = obterClaims(token);
            Date dataExpiracao = claims.getExpiration();
            LocalDateTime localDateTime =
                    dataExpiracao.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
            return !LocalDateTime.now().isAfter(localDateTime);
        } catch (Exception e) {
            return false;
        }
    }

    public String obterLoginUser(String token) throws ExpiredJwtException{
        return (String) obterClaims(token).getSubject();
    }

    public static void main(String[] args) {
        ConfigurableApplicationContext context = SpringApplication.run(VagasCozinhaApiApplication.class);
        JwtService jwtService = context.getBean(JwtService.class);
        Usuario usuario = Usuario.builder().email("toddy").build();
        String token = jwtService.gerarToken(usuario);
        System.out.println(token);

        boolean tokenValido = jwtService.validarToken(token);
        System.out.println(tokenValido);
        System.out.println(jwtService.obterLoginUser(token));
    }
//    @Value("${security.jwt.expiracao}")
//    private String expiracao;
//
//    @Value("${security.jwt.key}")
//    private String key;
//
//    public String gerarToken(Usuario user) throws ExpiredJwtException {
//        long expString = Long.parseLong(expiracao);
//        LocalDateTime dataHoraExpiracao = LocalDateTime.now().plusMinutes(expString);
//        Instant instant = dataHoraExpiracao.atZone(ZoneId.systemDefault()).toInstant();
//        Date date = Date.from(instant);
//
//        return Jwts.builder()
//                .setSubject(user.getEmail())
//                .setExpiration(date)
//                .signWith(SignatureAlgorithm.HS512, key)
//                .compact();
//
//
//    }
//
//    private Claims obterClaims(String token){
//        return Jwts
//                .parser()
//                .setSigningKey(key)
//                .parseClaimsJws(token)
//                .getBody();
//
//    }
//
//    public boolean tokenValid(String token){
//        try{
//            Claims claims = obterClaims(token);
//            Date dataExpiration = claims.getExpiration();
//            LocalDateTime data = dataExpiration
//                    .toInstant()
//                    .atZone(ZoneId.systemDefault())
//                    .toLocalDateTime();
//            return !LocalDateTime.now().isAfter(data);
//
//        }
//        catch (Exception e){
//            return false;
//        }
//    }
//
//    public String obterLoginUser(String token) throws ExpiredJwtException{
//        return (String) obterClaims(token).getSubject();
//    }
}
