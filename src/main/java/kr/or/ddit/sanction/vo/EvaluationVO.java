package kr.or.ddit.sanction.vo;

import lombok.Data;

@Data
public class EvaluationVO {
	
	private int evalNo;
	private String evalSbj;
	private String emplObj;
	private String evalType;
	private int evalScore;
	private String evalDate;

}
