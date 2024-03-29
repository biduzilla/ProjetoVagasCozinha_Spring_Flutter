package com.example.vagascozinhaapi.config;

import com.example.vagascozinhaapi.security.JwtAuthFilter;
import com.example.vagascozinhaapi.security.JwtService;
import com.example.vagascozinhaapi.service.impl.UsuarioServiceAuthImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.filter.OncePerRequestFilter;

@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private UsuarioServiceAuthImpl usuarioService;
    @Autowired
    private JwtService jwtService;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth
                .userDetailsService(usuarioService)
                .passwordEncoder(passwordEncoder());
    }

    @Bean
    public OncePerRequestFilter jwtFilter() {
        return new JwtAuthFilter(jwtService, usuarioService);
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.headers().frameOptions().disable();

        http
                .csrf()
                .disable()
                .authorizeRequests()
                .antMatchers("/api/vagas/cadastrar")
                .hasRole("ADMIN")
                .antMatchers("/api/vagas/aceitar/**")
                .hasRole("USER")
                .antMatchers("/api/vagas/minhasVagas")
                .hasRole("USER")
                .antMatchers("/api/vagas/verVaga/**")
                .hasRole("USER")
                .antMatchers("/api/vagas/verMinhasVagas/**")
                .hasRole("ADMIN")
                .antMatchers("/api/vagas/lastVagas/**")
                .hasRole("USER")
                .antMatchers("/api/vagas/procurar")
                .hasRole("USER")
                .antMatchers("/api/vagas/update/**")
                .hasRole("ADMIN")
                .antMatchers("/api/vagas/deletarVaga/**")
                .hasRole("ADMIN")
                .antMatchers("/api/curriculum/**")
                .hasRole("USER")
                .antMatchers("/api/vagas/lastVagas")
                .hasRole("ADMIN")
                .antMatchers("/api/users/getDados")
                .hasRole("USER")
                .antMatchers(HttpMethod.POST, "/api/users/**")
                .permitAll()
                .antMatchers("/h2-console/**")
                .permitAll()
                .antMatchers("/h2-console/")
                .permitAll()
                .antMatchers("/h2-console")
                .permitAll()
                .anyRequest().authenticated()
                .and()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .addFilterBefore(jwtFilter(), UsernamePasswordAuthenticationFilter.class);
    }

}
