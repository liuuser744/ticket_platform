package org.example.ticket_platform.security.handler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * 这个类主要处理security中的因为未登录等文件鉴权失败的异常
 */
@Component
public class JwtAuthEntryPoint implements AuthenticationEntryPoint {

    @Autowired
    private JsonResponseWriter jsonResponseWriter;

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {
        jsonResponseWriter.writeJsonResponse(response,401,"未登录或者登录失败");
    }
}
