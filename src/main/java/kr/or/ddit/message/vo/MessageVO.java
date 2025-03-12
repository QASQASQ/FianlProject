package kr.or.ddit.message.vo;

import lombok.Data;
import java.time.LocalDateTime;

/*
* Writer: 백승권
* @return 메시지 VO
*/
@Data
public class MessageVO {
    private Long msgNo;        // 메시지 번호
    private String msgSender;  // 발신자 ID
    private String msgContent; // 메시지 내용
    private LocalDateTime msgDate; // 보낸 시간
    private String msgDel;     // 발신자 삭제 여부 (N/Y)
    private String receiverId;

    private String senderName;
    private String receiverName;
}
