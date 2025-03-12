package kr.or.ddit.sanction.vo;

import java.util.List;

import lombok.Data;

@Data
public class TreeNodeVO {
	
	private String id;
	private String text;
	private String data;
	private List<TreeNodeVO> children;
	
}
