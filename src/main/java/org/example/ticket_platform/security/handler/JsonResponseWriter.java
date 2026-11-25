package org.example.ticket_platform.security.handler;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletResponse;
import org.example.ticket_platform.common.result.Result;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class JsonResponseWriter {
    private final static ObjectMapper OBJECT_MAPPER = new ObjectMapper();
    public void writeJsonResponse(HttpServletResponse response,int code,String message) throws IOException {
        response.setStatus(code);
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("utf-8");
        Result<Void> result = Result.fail(code,message);
        OBJECT_MAPPER.writeValue(response.getWriter(),result);
        response.getWriter().flush();
    }
}
