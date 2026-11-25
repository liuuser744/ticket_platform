package org.example.ticket_platform.controller;


import jakarta.validation.Valid;
import org.example.ticket_platform.common.result.Result;
import org.example.ticket_platform.common.result.TokenResult;
import org.example.ticket_platform.dto.request.LoginRequestDto;
import org.example.ticket_platform.security.principal.LoginUser;
import org.example.ticket_platform.security.principal.LoginUserContext;
import org.example.ticket_platform.security.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/auth")
public class JwtController {

    @Autowired
    private AuthService authService;

    @PostMapping("/login")
    public Result<TokenResult> login(@RequestBody @Valid LoginRequestDto dto) {
       return Result.success(authService.login(dto));
    }
    @GetMapping("/me")
    public Result<LoginUser> me(){
        LoginUser loginUser = LoginUserContext.getloginUser();
        return Result.success(loginUser);
    }
    @PostMapping("/logout")
    public Result logout(){
        LoginUser loginUser = LoginUserContext.getloginUser();
        authService.logout(loginUser.getUserId());
        return Result.success();
    }
    /*修改自己的登录密码*/
    @PutMapping("/password")
    public Result<Void> password(String oldpassword,String newpassword){
        LoginUser loginUser = LoginUserContext.getloginUser();
        authService.password(loginUser.getUsername(),oldpassword,newpassword);
        return Result.success();
    }
}
