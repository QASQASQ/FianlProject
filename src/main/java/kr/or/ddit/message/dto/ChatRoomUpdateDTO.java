package kr.or.ddit.message.dto;

import lombok.Data;

@Data
public class ChatRoomUpdateDTO {
    private Long crNo;             // 채팅방 ID
    private String Type;           // 타입
}
