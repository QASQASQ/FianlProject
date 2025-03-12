package kr.or.ddit.message.dto;

import java.util.List;

import lombok.Data;

/*
 * Writer: 백승권
 * @return 리스트를 JSON 데이터로 받기 위함.
 */
@Data
public class InviteRequest {
    private Long chatRoomId; // 채팅방 ID
    private List<String> emplNos; // 초대할 사용자 ID 리스트
}
