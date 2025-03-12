package kr.or.ddit.cmm.vo;

import lombok.Data;

@Data
public class DocFileVO {

	private String fileIdentify ;
	private int fileNo      	;
	private String fileFrom     ;
	private String fileName     ;
	private long fileSize     ;
	private String fileFancysize;
	private String fileMime     ;
	private String filePath     ;
	private String fileRegdate  ;
}
