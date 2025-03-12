package kr.or.ddit.sanction.vo;

import lombok.Data;

@Data
public class SanctionerVO {
	
	private String docNo;			// 문서 번호
	private String sanctnerNo;		// 원결재자 번호(사원번호)
	private String sanctnerAct;		// 실결재자 번호(사원번호)
	private int sanctnFlow;			// 결재 순번
	private String sanctnStatus;	// 결재 상태
	private String sanctnDate;		// 결재 일시
	private String sanctnOpinion;	// 결재 의견
	private String sanctnSignature;	// 결재 서명
	private String dcrbAt;			// 전결 여부
	private String finalAt;			// 최종 결재 여부
	
	// 직위 표시용 필드
	private String sanctnerPosition;
	// 사원번호 표시용 필드
	private String sanctnerRealNo;
	
}
