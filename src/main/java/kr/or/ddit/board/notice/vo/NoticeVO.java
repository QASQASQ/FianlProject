package kr.or.ddit.board.notice.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NoticeVO {

	private String noticeNo     ;
	private String noticeWriter ;
	private String noticeTitle  ;
	private String noticeContent;
	private String noticeDate   ;
	private String noticeUdate  ;
	private int noticeHit    ;
	private String fileIdentify ;
	private List<MultipartFile> files;
	
	
}
