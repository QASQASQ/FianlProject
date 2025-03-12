package kr.or.ddit.education.vo;

import lombok.Data;

@Data
public class BookVO {
	
    private String bookNo;         // ISBN 
    private String bookName;       // 책 제목
    private int bookPrice;         // 책 가격
    private String bookCompany;    // 출판사

}