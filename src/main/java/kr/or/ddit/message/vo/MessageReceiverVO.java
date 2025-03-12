package kr.or.ddit.message.vo;

import lombok.Data;
import java.time.LocalDateTime;

/*
* Writer: 백승권
* @return 수신자 VO
*/
@Data
public class MessageReceiverVO {
    private Long mrNo;         // 수신 고유 번호
    private Long msgNo;        // 메시지 번호 (FK)
    private String mrReceiver; // 수신자 ID
    private LocalDateTime mrDate; // 수신 시간
    private String mrDel;      // 수신자 삭제 여부 (N/Y)
}
