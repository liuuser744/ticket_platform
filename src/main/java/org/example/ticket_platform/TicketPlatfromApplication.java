package org.example.ticket_platform;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("org.example.ticket_platform.mappers")
public class TicketPlatfromApplication {

    public static void main(String[] args) {
        SpringApplication.run(TicketPlatfromApplication.class, args);
    }

}
