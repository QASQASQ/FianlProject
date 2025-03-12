package kr.or.ddit.message.vo;


import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ChatRoomVO {
    private Long crNo;         // 채팅방 번호
    private String emplNo;     // 생성한 직원 번호
    private String crTitle;    // 방 제목
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime crDate;       // 생성일자
}
