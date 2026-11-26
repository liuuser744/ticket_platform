package org.example.ticket_platform.controller;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.example.ticket_platform.common.result.Result;
import org.example.ticket_platform.common.result.TokenResult;
import org.example.ticket_platform.dto.request.LoginRequestDto;
import org.example.ticket_platform.security.principal.LoginUser;
import org.example.ticket_platform.security.principal.LoginUserContext;
import org.example.ticket_platform.security.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/api/auth")
public class JwtController {

    @Autowired
    private AuthService authService;

    @PostMapping("/login")
    public Result<TokenResult> login(@RequestBody @Valid LoginRequestDto dto) {
       return Result.success(authService.login(dto));
    }
    @PostMapping("/me")
    public Result<LoginUser> me(){
        LoginUser loginUser = LoginUserContext.getloginUser();
        return Result.success(loginUser);
    }
}
