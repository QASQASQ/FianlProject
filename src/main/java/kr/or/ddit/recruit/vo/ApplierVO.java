package kr.or.ddit.recruit.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ApplierVO {
    private int appNo;          // 입사 지원자 번호
    private String recNo;       // 채용 공고 번호
    private String appNm;       // 이름
    private Date appDate;       // 생년 월일
    private String appTelno;    // 전화 번호
    private String appEmail;    // 이메일
    private String appDocument; // 첨부파일
    private String appAt;       // 채용여부

    private String appComment;  // 코멘트
    private String appValue;    // 평가 
}
