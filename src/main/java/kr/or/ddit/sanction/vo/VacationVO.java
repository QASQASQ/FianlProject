package kr.or.ddit.sanction.vo;

import lombok.Data;

@Data
public class VacationVO {
	
	private int yrycNo;
	private String emplNo;
	private int yrycTotal;
	private int yrycUsage;
	private int yrycRemndr;
	private int yrycReward;
	private String yrycYear;
	
	// 일 수 차감을 위한 필드
	private int count;

}
