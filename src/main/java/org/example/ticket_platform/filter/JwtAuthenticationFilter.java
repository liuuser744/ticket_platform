package org.example.ticket_platform.filter;

import io.jsonwebtoken.Claims;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.ticket_platform.common.exception.BusinessException;
import org.example.ticket_platform.common.util.JwtUtil;
import org.example.ticket_platform.entity.User;
import org.example.ticket_platform.mappers.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import javax.swing.*;
import java.io.IOException;

/**
 * 这个类主要解析Token并完成身份认证
 */
@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;
    
    @Autowired
    private UserMapper usermapper;
    
    private User use;
    private static final String ACCTOKEN_KEY = "login:accesstoken";

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        /*检查白名单则直接跳过*/
        String path = request.getRequestURI();
        if("/auth/login".equals(path) || "/error".equals(path) || "OPTIONS".equals(request.getMethod())){
            filterChain.doFilter(request,response);
            return;
        }
        /*对Token进行解析*/
        String redisHeader = request.getHeader("Authorization");
        if(redisHeader == null || !redisHeader.startsWith("Bearer ")){
            throw new BusinessException(401,"无权限");
        }
        String token = redisHeader.substring(7);
        Claims parse = jwtUtil.parse(token);
        if(parse == null || parse.isEmpty()){
            throw new BusinessException(401,"无权限");
        }
        Long id = use.getId();
        String redisgetsub = stringRedisTemplate.opsForValue().get();
        if(redisgetsub != null){
            use = usermapper.getUserByusername(stringRedisTemplate.opsForValue().get(ACCTOKEN_KEY+ id));
            String redistoken = stringRedisTemplate.opsForValue().get(ACCTOKEN_KEY + id);
            if(redistoken.equals(redisgetsub) && use.getStatus().equals(1) && use.getDeleted().equals(0)){

            }
        }
    }
}
