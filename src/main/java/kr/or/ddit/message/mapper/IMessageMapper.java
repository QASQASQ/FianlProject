package kr.or.ddit.message.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.message.vo.MessageReceiverVO;
import kr.or.ddit.message.vo.MessageVO;

/*
 * Writer: 백승권
 * @return 쪽지 관련 매퍼
 */
@Mapper
public interface IMessageMapper {

  // 쪽지 저장
  public void sendMessage(MessageVO message);
  // 수신자 저장
  public void insertReceiver(MessageReceiverVO msgReceiver);
  // 받은 쪽지 확인
  public List<MessageVO> getReceivedMessages(String receiverId);
  // 보낸 쪽지함 개수
  public int countSentMessages(String userId);
  // 받은 쪽지함 개수
  public int countReceivedMessages(String userId);
  // 휴지통 개수
  public int countTrashMessages(String userId);
  // 보낸 쪽지 확인
  public List<MessageVO> getSentMessages(String userId);
  // 휴지통 확인
  public List<MessageVO> getTrashMessages(String userId);
  // 보낸 메시지 휴지통으로 이동
  public void moveToTrashSent(int msgNo);
  // 받은 메시지 휴지통으로 이동
  public void moveToTrashReceived(int msgNo, String userId);
  // 휴지통에서 보낸메시지 복원
  public void restoreSentMessage(int msgNo);
  // 휴지통에서 받은메시지 복원
  public void restoreReceivedMessage(int msgNo, String userId);
  // 쪽지 완전 삭제
  public int deleteMessage(int msgNo);
  // 읽지 않음 표시
  public int markAsUnread(int msgNo);
  public MessageVO getMessageDetail(Long msgNo);
  public List<MessageVO> getFilteredMessages(String userId, String filterDate, String filterContent);
  public void batchDeleteSentMessages(List<Integer> msgNos, String userId);
  public void batchDeleteReceivedMessages(List<Integer> msgNos, String userId);
  public void batchRestoreSentMessages(List<Integer> msgNos, String userId);
  public void batchRestoreReceivedMessages(List<Integer> msgNos, String userId);
  public void batchMoveSentMessagesToTrash(List<Integer> msgNos, String userId);
  public void batchMoveReceivedMessagesToTrash(List<Integer> msgNos, String userId);
  public List<EmployeeVO> selectEmployee(String receiverId);
  public List<EmployeeVO> searchEmployees(String query);
}
