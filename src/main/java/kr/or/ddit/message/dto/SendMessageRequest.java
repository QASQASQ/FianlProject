package kr.or.ddit.message.dto;

import java.util.List;

import kr.or.ddit.message.vo.MessageVO;
import lombok.Data;

/*
 * Writer: 백승권
 * @return 리스트를 JSON 데이터로 받기 위함.
 */
@Data
public class SendMessageRequest {
    private MessageVO message;
    private List<Integer> receivers;
}

