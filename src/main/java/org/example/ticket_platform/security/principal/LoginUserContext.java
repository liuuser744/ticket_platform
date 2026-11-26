package org.example.ticket_platform.security.principal;

import org.example.ticket_platform.security.exception.AuthException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;


/**
 *  这个类主要负责从SecurityContextHandler中取出数据
 */

@Component
public class LoginUserContext {

    private AuthException authException;

    public static LoginUser getloginUser(){
        SecurityContext context = SecurityContextHolder.getContext();
        Authentication authentication = context.getAuthentication();
        /*主要用来判断认证是否为空，认证是否为空，是否为已登录，是否为匿名token*/
        if( authentication==null || !authentication.isAuthenticated() || authentication instanceof AnonymousAuthenticationToken){
            throw AuthException.unauthorized("未登录");
        }
        Object principal = authentication.getPrincipal();
        if(!(principal instanceof LoginUser loginUser)){
            throw AuthException.unauthorized("登录异常");
        }
        return loginUser;
    }
}
