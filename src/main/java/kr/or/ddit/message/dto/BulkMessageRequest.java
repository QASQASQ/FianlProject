package kr.or.ddit.message.dto;

import java.util.List;

/*
 * Writer: 백승권
 * @return 리스트를 JSON 데이터로 받기 위함.
 */
public class BulkMessageRequest {
  private List<Long> msgNos;

  public List<Long> getMsgNos() {
      return msgNos;
  }

  public void setMsgNos(List<Long> msgNos) {
      this.msgNos = msgNos;
  }
}
