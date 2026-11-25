package org.example.ticket_platform.security.principal;

import lombok.Data;

@Data
public class LoginUser {
    private Long userId;
    private String username;
    private String roleCode;
    private Long customerId;
}
