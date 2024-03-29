package com.example.vagascozinhaapi.security;

import com.example.vagascozinhaapi.VagasCozinhaApiApplication;
import com.example.vagascozinhaapi.entidade.Usuario;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Service
public class JwtService {

    @Value("${security.jwt.expiracao}")
    private String expiracao;
    @Value("${security.jwt.key}")
    private String key;

    public String gerarToken(Usuario usuario) {
        long expString = Long.parseLong(expiracao);
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
        return obterClaims(token).getSubject();
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
}
