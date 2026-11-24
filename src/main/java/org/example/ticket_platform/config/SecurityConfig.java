package org.example.ticket_platform.config;


import org.example.ticket_platform.filter.JwtAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

/**
 * 放行白名单
 */
@Configuration
public class SecurityConfig {

    @Autowired
    private JwtAuthenticationFilter jwtauthenticationFilter;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                //关闭csrf
                .csrf(csrf ->csrf.disable())
                //设置session为无状态
                .sessionManagement(
                        Session -> Session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )
                //放行登录
                .authorizeHttpRequests(
                        auth ->auth
                                .requestMatchers("/auth/login").permitAll()
                                .requestMatchers("/error").permitAll()
                                .requestMatchers(HttpMethod.OPTIONS,"/**").permitAll()
                                .anyRequest().authenticated()
                )
                .addFilterBefore(jwtauthenticationFilter, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }

    @Bean
    public BCryptPasswordEncoder  bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public FilterRegistrationBean<JwtAuthenticationFilter> disabledJwtFilter(JwtAuthenticationFilter filter){
        FilterRegistrationBean filterBean = new FilterRegistrationBean<>(filter);
        filterBean.setEnabled(false);
        return filterBean;
    }
}
