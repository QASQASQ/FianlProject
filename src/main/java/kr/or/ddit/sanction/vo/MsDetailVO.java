package kr.or.ddit.sanction.vo;

import lombok.Data;

@Data
public class MsDetailVO {
	
	private int msNo;
	private String csanctnerNo;
	private int csanctnerFlow;
	
	// 사원 이름 받아오기용 필드
	private String emplNm;
	private String emplPosition;

}
