package kr.or.ddit.message.vo;

import java.time.LocalDateTime;

import lombok.Data;

/*
 * Writer: 백승권
 * @return 채팅방 참여자 VO
 */
@Data
public class ChatRoomParticipantVO {
    private Long crNo;         // 채팅방 번호
    private String emplNo;     // 직원 번호
    private Long cmNo;         // 마지막으로 읽은 메시지 번호
    private String cmAuth;     // 참여 권한 (HOST/GUEST)
    private LocalDateTime crDate;       // 참여일자
    private String cmExit;     // 퇴장 여부 ('N' 기본값)

    private String emplNm;     // 직원 이름
}
