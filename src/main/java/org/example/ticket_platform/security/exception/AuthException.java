package org.example.ticket_platform.security.exception;

import lombok.Getter;

@Getter
public class AuthException extends RuntimeException{

    private final Integer code;

    public AuthException(Integer code,String message){
        super(message);
        this.code=code;
    }
    /*Token 无效、Redis token 不匹配、用户状态异常*/
    public static AuthException unauthorized(String message){
        return new AuthException(401,message);
    }
    /*角色不足*/
    public static AuthException forbidden(String message){
        return new AuthException(403,message);
    }
    /*Redis 不可用*/
    public static AuthException serviceUnavailable(String message){
        return new AuthException(503,message);
    }
    /*数据库异常*/
    public static AuthException internalServerError(String message){
        return new AuthException(500,message);
    }
}
