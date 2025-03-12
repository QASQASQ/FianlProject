package kr.or.ddit.sanction.vo;

import lombok.Data;

@Data
public class ReferenceVO {
	
	private String docNo;	// 문서 번호
	private String refNo;	// 참조자 (사원번호)
	private String refRead;	// 참조자 읽음여부
	private String refPosition;	// 참조자 직위

}
