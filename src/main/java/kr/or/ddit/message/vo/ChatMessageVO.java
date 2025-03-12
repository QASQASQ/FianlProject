package kr.or.ddit.message.vo;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ChatMessageVO {
    private Long cmNo;           // 메시지 번호
    private Long crNo;           // 채팅방 번호
    private String emplNo;       // 사번
    private String emplNm;       // 사원명
    private String cmContent;    // 메시지 내용
    private LocalDateTime cmDate;// 메시지 전송 일자
    private String cmType;       // 메시지 타입 (예: "TEXT", "IMAGE", "FILE" 등)
    
    // 파일 메시지인 경우, 첨부된 파일의 URL (이미지 등)을 전달하기 위한 필드
    private String fileUrl;
    private String fileIdentify;

    public String getFileUrl() {
        if (this.fileUrl != null && this.fileUrl.startsWith("C:/uploadHRMS")) {
            return this.fileUrl.replace("C:/uploadHRMS", "/files").replace("\\", "/");
        }
        return this.fileUrl;
    }
}
