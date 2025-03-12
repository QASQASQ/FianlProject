package kr.or.ddit.message.service.impl;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.message.mapper.IChatMapper;
import kr.or.ddit.message.service.IChatMessageService;
import kr.or.ddit.message.vo.ChatMessageVO;
import kr.or.ddit.message.vo.ChatRoomParticipantVO;
import kr.or.ddit.message.vo.ChatRoomVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ChatMessageServiceImpl implements IChatMessageService {

    @Autowired
    private IChatMapper mapper;

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    /** 채팅방 생성 및 호스트 참여자 등록 */
    @Override
    public ChatRoomVO createChatRoom(ChatRoomVO chatRoom) {
        mapper.createChatRoom(chatRoom);
        ChatRoomParticipantVO hostParticipant = new ChatRoomParticipantVO();
        hostParticipant.setCrNo(chatRoom.getCrNo());
        hostParticipant.setEmplNo(chatRoom.getEmplNo());
        hostParticipant.setCmAuth("HOST");
        hostParticipant.setCmExit("N");
        mapper.insertParticipant(hostParticipant);
        return chatRoom;
    }

    /** 채팅방 참여자 등록 */
    @Override
    public void addParticipant(ChatRoomParticipantVO participant) {
        mapper.insertParticipant(participant);
    }

    /** 특정 채팅방의 참여자 목록 조회 */
    @Override
    public List<ChatRoomParticipantVO> getParticipants(Long crNo) {
        return mapper.selectParticipants(crNo);
    }

    /** 특정 참여자 조회 */
    @Override
    public ChatRoomParticipantVO getParticipant(Long crNo, String emplNo) {
        return mapper.selectParticipant(crNo, emplNo);
    }

    /** 마지막 읽은 메시지 업데이트 */
    @Override
    public void updateLastReadMessage(Long crNo, String emplNo, Long cmNo) {
        mapper.updateLastReadMessage(crNo, emplNo, cmNo);
    }

    /** 채팅방 목록 조회 */
    @Override
    public List<ChatRoomVO> getChatRooms(String emplNo) {
        return mapper.getChatRooms(emplNo);
    }

    /** 특정 채팅방 조회 */
    @Override
    public ChatRoomVO getChatRoomById(Long crNo) {
        return mapper.getChatRoomById(crNo);
    }

    /** 읽지 않은 메시지 수 조회 */
    @Override
    public int getUnreadCount(Long crNo, String emplNo) {
        Long cmNo = mapper.selectLastReadMessage(crNo, emplNo);
        return mapper.countUnreadMessages(emplNo, crNo, cmNo);
    }

    /** 안 읽은 사용자 수 조회 */
    @Override
    public int getUnreadUserCount(Long crNo, String emplNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("crNo", crNo);
        params.put("emplNo", emplNo);
        return mapper.getUnreadUserCount(params);
    }

    /** 사용자 안 읽음 여부 확인 */
    @Override
    public boolean isUserUnread(Long crNo, Long cmNo, String emplNo) {
        return mapper.isUserUnread(crNo, cmNo, emplNo) > 0;
    }

    /** 초대 기능: 참여자 추가, 시스템 메시지 저장 및 알림 전송 */
    @Override
    public void inviteUser(Long crNo, String emplNo) {
        if (emplNo == null || emplNo.isEmpty()) {
            log.warn("초대할 사용자 정보가 없습니다.");
            return;
        }
        Map<String, Object> employee = mapper.getEmployeeNameById(emplNo);
        String emplNm = (employee != null && employee.get("EMPL_NM") != null)
                ? employee.get("EMPL_NM").toString()
                : "알 수 없음";
        log.info("초대 대상: {} ({})", emplNm, emplNo);
        ChatRoomParticipantVO participant = new ChatRoomParticipantVO();
        participant.setCrNo(crNo);
        participant.setEmplNo(emplNo);
        participant.setCmAuth("GUEST");
        participant.setCmExit("N");
        participant.setEmplNm(emplNm);
        mapper.insertParticipant(participant);
        // 시스템 메시지 저장 (save() 메서드를 활용)
        ChatMessageVO systemMessage = new ChatMessageVO();
        systemMessage.setCrNo(crNo);
        systemMessage.setEmplNo("SYSTEM");
        systemMessage.setCmContent(emplNm + "(" + emplNo + ")님이 채팅방에 초대되었습니다.");
        systemMessage.setCmType("SYSTEM");
        save(systemMessage);
        messagingTemplate.convertAndSend("/topic/chat/update/" + emplNo,
                Map.of("type", "UPDATE_CHAT_LIST"));
    }

    /** 사원명 조회 */
    @Override
    public Map<String, Object> getEmployeeNameById(String emplNo) {
        return mapper.getEmployeeNameById(emplNo);
    }

    /** 특정 채팅방의 마지막 메시지 시간 조회 */
    @Override
    public LocalDateTime getLastMessageTime(Long crNo) {
        return mapper.findLastMessageTime(crNo);
    }

    /** 모든 채팅방의 최신 메시지 시간 및 안 읽은 개수 조회 */
    @Override
    public List<Map<String, Object>> getLastMessageTimeForAllRooms(String emplNo) {
        return mapper.findLastMessageTimeForAllRooms(emplNo);
    }

    /** 메시지 저장 (selectKey를 통해 cmNo 할당) */
    @Override
    public ChatMessageVO save(ChatMessageVO chatMessage) {
        mapper.sendMessage(chatMessage);
        return chatMessage;
    }

    /** 채팅방 나가기 및 방장 변경 처리 */
    @Transactional
    @Override
    public void leaveChatRoom(Long crNo, String emplNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("crNo", crNo);
        params.put("emplNo", emplNo);
        mapper.leaveChatRoomProcedure(params);
    }

    /** 메시지 페이징 조회 */
    @Override
    public List<ChatMessageVO> getMessagesPaged(Long crNo, String emplNo, int page, int size) {
        return mapper.getMessagesPaged(crNo, emplNo, page, size);
    }

    /** 마지막 메시지 번호 조회 */
    @Override
    public Long getLastMessageNo(Long crNo) {
        return mapper.getLastMessageNo(crNo);
    }

    @Override
    public String getSenderIdByMessageId(Long cmNo) {
        return mapper.getSenderIdByMessageId(cmNo);
    }

    @Override
    public List<String> selectAllParticipants(Long crNo) {
        return mapper.selectAllParticipants(crNo);
    }

}
