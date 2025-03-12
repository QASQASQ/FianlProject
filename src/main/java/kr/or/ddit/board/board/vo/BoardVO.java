package kr.or.ddit.board.board.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardVO {

	private String boardNo       ;
	private String boardWriter   ;
	private String boardTitle    ;
	private String boardContent  ;
	private String boardDate     ;
	private String boardUdate    ;
	private String boardAnon     ;
	private int boardHit      ;
	private String fileIdentify  ;
	private List<MultipartFile> files;
	
}
