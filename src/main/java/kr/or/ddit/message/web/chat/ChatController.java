package kr.or.ddit.message.web.chat;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.web.multipart.MultipartFile;
import kr.or.ddit.cmm.service.IFileService;
import kr.or.ddit.cmm.service.impl.NotificationServiceImpl;
import kr.or.ddit.cmm.utils.FileUploadUtils;
import kr.or.ddit.message.service.IChatMessageService;
import kr.or.ddit.message.vo.ChatMessageVO;
import kr.or.ddit.message.vo.ChatRoomParticipantVO;
import kr.or.ddit.message.vo.ChatRoomVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/chat")
public class ChatController {

    @Autowired
    private IChatMessageService service;
 
    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Autowired
    private IFileService fileService;

    @Autowired
    private NotificationServiceImpl noticeService;

    // === 채팅방 관련 ===

    /** 채팅방 생성 */
    @PostMapping("/room/create")
    public ResponseEntity<ChatRoomVO> createChatRoom(@RequestBody ChatRoomVO chatRoom) {
        service.createChatRoom(chatRoom);
        return ResponseEntity.ok(chatRoom);
    }

    /** 채팅방 목록 조회 */
    @GetMapping("/rooms")
    public ResponseEntity<List<ChatRoomVO>> getChatRooms(@RequestParam("emplNo") String emplNo) {
        List<ChatRoomVO> chatRooms = service.getChatRooms(emplNo);
        return ResponseEntity.ok(chatRooms);
    }

    /** 특정 채팅방 조회 */
    @GetMapping("/room/{crNo}")
    public ResponseEntity<ChatRoomVO> getChatRoom(@PathVariable("crNo") Long crNo) {
        ChatRoomVO chatRoom = service.getChatRoomById(crNo);
        return (chatRoom != null)
            ? ResponseEntity.ok(chatRoom)
            : ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
    }

    /** 모든 채팅방의 최신 메시지 시간 및 안 읽은 메시지 수 조회 */
    @GetMapping("/rooms/lastMessageTime")
    public ResponseEntity<List<Map<String, Object>>> getLastMessageTimeForAllRooms(@RequestParam("emplNo") String emplNo) {
        List<Map<String, Object>> lastMessageTimes = service.getLastMessageTimeForAllRooms(emplNo);
        return ResponseEntity.ok(lastMessageTimes);
    }

    /** 특정 채팅방의 메시지 조회 (페이징) */
    @GetMapping("/{crNo}/messages")
    public ResponseEntity<List<ChatMessageVO>> getMessages(
            @PathVariable("crNo") Long crNo,
            @RequestParam("emplNo") String emplNo,
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "20") int size) {
        log.info("채팅 내역 요청: crNo={}, page={}, size={}", crNo, page, size);
        List<ChatMessageVO> messages = service.getMessagesPaged(crNo, emplNo, page, size);
        return ResponseEntity.ok(messages);
    }

    // === WebSocket (메시지 전송) ===

    /** 텍스트/파일 메시지 전송 (WebSocket) */
    @MessageMapping("/sendMessage")
    public void sendMessage(@Payload ChatMessageVO chatMessage) {
        // 사원명 설정
        String emplNo = chatMessage.getEmplNo();
        Map<String, Object> empData = service.getEmployeeNameById(emplNo);
        String emplNm = (empData != null && empData.get("EMPL_NM") != null)
                ? (String) empData.get("EMPL_NM")
                : "알 수 없음";
        chatMessage.setEmplNm(emplNm);

        // 시간 설정 및 저장
        chatMessage.setCmDate(LocalDateTime.now());
        ChatMessageVO savedMessage = service.save(chatMessage);

        // 해당 채팅방 구독자에게 메시지 브로드캐스트
        String chatRoomDestination = "/topic/chatroom/" + chatMessage.getCrNo();
        messagingTemplate.convertAndSend(chatRoomDestination, savedMessage);
        
        // 전역 알림: 채팅방 목록 업데이트
        messagingTemplate.convertAndSend("/topic/chat/unread/update", "UPDATE_CHAT_LIST");
        
        // 채팅방에 참여한 모든 사용자 조회 (보낸 사람 제외)
        List<String> participants = service.selectAllParticipants(chatMessage.getCrNo());
        for (String participant : participants) {
            if (!participant.equals(emplNo)) {  // 본인 제외
                String notificationContent = emplNm + "("+ emplNo +")"+"님으로부터 새로운 메시지가 도착했습니다.";
                String notificationCode = "03";
                noticeService.sendNotification(participant, notificationContent, notificationCode);
            }
        }
    }

    /** 파일 메시지 전송 (REST) */
    @PostMapping("/fileMessage")
    public ResponseEntity<?> handleFileMessage(
            @RequestParam("file") MultipartFile file,
            @RequestParam("crNo") Long crNo,
            @RequestParam("emplNo") String emplNo,
            @RequestParam("cmContent") String cmContent) {
        try {
            // 파일 시퀀스
            String fileSeq = fileService.selectFileSeq();
            if (fileSeq == null) {
                throw new RuntimeException("fileSeq가 NULL입니다. 시퀀스를 확인하세요.");
            }

            // 파일 저장
            String fileUrl = FileUploadUtils.uploadFile(file);
            int result = fileService.insertFile(file, fileUrl, fileSeq);
            if (result <= 0) {
                return new ResponseEntity<>("파일 정보를 DB에 저장하는데 실패하였습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // 메시지 생성
            ChatMessageVO chatMessage = new ChatMessageVO();
            chatMessage.setCrNo(crNo);
            chatMessage.setEmplNo(emplNo);
            chatMessage.setCmType("FILE");
            chatMessage.setFileIdentify(fileSeq);
            chatMessage.setFileUrl(fileUrl);
            chatMessage.setCmContent(cmContent);
            chatMessage.setCmDate(LocalDateTime.now());

            ChatMessageVO savedMessage = service.save(chatMessage);

            // 응답
            Map<String, Object> response = new HashMap<>();
            response.put("fileUrl", fileUrl);
            response.put("fileIdentify", fileSeq);
            response.put("message", savedMessage);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("파일 업로드 중 에러 발생: {}", e.getMessage(), e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("파일 업로드 중 에러 발생: " + e.getMessage());
        }
    }

    // === 읽지 않은 메시지 관련 ===

    /** 읽지 않은 메시지 수 조회 */
    @GetMapping("/unread/count")
    public ResponseEntity<Map<String, Integer>> getUnreadInfo(
            @RequestParam("emplNo") String emplNo,
            @RequestParam("crNo") Long crNo,
            @RequestParam(value = "cmNo", required = false) Long cmNo) {
        log.info("안 읽은 메시지 수 조회: crNo={}, cmNo={}, emplNo={}", crNo, cmNo, emplNo);
        int unreadMessageCount = service.getUnreadCount(crNo, emplNo);
        return ResponseEntity.ok(Map.of("unreadMessageCount", unreadMessageCount));
    }

    /** 특정 메시지 기준으로, 안 읽은 사용자 수 조회 */
    @GetMapping("/message/unreadUsers")
    public ResponseEntity<Integer> getUnreadUserCount(
            @RequestParam("crNo") Long crNo,
            @RequestParam(value = "cmNo", required = false) Long cmNo,
            @RequestParam("emplNo") String emplNo) {
        log.info("안 읽은 사용자 수 조회: crNo={}, cmNo={}, emplNo={}", crNo, cmNo, emplNo);
        if (cmNo == null) {
            cmNo = service.getLastMessageNo(crNo);
        }
        // 전체 안 읽은 사용자 수
        int totalUnreadUsers = service.getUnreadUserCount(crNo, emplNo);
        log.info("전체 안 읽은 사용자 수: {}", totalUnreadUsers);

        // 메시지 발신자가 본인인지 여부
        String senderId = service.getSenderIdByMessageId(cmNo);
        boolean isUserUnread = !Objects.equals(senderId, emplNo)
                                && service.isUserUnread(crNo, cmNo, emplNo);

        // 본인 제외
        int unreadUsersExcludingSelf = Math.max(0, isUserUnread ? totalUnreadUsers - 1 : totalUnreadUsers);
        log.info("본인 제외 안 읽은 사용자 수: {}", unreadUsersExcludingSelf);

        return ResponseEntity.ok(unreadUsersExcludingSelf);
    }

    // === 채팅방 참여자 관련 ===

    /** 채팅방 참여자 등록 */
    @PostMapping("/participant")
    public ResponseEntity<String> addParticipant(@RequestBody ChatRoomParticipantVO participant) {
        log.info("채팅방 참여자 등록 요청: {}", participant);
        service.addParticipant(participant);
        return ResponseEntity.ok("참여자 등록 완료");
    }

    /** 특정 채팅방의 모든 참여자 조회 */
    @GetMapping("/{crNo}/participants")
    public ResponseEntity<List<ChatRoomParticipantVO>> getParticipants(@PathVariable("crNo") Long crNo) {
        log.info("채팅방 참여자 목록 조회: {}", crNo);
        List<ChatRoomParticipantVO> participants = service.getParticipants(crNo);
        return ResponseEntity.ok(participants);
    }

    /** 특정 참여자 정보 조회 */
    @GetMapping("/{crNo}/participant/{emplNo}")
    public ResponseEntity<ChatRoomParticipantVO> getParticipant(@PathVariable("crNo") Long crNo, @PathVariable("emplNo") String emplNo) {
        log.info("채팅방 {}의 참여자 {} 조회", crNo, emplNo);
        ChatRoomParticipantVO participant = service.getParticipant(crNo, emplNo);
        return ResponseEntity.ok(participant);
    }

    /** 마지막 읽은 메시지 업데이트 (읽음 처리) */
    @PutMapping("/{crNo}/participant/{emplNo}/lastRead")
    public ResponseEntity<Map<String, Object>> updateLastRead(
            @PathVariable("crNo") Long crNo,
            @PathVariable("emplNo") String emplNo,
            @RequestBody Map<String, Long> requestBody) {
        Long cmNo = requestBody.get("cmNo");
        if (cmNo == null) {
            cmNo = service.getLastMessageNo(crNo);
        }
        log.info("읽음 처리 요청: crNo={}, emplNo={}, cmNo={}", crNo, emplNo, cmNo);
        service.updateLastReadMessage(crNo, emplNo, cmNo);

        int unreadUsers = service.getUnreadUserCount(crNo, emplNo);
        Map<String, Object> updateData = new HashMap<>();
        updateData.put("crNo", crNo);
        updateData.put("emplNo", emplNo);
        updateData.put("lastReadCmNo", cmNo);
        updateData.put("unreadUsers", unreadUsers);

        // 특정 채팅방 구독자에게 “읽음 업데이트” 알림
        messagingTemplate.convertAndSend("/topic/chat/unread/update/" + crNo, updateData);

        return ResponseEntity.ok(Map.of("message", "읽음 처리 완료", "unreadUsers", unreadUsers));
    }

    /** 특정 채팅방의 최신 메시지 번호 조회 */
    @GetMapping("/{crNo}/latestMessage")
    public ResponseEntity<Map<String, Long>> getLatestMessage(@PathVariable("crNo") Long crNo) {
        Long latestCmNo = service.getLastMessageNo(crNo);
        return ResponseEntity.ok(Map.of("latestCmNo", latestCmNo));
    }

    /** 채팅방 나가기 */
    @PutMapping("/{crNo}/leave")
    public ResponseEntity<?> leaveChatRoom(@PathVariable Long crNo, @RequestBody Map<String, String> request) {
        String emplNo = request.get("emplNo");
        service.leaveChatRoom(crNo, emplNo);
        return ResponseEntity.ok(Map.of("message", "채팅방 나가기 완료"));
    }

    /** 채팅방 초대 */
    @PostMapping("/{crNo}/invite")
    public ResponseEntity<?> inviteUserToChatRoom(
            @PathVariable("crNo") Long crNo,
            @RequestBody Map<String, Object> requestBody) {
        log.info("채팅방 {}에 사용자 초대 요청: {}", crNo, requestBody);
        String emplNo = Objects.toString(requestBody.get("emplNo"), "").trim();
        if (emplNo.isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("error", "초대할 사용자가 없습니다."));
        }
        try {
            service.inviteUser(crNo, emplNo);
            List<ChatRoomParticipantVO> updatedParticipants = service.getParticipants(crNo);

            // 특정 사용자에게 “CHAT_ROOM_UPDATE” 알림
            messagingTemplate.convertAndSend("/topic/chat/update/" + emplNo, Map.of(
                    "type", "CHAT_ROOM_UPDATE",
                    "crNo", crNo
            ));

            return ResponseEntity.ok(Map.of(
                    "message", "초대 성공",
                    "participants", updatedParticipants
            ));
        } catch (Exception e) {
            log.error("초대 실패: {}", e.getMessage(), e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "초대 실패", "message", e.getMessage()));
        }
    }
}
