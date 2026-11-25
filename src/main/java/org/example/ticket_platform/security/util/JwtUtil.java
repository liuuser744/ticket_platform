package org.example.ticket_platform.security.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
@Component
public class JwtUtil {
    @Value("${jwt.secret}")
    private String Secret;
    @Value("${jwt.access-expiration}")
    private long accessExpireTime;

    private SecretKey getkey(){ return Keys.hmacShaKeyFor(Secret.getBytes(StandardCharsets.UTF_8));}

    /*生成accessToken*/
    public String createAccToken(Long id,String username, String roles){
        return Jwts.builder()
                .setSubject(String.valueOf(id))
                .claim("username",username)
                .claim("roles",roles)
                .claim("token","access")
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis()+accessExpireTime))
                .signWith(getkey(), SignatureAlgorithm.HS256)
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
