package com.example.vagascozinhaapi.security;

import com.example.vagascozinhaapi.service.impl.UsuarioServiceAuthImpl;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class JwtAuthFilter extends OncePerRequestFilter {

    private JwtService jwtService;
    private UsuarioServiceAuthImpl usuarioServiceAuth;

    public JwtAuthFilter(JwtService jwtService, UsuarioServiceAuthImpl usuarioServiceAuth) {
        this.jwtService = jwtService;
        this.usuarioServiceAuth = usuarioServiceAuth;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String authorization = request.getHeader("Authorization");
        if (authorization != null && authorization.startsWith("Bearer")) {
            String token = authorization.split(" ")[1];
            boolean isValid = jwtService.validarToken(token);

            if (isValid) {
                String loginUser = jwtService.obterLoginUser(token);
                UserDetails user = usuarioServiceAuth.loadUserByUsername(loginUser);
                UsernamePasswordAuthenticationToken usuario = new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
                usuario.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                SecurityContextHolder.getContext().setAuthentication(usuario);
            }

        }

        filterChain.doFilter(request, response);
    }
}
