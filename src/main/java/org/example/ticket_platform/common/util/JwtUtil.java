package org.example.ticket_platform.common.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.example.ticket_platform.dto.request.LoginRequestDto;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.UUID;

@Component
public class JwtUtil {
    @Value("${jwt.secret}")
    private String Secret;
    @Value("${jwt.access-expiration}")
    private long accessExpireTime;
    @Value("${jwt.refresh-expiration}")
    private long refresExpireTime;

    private SecretKey getkey(){ return Keys.hmacShaKeyFor(Secret.getBytes(StandardCharsets.UTF_8));}

    /*生成accessToken*/
    public String createAccToken(LoginRequestDto dto, String roles){
        return Jwts.builder()
                .setSubject(dto.getUsername())
                .claim("roles",roles)
                .claim("token","access")
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis()+accessExpireTime))
                .signWith(getkey(), SignatureAlgorithm.HS256)
                .compact();
    }

    /*生成refreshToken*/
    public String createRefToken(LoginRequestDto dto, String roles){
        return Jwts.builder()
                .setSubject(dto.getUsername())
                .setId(UUID.randomUUID().toString())
                .claim("roles",roles)
                .claim("token","refresh")
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis()+refresExpireTime))
                .signWith(getkey(),SignatureAlgorithm.HS256)
                .compact();
    }
    /*解析验证token*/
    public Claims parse(String token){
        return Jwts.parser()
                .setSigningKey(getkey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }
}
