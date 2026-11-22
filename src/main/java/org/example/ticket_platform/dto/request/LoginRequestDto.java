package org.example.ticket_platform.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 登录账号密码为空校验
 */
@Data
public class LoginRequestDto {
    @NotBlank(message = "账号不能为空")
    private String username;
    @NotBlank(message = "密码不能为空")
    private String password;
}
