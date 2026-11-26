package org.example.ticket_platform.security.filter;

import io.jsonwebtoken.Claims;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.ticket_platform.security.exception.AuthException;
import org.example.ticket_platform.security.handler.JsonResponseWriter;
import org.example.ticket_platform.security.principal.LoginUser;
import org.example.ticket_platform.security.util.JwtUtil;
import org.example.ticket_platform.entity.User;
import org.example.ticket_platform.mappers.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.List;

/**
 * 这个类主要解析Token并完成身份认证
 */
@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    @Autowired
    private JsonResponseWriter jsonResponseWriter;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private UserMapper usermapper;

    private static final String ACCTOKEN_KEY = "login:accesstoken";

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        /*检查白名单则直接跳过*/
        String path = request.getRequestURI();
        if ("/api/auth/login".equals(path) || "/error".equals(path) || "OPTIONS".equals(request.getMethod())) {
            filterChain.doFilter(request, response);
            return;
        }
        try {
            /*读取 Authorization 请求头*/
            String reqHeader = request.getHeader("Authorization");
            if (reqHeader == null || !reqHeader.startsWith("Bearer ")) {
                throw AuthException.unauthorized("token 校验失败");
            }

            String reqtoken = reqHeader.substring(7);
            if (reqtoken.isEmpty()) {
                throw AuthException.unauthorized("token 校验失败");
            }

            /*解析 JWT：只包住 parse 本身，解析失败直接写 401 响应*/
            Claims reqtokenparse;
            try {
                reqtokenparse = jwtUtil.parse(reqtoken);
            } catch (Exception e) {
                throw AuthException.unauthorized("token 校验失败");
            }

            if (reqtokenparse == null || reqtokenparse.isEmpty()) {
                throw AuthException.unauthorized("token 校验失败");
            }

            String reqtokenType = reqtokenparse.get("token", String.class);
            if (reqtokenType == null || !"access".equals(reqtokenType)) {
                throw AuthException.unauthorized("token 校验失败");
            }

            /*获取 Token 中的身份信息*/
            Long reqid;
            try {
                reqid = Long.valueOf(reqtokenparse.getSubject());
            } catch (Exception e) {
                throw AuthException.unauthorized("token 校验失败");
            }

            String requsername = reqtokenparse.get("username", String.class);
            String reqroles = reqtokenparse.get("roles", String.class);

            /*读取 Redis 当前 Token，并区分会话失效与 Redis 不可用*/
            String redistoken;
            try {
                redistoken = stringRedisTemplate.opsForValue().get(ACCTOKEN_KEY + reqid);
            } catch (RuntimeException e) {
                throw AuthException.serviceUnavailable("服务暂不可用");
            }

            if (redistoken == null || redistoken.isEmpty() || !redistoken.equals(reqtoken)) {
                throw AuthException.unauthorized("token 校验失败");
            }

            /*按 uid 查询数据库，校验账号当前状态与角色*/
            User user;
            try {
                user = usermapper.getUserByuserid(reqid);
            } catch (RuntimeException e) {
                throw AuthException.internalServerError("身份校验失败");
            }

            if (user == null
                    || user.getStatus() == null
                    || user.getStatus() == 0
                    || user.getDeleted() == null
                    || user.getDeleted() == 1
                    || user.getId() == null
                    || !user.getId().equals(reqid)
                    || user.getRoleCode() == null
                    || !user.getRoleCode().equals(reqroles)) {
                throw AuthException.unauthorized("身份校验失败");
            }
            LoginUser loginUser = new  LoginUser();
            /*构建登录用户*/
            loginUser.setUserId(reqid);
            loginUser.setUsername(requsername);
            loginUser.setRoleCode(reqroles);
            loginUser.setCustomerId(user.getCustomerId());
            SimpleGrantedAuthority authority = new  SimpleGrantedAuthority("ROLE_"+user.getRoleCode());
            /*将loginuser包装成authencation对象*/
            UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new  UsernamePasswordAuthenticationToken(loginUser, null, List.of(authority));
            /*写入security Context*/
            SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
        }catch (AuthException e){
            jsonResponseWriter.writeJsonResponse(response,e.getCode(),e.getMessage());
            return;
        }catch (Exception e){
            jsonResponseWriter.writeJsonResponse(response,500,"系统异常");
            return;
        }
        filterChain.doFilter(request, response);
    }
}
