package kr.or.ddit.message.service;

import java.util.List;

import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.message.vo.MessageVO;

/*
* Writer: 백승권
* @return 메시지 관련 서비스 인터페이스
*/ 
public interface IMessageService {


  // 받은 쪽지 조회
  public List<MessageVO> getReceivedMessages(String userId);
  // 보낸 쪽지 조회
  public List<MessageVO> getSentMessages(String userId);
  // 휴지통 조회
  public List<MessageVO> getTrashMessages(String userId);
  // 쪽지 전송
  public void sendMessage(MessageVO message, List<String> receiverIds);
  // 받은 쪽지 개수 조회
  public int countReceivedMessages(String userId);
  // 보낸 쪽지 개수 조회
  public int countSentMessages(String userId);
  // 휴지통 개수 조회
  public int countTrashMessages(String userId);
  // 쪽지를 휴지통으로 이동
  public void moveToTrash(int msgNo, boolean isSender, String userId);
  // 휴지통에서 복원
  public void restoreMessage(int msgNo, boolean isSender, String userId);
  // 쪽지 완전 삭제
  public int deleteMessage(int msgNo);
  // 읽지 않음으로 표시
  public int markAsUnread(int msgNo);
  // 쪽지 상세 정보
  public MessageVO getMessageDetail(Long msgNo);
  
  public List<MessageVO> getFilteredMessages(String userId, String filterDate, String filterContent);

  public void batchDeleteMessages(List<Integer> msgNos, String userId);

  public void batchRestoreMessages(List<Integer> msgNos, String userId);

  public void batchMoveToTrash(List<Integer> msgNos, String userId);
  public List<EmployeeVO> searchEmployees(String query);
}
