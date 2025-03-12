package kr.or.ddit.education.vo;

import java.util.Date;

import lombok.Data;

@Data
public class EdcRequestVO {

	private String edcAplc     ;  // 교육신청자
	private int edcNo          ;  // 교육번호
	private String erDate      ;  // 교육신청일자
	private String erStatus    ;  
	
	// EMPLOYEE
	private String emplNm      ;	// 사원 명
	private String emplPosition;	// 사원 직위
	private String deptCode    ;	// 부서 코드
	private String teamCode    ;	// 팀 코드

}
