package kr.or.ddit.message.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import kr.or.ddit.message.vo.ChatMessageVO;
import kr.or.ddit.message.vo.ChatRoomParticipantVO;
import kr.or.ddit.message.vo.ChatRoomVO;

public interface IChatMessageService {

    /**
     * 새로운 채팅방을 생성하고 호스트 참여자를 등록합니다.
     * @param chatRoom 생성할 채팅방 정보
     * @return 생성된 채팅방 정보
     */
    public ChatRoomVO createChatRoom(ChatRoomVO chatRoom);

    /**
     * 채팅방에 참여자를 추가합니다.
     * @param participant 추가할 참여자 정보
     */
    public void addParticipant(ChatRoomParticipantVO participant);

    /**
     * 특정 채팅방의 모든 참여자 목록을 조회합니다.
     * @param crNo 채팅방 번호
     * @return 참여자 목록
     */
    public List<ChatRoomParticipantVO> getParticipants(Long crNo);

    /**
     * 특정 채팅방에서 특정 참여자 정보를 조회합니다.
     * @param crNo 채팅방 번호
     * @param emplNo 사원 번호
     * @return 참여자 정보
     */
    public ChatRoomParticipantVO getParticipant(Long crNo, String emplNo);

    /**
     * 채팅방 내 참여자의 마지막 읽은 메시지를 업데이트합니다.
     * @param crNo 채팅방 번호
     * @param emplNo 사원 번호
     * @param cmNo 마지막으로 읽은 메시지 번호
     */
    public void updateLastReadMessage(Long crNo, String emplNo, Long cmNo);

    /**
     * 사용자가 참여 중인 채팅방 목록을 조회합니다.
     * @param emplNo 사원 번호
     * @return 채팅방 목록
     */
    public List<ChatRoomVO> getChatRooms(String emplNo);

    /**
     * 특정 채팅방의 정보를 조회합니다.
     * @param crNo 채팅방 번호
     * @return 채팅방 정보
     */
    public ChatRoomVO getChatRoomById(Long crNo);

    /**
     * 특정 채팅방에서 사용자가 읽지 않은 메시지 수를 조회합니다.
     * @param crNo 채팅방 번호
     * @param emplNo 사원 번호
     * @return 읽지 않은 메시지 수
     */
    public int getUnreadCount(Long crNo, String emplNo);

    /**
     * 특정 채팅방에서 최신 메시지를 기준으로 읽지 않은 사용자 수를 조회합니다.
     * @param crNo 채팅방 번호
     * @param emplNo 로그인한 사용자의 사원번호
     * @return 읽지 않은 사용자 수
     */
    public int getUnreadUserCount(Long crNo, String emplNo);

    /**
     * 특정 채팅방에서 특정 사용자가 메시지를 읽지 않았는지 여부를 확인합니다.
     * @param crNo 채팅방 번호
     * @param cmNo 메시지 번호
     * @param emplNo 사원 번호
     * @return 읽지 않은 경우 true, 아니면 false
     */
    public boolean isUserUnread(Long crNo, Long cmNo, String emplNo);

    /**
     * 사용자를 채팅방에 초대합니다.
     * @param crNo 채팅방 번호
     * @param emplNo 초대할 사원 번호
     */
    public void inviteUser(Long crNo, String emplNo);

    /**
     * 사원 번호를 통해 사원 이름 정보를 조회합니다.
     * @param emplNo 사원 번호
     * @return 사원 이름 정보를 포함한 Map
     */
    public Map<String, Object> getEmployeeNameById(String emplNo);

    /**
     * 특정 채팅방의 마지막 메시지 시간을 조회합니다.
     * @param crNo 채팅방 번호
     * @return 마지막 메시지 시간
     */
    public LocalDateTime getLastMessageTime(Long crNo);

    /**
     * 사용자가 참여 중인 모든 채팅방의 최신 메시지 시간 및 읽지 않은 메시지 수를 조회합니다.
     * @param emplNo 사원 번호
     * @return 채팅방별 최신 메시지 시간 및 읽지 않은 메시지 수 정보
     */
    public List<Map<String, Object>> getLastMessageTimeForAllRooms(String emplNo);

    /**
     * 채팅 메시지를 저장합니다. (selectKey를 사용하여 cmNo를 할당)
     * @param chatMessage 저장할 메시지 정보
     * @return 저장된 메시지 정보
     */
    public ChatMessageVO save(ChatMessageVO chatMessage);

    /**
     * 채팅방에서 사용자를 나가게 처리하며, 필요시 방장을 변경합니다.
     * @param crNo 채팅방 번호
     * @param emplNo 나가는 사원 번호
     */
    public void leaveChatRoom(Long crNo, String emplNo);

    /**
     * 채팅방의 메시지를 페이징하여 조회합니다.
     * @param crNo 채팅방 번호
     * @param emplNo 사원 번호
     * @param page 페이지 번호
     * @param size 페이지당 메시지 수
     * @return 페이징된 메시지 목록
     */
    public List<ChatMessageVO> getMessagesPaged(Long crNo, String emplNo, int page, int size);

    /**
     * 특정 채팅방의 마지막 메시지 번호를 조회합니다.
     * @param crNo 채팅방 번호
     * @return 마지막 메시지 번호
     */
    public Long getLastMessageNo(Long crNo);

    public String getSenderIdByMessageId(Long cmNo);

    public List<String> selectAllParticipants(Long crNo);

}
