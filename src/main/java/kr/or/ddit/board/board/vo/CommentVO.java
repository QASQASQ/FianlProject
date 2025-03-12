package kr.or.ddit.board.board.vo;

import lombok.Data;

@Data
public class CommentVO {

	private String commentNo     ;
	private String commentNos    ;
	private String boardNo       ;
	private String commentWriter ;
	private String commentTitle  ;
	private String commentDate   ;
	private String commentUdate  ;
	private int depth          ;
	private String commentAnon   ;
}
