package org.example.ticket_platform.mappers;

import org.example.ticket_platform.entity.User;

public interface UserMapper {
    User getUserByusername(String username);
    User getUserByuserid(Long id);
    int updatepassword(String username,String password);
}
