package kr.or.ddit.recruit.service.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class HireData {
    private String recNo;
    private String appNm;
    private String appEmail;
    private String emplNo;
    private String password;
    private String teamCode;
    private LocalDate hireDate;
    private String role;
}
