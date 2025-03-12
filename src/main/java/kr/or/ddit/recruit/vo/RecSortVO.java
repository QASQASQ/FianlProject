package kr.or.ddit.recruit.vo;

import lombok.Data;

@Data
public class RecSortVO {
    private String sortNo;      // 기술항목번호
    private String recNo;       // 채용공고번호
    private String sortContent; // 기술항목내용
}
