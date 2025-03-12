package kr.or.ddit.sanction.vo;

import lombok.Data;

@Data
public class DocSortVO {
	
	private String dsSeq;		// 양식 시퀀스
	private String dsCode;		// 양식 코드
	private String dsType;		// 양식 타입
	private String dsForm;		// 양식 내용
	private String dsUsage;		// 양식 사용 여부
	private String dsPassive;	// 전결 허용 여부
	private String dsDate;		// 양식 생성일자

}
