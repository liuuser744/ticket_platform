package org.example.ticket_platform.common.exception;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class BusinessException extends RuntimeException{

    private Integer code;

    public BusinessException(String message){
        super(message);
        this.code=500;
    }
    public BusinessException(Integer code, String message){
        super(message);
        this.code=code;
    }
    public Integer getcode(){
        return this.code;
    }
}
