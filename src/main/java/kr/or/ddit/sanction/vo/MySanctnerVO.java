package kr.or.ddit.sanction.vo;

import java.util.List;

import lombok.Data;

@Data
public class MySanctnerVO {
	
	private int msNo;	// 커스텀 번호
	private String emplNo;	// 커스텀 작성자 사원번호
	private String msTitle;	// 커스텀 제목
	private String msDate;	// 커스텀 생성일
	
	private List<String> csanctnerNoList;	// 커스텀 결재자 사원번호
	
	// 리스트 받아오기용 필드
	private List<MsDetailVO> customAprList;
	
}
