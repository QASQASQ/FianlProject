package kr.or.ddit.sanction.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.cmm.vo.DocFileVO;
import lombok.Data;

@Data
public class DocumentVO {
	
	private String docNo;			// 문서번호(시퀀스)
	private String dsCode;			// 문서 양식 코드
	private String writerNo;		// 문서 작성자(사원번호)
	private String docTitle;		// 문서 제목
	private String docDate;			// 문서 작성일
	private String docContent;		// 문서 양식+value(내용)
	private String docRemark;		// 비고
	private String docPeriod;		// 보존 기한
	private String docTemp;			// 임시저장 여부
	private String sanctnRqstdt;	// 제출 일자(기안 일자);
	private String dcrbAllow;		// 전결 허용 여부
	private String docApv; 			// 문서 결재 상태
	private String finalDate;		// 결재 확정일
	private String fileIdentify;	// 파일 식별 번호

	private List<String> aprList;		// 결재자 리스트용 필드
	private List<String> refList;		// 참조자 리스트용 필드
	private List<MultipartFile> docFile;	// 파일 리스트용 필드
	
	// 상세 페이지용 추가 필드
	private String sanctnerNo;
    private String sanctnStatus;
    private String sanctnDate;
    private String emplPosition;
    private byte[] emplSignature;
    
    private List<SanctionerVO> aprRefList;	// 상세 페이지용 List 필드
    
    // 참조자용 읽음 여부 필드
    private String refRead;
    
    // 파일 목록 받아오기용 필드
    private List<DocFileVO> fileList;
}
