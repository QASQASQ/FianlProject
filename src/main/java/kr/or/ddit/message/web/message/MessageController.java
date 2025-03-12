package kr.or.ddit.message.web.message;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.message.service.IMessageService;
import kr.or.ddit.message.vo.MessageVO;
import lombok.extern.slf4j.Slf4j;

/*
 * 쪽지 컨트롤러
 * Writer: 백승권
 * @return 쪽지 기능 관련 컨트롤러 
 */
@Slf4j
@RestController
@RequestMapping("/message")
public class MessageController {

    @Autowired
    private IMessageService service;

    // 1️⃣ 받은 쪽지 목록 조회
    @GetMapping("/received/{userId}")
    public ResponseEntity<List<MessageVO>> getReceivedMessages(@PathVariable String userId) {
        List<MessageVO> receivedMessages = service.getReceivedMessages(userId);
        return ResponseEntity.ok(receivedMessages);
    }

    // 2️⃣ 보낸 쪽지 목록 조회
    @GetMapping("/sent/{userId}")
    public ResponseEntity<List<MessageVO>> getSentMessages(@PathVariable String userId) {
        List<MessageVO> sentMessages = service.getSentMessages(userId);
        return ResponseEntity.ok(sentMessages);
    }

    // 3️⃣ 휴지통 목록 조회
    @GetMapping("/trash/{userId}")
    public ResponseEntity<List<MessageVO>> getTrashMessages(@PathVariable String userId) {
        return ResponseEntity.ok(service.getTrashMessages(userId));
    }

    // 5️⃣ 새 쪽지 전송
    @PostMapping("/send")
    public ResponseEntity<String> sendMessage(@RequestBody MessageVO message) {
        log.info("## sendMessage() 호출됨");
        log.info("## message.getReceiverId(): " + message.getReceiverId());  // ✅ Null 체크 로그 추가

        if (message.getReceiverId() == null || message.getReceiverId().trim().isEmpty()) {
            log.error("🚨 receiverId가 null 또는 비어 있음!");
            return ResponseEntity.badRequest().body("수신자가 없습니다.");
        }

        // ✅ receiverId를 리스트로 변환할 때 Null 방지 처리
        List<String> receiverIds = Arrays.asList(message.getReceiverId().trim().split("\\s*,\\s*")); // 공백 포함 콤마 제거

        log.info("## 수신자 목록: " + receiverIds);

        // 메시지 전송 서비스 호출
        service.sendMessage(message, receiverIds);

        return ResponseEntity.ok("쪽지가 전송되었습니다.");
    }

    // 6️⃣ 전체 쪽지 개수 조회
    @GetMapping("/count/{userId}")
    public ResponseEntity<Map<String, Integer>> getMessageCounts(@PathVariable String userId) {
        int receivedCount = service.countReceivedMessages(userId);
        int sentCount = service.countSentMessages(userId);
        int trashCount = service.countTrashMessages(userId);

        // JSON 응답을 위한 Map 사용
        Map<String, Integer> counts = new HashMap<>();
        counts.put("receivedCount", receivedCount);
        counts.put("sentCount", sentCount);
        counts.put("trashCount", trashCount);

        return ResponseEntity.ok(counts);
    }

    // 7️⃣ 쪽지를 휴지통으로 이동
    @PostMapping("/{msgNo}/trash")
    public ResponseEntity<String> moveToTrash(
            @PathVariable int msgNo,
            @RequestBody Map<String, Boolean> requestBody) {

        boolean isSender = requestBody.get("isSender"); // 자동 판별된 값
        String userId = SecurityContextHolder.getContext().getAuthentication().getName(); // 현재 로그인된 사용자

        service.moveToTrash(msgNo, isSender, userId);
        return ResponseEntity.ok("쪽지가 휴지통으로 이동되었습니다.");
    }

    // 8️⃣ 쪽지 복원
    @PostMapping("/{msgNo}/restore")
    public ResponseEntity<String> restoreMessage(
        @PathVariable int msgNo,
        @RequestBody Map<String, Object> requestBody  // ✅ `Object`로 받아서 userId도 포함
    ) {
        boolean isSender = (boolean) requestBody.get("isSender");
        String userId = (String) requestBody.get("userId");  // ✅ `userId`를 `@RequestBody`에서 추출

        if (userId == null) {
            return ResponseEntity.badRequest().body("Missing userId");
        }

        service.restoreMessage(msgNo, isSender, userId);
        return ResponseEntity.ok("복원 완료");
    }

    // 9️⃣ 쪽지 삭제 (DELETE 요청)
    @DeleteMapping("/{msgNo}/delete")
    public ResponseEntity<String> deleteMessage(@PathVariable int msgNo) {
        int deletedRows = service.deleteMessage(msgNo);
        return deletedRows > 0 ? ResponseEntity.ok("Deleted") : ResponseEntity.status(HttpStatus.NOT_FOUND).body("Not Found");
    }

    // 🔟 쪽지를 읽지 않음으로 표시 (Post 요청)
    @PostMapping("/{msgNo}/unread")
    public ResponseEntity<String> markAsUnread(@PathVariable int msgNo) {
        int updatedRows = service.markAsUnread(msgNo);
        return updatedRows > 0 ? ResponseEntity.ok("Marked as Unread") : ResponseEntity.status(HttpStatus.NOT_FOUND).body("Not Found");
    }

    // 📨 쪽지 상세 정보 가져오기
    @GetMapping("/{msgNo}/detail")
    public ResponseEntity<MessageVO> getMessageDetail(@PathVariable Long msgNo) {
        MessageVO message = service.getMessageDetail(msgNo);
        return ResponseEntity.ok(message);
    }
    
    // 필터링
    @GetMapping("/filter")
    public List<MessageVO> getFilteredMessages(
        @RequestParam(required = false) String userId,
        @RequestParam(required = false) String filterDate,
        @RequestParam(required = false) String filterContent
    ) {
        return service.getFilteredMessages(userId, filterDate, filterContent);
    }

      // 📌 일괄 휴지통 이동
    @PostMapping("/bulk-trash")
    public ResponseEntity<Void> batchMoveToTrash(@RequestBody Map<String, Object> requestData) {
        List<Integer> msgNos = (List<Integer>) requestData.get("msgNos");
        String userId = (String) requestData.get("userId");
        log.info("📌 batchMoveToTrash 요청: msgNos={}, userId={}", msgNos, userId);
        service.batchMoveToTrash(msgNos, userId);
        return ResponseEntity.ok().build();
    }

    // ✅ 일괄 복원
    @PostMapping("/bulk-restore")
    public ResponseEntity<Void> batchRestoreMessages(@RequestBody Map<String, Object> requestData) {
        List<Integer> msgNos = (List<Integer>) requestData.get("msgNos");
        String userId = (String) requestData.get("userId");
        log.info("✅ batchRestoreMessages 요청: msgNos={}, userId={}", msgNos, userId);
        service.batchRestoreMessages(msgNos, userId);
        return ResponseEntity.ok().build();
    }

    // 🗑 일괄 삭제
    @DeleteMapping("/bulk-delete")
    public ResponseEntity<Void> batchDeleteMessages(@RequestBody Map<String, Object> requestData) {
        List<Integer> msgNos = (List<Integer>) requestData.get("msgNos");
        String userId = (String) requestData.get("userId");
        log.info("🗑 batchDeleteMessages 요청: msgNos={}, userId={}", msgNos, userId);
        service.batchDeleteMessages(msgNos, userId);
        return ResponseEntity.ok().build();
    }

    // 사원 검색
    @GetMapping("/search")
    public List<EmployeeVO> searchEmployees(@RequestParam String query) {
        return service.searchEmployees(query);
    }
}
