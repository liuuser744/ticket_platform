package org.example.ticket_platform.common.result;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 搭建统一响应体
 * @param <T>
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Result<T> {
    private Integer code;
    private String message;
    private T data;
    public static<T> Result<T> fail(Integer code,String message){
        return new Result<>(code,message,null);
    }
    public static<T> Result<T> success(){
        return new Result<>(200,"成功",null);
    }
    public static<T> Result<T> success(T data){
        return new Result<>(200,"成功",data);
    }
}
