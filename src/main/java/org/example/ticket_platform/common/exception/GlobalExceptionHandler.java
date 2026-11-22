package org.example.ticket_platform.common.exception;


import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.example.ticket_platform.common.result.Result;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(BusinessException.class)
    public Result<Void> handleBusinessException(BusinessException e, HttpServletRequest request){
        log.warn("业务异常 url={} msg={}",request.getRequestURL(),e.getMessage());
        return Result.fail(e.getcode(),e.getMessage());
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Result<Void> handleVaildException(MethodArgumentNotValidException e){
        String msg=e.getBindingResult().getFieldErrors().isEmpty()
                ? "参数校验失败"
                : e.getBindingResult().getFieldErrors().get(0).getDefaultMessage();
        return Result.fail(400,msg);
    }

    @ExceptionHandler(Exception.class)
    public Result<Void> handlerException(Exception e){
        log.error("系统异常",e);
        return Result.fail(500,"系统繁忙，请稍后再试");
    }
}
