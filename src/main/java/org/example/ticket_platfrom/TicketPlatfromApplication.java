package org.example.ticket_platfrom;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("org.example.ticket_platfrom.mappers")
public class TicketPlatfromApplication {

    public static void main(String[] args) {
        SpringApplication.run(TicketPlatfromApplication.class, args);
    }

}
