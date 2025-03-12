package kr.or.ddit.message.mapper;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.message.vo.ChatMessageVO;
import kr.or.ddit.message.vo.ChatRoomParticipantVO;
import kr.or.ddit.message.vo.ChatRoomVO;

/**
 * 채팅 관련 매퍼 (통합된 기능)
 * 작성자: 백승권
 */
@Mapper
public interface IChatMapper {

    // ================================
    // 1. 채팅방 관련
    // ================================

    /**
     * 새로운 채팅방을 생성합니다.
     * (호스트 참여자 등록은 서비스에서 처리)
     * @param chatRoom 생성할 채팅방 정보
     */
    void createChatRoom(ChatRoomVO chatRoom);

    /**
     * 특정 채팅방 정보를 조회합니다.
     * @param crNo 채팅방 번호
     * @return 채팅방 정보
     */
    ChatRoomVO getChatRoomById(Long crNo);

    /**
     * 사용자가 참여 중인 채팅방 목록을 조회합니다.
     * @param emplNo 사원 번호
     * @return 채팅방 목록
     */
    List<ChatRoomVO> getChatRooms(String emplNo);

    // ================================
    // 2. 채팅방 참여자 관련
    // ================================

    /**
     * 채팅방에 참여자를 등록합니다.
     * @param participant 참여자 정보
     */
    void insertParticipant(ChatRoomParticipantVO participant);

    /**
     * 특정 채팅방의 모든 참여자 목록을 조회합니다.
     * @param crNo 채팅방 번호
     * @return 참여자 목록
     */
    List<ChatRoomParticipantVO> selectParticipants(Long crNo);

    /**
     * 특정 채팅방에서 특정 참여자 정보를 조회합니다.
     * @param crNo 채팅방 번호
     * @param emplNo 사원 번호
     * @return 참여자 정보
     */
    ChatRoomParticipantVO selectParticipant(Long crNo, String emplNo);

    // ================================
    // 3. 메시지 관련
    // ================================

    /**
     * 채팅 메시지를 저장합니다.
     * (selectKey를 사용하여 cmNo를 할당)
     * @param message 저장할 메시지 정보
     */
    void sendMessage(ChatMessageVO message);

    /**
     * 채팅방의 전체 메시지 목록을 조회합니다.
     * (필요에 따라 페이징이 아닌 전체 목록 조회에 사용)
     * @param paramMap 조회 조건 (예: crNo, emplNo 등)
     * @return 메시지 목록
     */
    List<ChatMessageVO> getMessages(Map<String, Object> paramMap);

    /**
     * 채팅방의 메시지를 페이징 처리하여 조회합니다.
     * @param crNo 채팅방 번호
     * @param emplNo 사원 번호
     * @param page 페이지 번호
     * @param size 페이지당 메시지 수
     * @return 페이징된 메시지 목록
     */
    List<ChatMessageVO> getMessagesPaged(Long crNo, String emplNo, int page, int size);

    /**
     * 특정 채팅방의 마지막 메시지 번호를 조회합니다.
     * @param crNo 채팅방 번호
     * @return 마지막 메시지 번호
     */
    Long getLastMessageNo(Long crNo);

    // ================================
    // 4. 읽음 상태 관련
    // ================================

    /**
     * 채팅방 내 참여자의 마지막 읽은 메시지 번호를 업데이트합니다.
     * @param crNo 채팅방 번호
     * @param emplNo 사원 번호
     * @param cmNo 마지막으로 읽은 메시지 번호
     */
    void updateLastReadMessage(Long crNo, String emplNo, Long cmNo);

    /**
     * 특정 참여자의 마지막 읽은 메시지 번호를 조회합니다.
     * @param crNo 채팅방 번호
     * @param emplNo 사원 번호
     * @return 마지막 읽은 메시지 번호 (없으면 0)
     */
    Long selectLastReadMessage(Long crNo, String emplNo);

    /**
     * 특정 채팅방에서 사용자가 읽지 않은 메시지 개수를 조회합니다.
     * @param emplNo 사원 번호
     * @param crNo 채팅방 번호
     * @param cmNo 기준 메시지 번호
     * @return 읽지 않은 메시지 개수
     */
    int countUnreadMessages(String emplNo, Long crNo, Long cmNo);

    /**
     * 특정 채팅방에서 사용자가 읽지 않은 상태인지 여부를 확인합니다.
     * @param crNo 채팅방 번호
     * @param cmNo 메시지 번호
     * @param emplNo 사원 번호
     * @return 읽지 않은 경우 1 이상, 아니면 0
     */
    int isUserUnread(Long crNo, Long cmNo, String emplNo);

    // ================================
    // 5. 기타
    // ================================

    /**
     * 사원 번호로 사원 이름 등 정보를 조회합니다.
     * @param emplNo 사원 번호
     * @return 사원 정보가 담긴 Map
     */
    Map<String, Object> getEmployeeNameById(String emplNo);

    /**
     * 특정 채팅방의 마지막 메시지 시간을 조회합니다.
     * @param crNo 채팅방 번호
     * @return 마지막 메시지 시간
     */
    LocalDateTime findLastMessageTime(Long crNo);

    /**
     * 사용자가 참여 중인 모든 채팅방의 최신 메시지 시간 및 읽지 않은 메시지 개수를 조회합니다.
     * @param emplNo 사원 번호
     * @return 채팅방별 최신 메시지 및 읽지 않은 메시지 정보
     */
    List<Map<String, Object>> findLastMessageTimeForAllRooms(String emplNo);

    /**
     * 특정 채팅방의 읽지 않은 사용자 수를 조회합니다.
     * @param params 조회 조건 (예: crNo, cmNo, emplNo)
     * @return 읽지 않은 사용자 수
     */
    int getUnreadUserCount(Map<String, Object> params);

    /**
     * 채팅방 나가기 시, 참여자의 exit 상태를 'Y'로 업데이트합니다.
     * @param crNo 채팅방 번호
     * @param emplNo 사원 번호
     */
    void updateExitStatus(Long crNo, String emplNo);

    /**
     * 채팅방의 현재 방장 여부를 확인합니다.
     * @param crNo 채팅방 번호
     * @param emplNo 사원 번호
     * @return 방장인 경우 true, 아니면 false
     */
    boolean isHost(Long crNo, String emplNo);

    /**
     * 채팅방에서 나간 방장이 있을 경우, 새로운 방장을 찾습니다.
     * (가장 먼저 참여한 사용자를 반환)
     * @param crNo 채팅방 번호
     * @return 새로운 방장 정보
     */
    ChatRoomParticipantVO findNextHost(Long crNo);

    /**
     * 채팅방에서 새로운 방장으로 업데이트합니다.
     * @param crNo 채팅방 번호
     * @param emplNo 새로운 방장 사원 번호
     */
    void updateHost(Long crNo, String emplNo);

    String getSenderIdByMessageId(Long cmNo);

    int getNewUnreadUserCount(Long crNo, String emplNo);

    void deleteChatMessages(Long crNo);

    void deleteChatParticipants(Long crNo);

    void deleteChatRoom(Long crNo);

    void leaveChatRoomProcedure(Map<String, Object> params);

    List<String> selectAllParticipants(Long crNo);
}
