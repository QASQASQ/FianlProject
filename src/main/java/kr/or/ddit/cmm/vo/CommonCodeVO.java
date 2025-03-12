package kr.or.ddit.cmm.vo;

import lombok.Data;

@Data
public class CommonCodeVO {

	private String ccCode;		// 공통 코드
	private String cgGroup;		// 공통 코드 그룹
	private String ccName;		// 공통 코드 명
	private String ccExplain;	// 공통 코드 설명
	private String ccFlow;		// 공통 코드 출력 순서
	
}
