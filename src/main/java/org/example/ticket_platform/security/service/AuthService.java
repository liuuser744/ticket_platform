package org.example.ticket_platform.security.service;

import org.example.ticket_platform.common.result.TokenResult;
import org.example.ticket_platform.security.exception.AuthException;
import org.example.ticket_platform.security.util.JwtUtil;
import org.example.ticket_platform.dto.request.LoginRequestDto;
import org.example.ticket_platform.entity.User;
import org.example.ticket_platform.mappers.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Duration;

@Service
public class AuthService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private  StringRedisTemplate StringRedisTemplate;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtil jwtUtil;

    @Value("${jwt.access-expiration}")
    private Long ACCESSTOKEN;

    /*拼接用户名*/
    private static final String FAIL_KEY = "login:fail:";
    /*单会话token*/
    private static final String ACCTOKEN_KEY = "login:accesstoken:";
    /*5次锁定*/
    private static final int MAX_FAil = 5;
    /*锁15分钟*/
    private static final int LOCK_MINUTIS=15;

    /**
     *  登录
     */
    public TokenResult login(LoginRequestDto dto) {

        String username = dto.getUsername();
        String failKey = FAIL_KEY + username;

        String failCount;
        try {
            failCount = StringRedisTemplate.opsForValue().get(failKey);
        }catch (DataAccessException e){
            throw AuthException.serviceUnavailable("服务当前不可用，请稍后再试");
        }

        /*查询错误次数，被锁定就直接拒绝*/
        if (failCount != null && Long.parseLong(failCount) >= MAX_FAil) {
            throw AuthException.unauthorized("用户名或密码错误");
        }

        /*查库，对比密码*/
        User user = userMapper.getUserByusername(username);
        if (user == null || user.getId() == null) {
            throw AuthException.unauthorized("账号或者密码错误");
        }
        if (!passwordEncoder.matches(dto.getPassword(), user.getPassword())) {
            /*密码不一致，redis数据+1；*/
            try {
                StringRedisTemplate.opsForValue().increment(failKey);
                StringRedisTemplate.expire(failKey, Duration.ofMinutes(LOCK_MINUTIS));
            }catch (DataAccessException e){
                throw AuthException.serviceUnavailable("服务当前不可用，请稍后再试");
            }
            throw AuthException.unauthorized("账号或者密码错误");
        }


        /*密码对了就删除之前的错误密码次数*/
       try {
           StringRedisTemplate.delete(failKey);
       }catch (DataAccessException e){
           throw AuthException.serviceUnavailable("服务当前不可用");
       }

        /*生成token*/
        String accToken = jwtUtil.createAccToken(user.getId(),user.getUsername(),user.getRoleCode());

        /*token存入redis*/
        String uid = String.valueOf(user.getId());
        try {
            StringRedisTemplate.opsForValue().set(ACCTOKEN_KEY+uid,accToken,Duration.ofMillis(ACCESSTOKEN));
        }catch (DataAccessException e){
            throw AuthException.serviceUnavailable("服务当前不可用，请稍后再试");
        }
        return new TokenResult(accToken);
    }

    /*退出登录*/
    public void logout(Long userid){
        try {
            StringRedisTemplate.delete(ACCTOKEN_KEY+userid);
        }catch (Exception e){
            throw AuthException.serviceUnavailable("服务当前不可用");
        }
    }

    /*修改密码*/
    public void password(String username,String oldpassword,String newpassword){
        if(username==null || oldpassword==null || newpassword==null){
            throw AuthException.unauthorized("输入值不能为空");
        }
        User userByusername = userMapper.getUserByusername(username);
        if( userByusername==null || !passwordEncoder.matches(oldpassword,userByusername.getPassword())){
            throw AuthException.unauthorized("旧密码错误，请重新输入");
        }
        try {
            userMapper.updatepassword(username,passwordEncoder.encode(newpassword));
        }catch (Exception e){
            throw AuthException.unauthorized("修改密码失败");
        }
        try {
            StringRedisTemplate.delete(ACCTOKEN_KEY+userByusername.getId());
        }catch (Exception e){
            throw AuthException.serviceUnavailable("当前服务不可用");
        }
    }
}
