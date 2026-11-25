package org.example.ticket_platform.security.exception;

import lombok.Getter;

@Getter
public class AuthException extends RuntimeException{

    private final Integer code;

    public AuthException(Integer code,String message){
        super(message);
        this.code=code;
    }
    /*没有授权( key 不存在)(Redis 中 token 和请求 token 不一致)*/
    public static AuthException unauthorized(String message){
        return new AuthException(401,message);
    }
    /*禁止访问*/
    public static AuthException forbidden(String message){
        return new AuthException(403,message);
    }
    /*服务暂不可用(Redis 连接失败/超时)*/
    public static AuthException serviceUnavailable(String message){
        return new AuthException(503,message);
    }
    /*服务器内部出错*/
    public static AuthException internalServerError(String message){
        return new AuthException(500,message);
    }
}
