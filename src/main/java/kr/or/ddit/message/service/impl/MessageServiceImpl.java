package kr.or.ddit.message.service.impl;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.cmm.service.INotificationService;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.message.mapper.IMessageMapper;
import kr.or.ddit.message.service.IMessageService;
import kr.or.ddit.message.vo.MessageReceiverVO;
import kr.or.ddit.message.vo.MessageVO;
import lombok.extern.slf4j.Slf4j;

/*
* Writer: 백승권
* @return 쪽지 관련 서비스
*/ 
@Slf4j
@Service
public class MessageServiceImpl implements IMessageService {

    @Autowired
    private IMessageMapper mapper;
    
    @Autowired
    INotificationService notificationSerivce;

    @Override
    public void sendMessage(MessageVO message, List<String> receiverIds) {
    
        // 1️⃣ 메시지 저장
        mapper.sendMessage(message);
    
        // 각 수신자에 대해 사원 정보 조회 후 처리
        for (String receiverId : receiverIds) {
            // 사원 정보 조회 (매퍼의 selectEmployee 호출) (단일검색)
            List<EmployeeVO> employeeList = mapper.selectEmployee(receiverId);
    
            if(employeeList == null || employeeList.isEmpty()) {
                log.warn("입력한 수신자 (" + receiverId + ")에 해당하는 사원이 존재하지 않습니다.");
                // 상황에 따라 예외를 던지거나, 등록하지 않고 건너뛸 수 있습니다.
                continue;
            }
            if(employeeList.size() > 1) {
                log.warn("입력한 수신자 (" + receiverId + ") 정보가 모호합니다. 정확한 사원번호 또는 사원명을 입력해 주세요.");
                // 상황에 따라 예외를 던지거나, 등록하지 않고 건너뛸 수 있습니다.
                continue;
            }
            
            // 정확히 한 건의 사원 정보가 조회된 경우
            EmployeeVO employee = employeeList.get(0);
    
            // 2️⃣ 수신자 정보 저장
            MessageReceiverVO receiverVO = new MessageReceiverVO();
            receiverVO.setMsgNo(message.getMsgNo());
            // 조회된 사원의 사원번호를 사용
            receiverVO.setMrReceiver(employee.getEmplNo());
            receiverVO.setMrDate(LocalDateTime.now());
            receiverVO.setMrDel("N");
            mapper.insertReceiver(receiverVO);
    
            
            /*
             *  알림보내기
             *  작성자 김동준
             */
            notificationSerivce.sendNotification(receiverId, "쪽지가 도착하였습니다.", "01");
        }
        
    }

    @Override
    public List<MessageVO> getReceivedMessages(String receiverId) {
      return mapper.getReceivedMessages(receiverId);
    }

    @Override
    public int countReceivedMessages(String userId) {
       return mapper.countReceivedMessages(userId);
    }

    @Override
    public int countSentMessages(String userId) {
        return mapper.countSentMessages(userId);
    }

    @Override
    public int countTrashMessages(String userId) {
        return mapper.countTrashMessages(userId);
    }

    @Override
    public List<MessageVO> getSentMessages(String userId) {
        return mapper.getSentMessages(userId);
    }

    @Override
    public List<MessageVO> getTrashMessages(String userId) {
        return mapper.getTrashMessages(userId);
    }

    // 쪽지를 휴지통으로 이동
    @Override
    public void moveToTrash(int msgNo, boolean isSender, String userId) {
        if (isSender) {
            mapper.moveToTrashSent(msgNo);
        } else {
            mapper.moveToTrashReceived(msgNo, userId);
        }
    }

   // 휴지통에서 복원
   @Override
   public void restoreMessage(int msgNo, boolean isSender, String userId) {
       if (isSender) {
            mapper.restoreSentMessage(msgNo);
       } else {
            mapper.restoreReceivedMessage(msgNo, userId);
       }
   }

    // 쪽지 완전 삭제
    @Override
    public int deleteMessage(int msgNo) {
        return mapper.deleteMessage(msgNo);
    }

    // 읽지 않음 표시
    @Override
    public int markAsUnread(int msgNo) {
        return mapper.markAsUnread(msgNo);
    }

    @Override
    public MessageVO getMessageDetail(Long msgNo) {
        return mapper.getMessageDetail(msgNo);
    }

    @Override
    public List<MessageVO> getFilteredMessages(String userId, String filterDate, String filterContent) {
        return mapper.getFilteredMessages(userId, filterDate, filterContent);
    }

    @Transactional
    @Override
    public void batchDeleteMessages(List<Integer> msgNos, String userId) {
        mapper.batchDeleteSentMessages(msgNos, userId);
        mapper.batchDeleteReceivedMessages(msgNos, userId);
    }

    @Transactional
    @Override
    public void batchRestoreMessages(List<Integer> msgNos, String userId) {
        mapper.batchRestoreSentMessages(msgNos, userId);
        mapper.batchRestoreReceivedMessages(msgNos, userId);
    }

    @Transactional
    @Override
    public void batchMoveToTrash(List<Integer> msgNos, String userId) {
        mapper.batchMoveSentMessagesToTrash(msgNos, userId);
        mapper.batchMoveReceivedMessagesToTrash(msgNos, userId);
    }

    // 사원 검색(여러명)
    @Override
    public List<EmployeeVO> searchEmployees(String query) {
        return mapper.searchEmployees(query);
    }
}