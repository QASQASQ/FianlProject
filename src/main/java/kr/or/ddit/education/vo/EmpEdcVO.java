package kr.or.ddit.education.vo;

import java.util.Date;

import lombok.Data;

@Data
public class EmpEdcVO {
	
	private int eeNumber      ;    // 수강번호
	private int edcNo    	  ;    // 교육코드
	private String emplNo     ;    // 사원번호
	private String eeStatus   ;    // 수강상태
	private Date eeBackdate   ;    // 수강철회일
	private Date eeCdate      ;    // 생성일
	private int eeProgress    ;    // 진행도
	
	private EducationVO education;

}
