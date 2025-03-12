package kr.or.ddit.pay.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.pay.vo.PayStubVO;

public interface IPayStubService {
  
  public List<PayStubVO> getMyPayStubs(String emplNo, String yearr, String monthh, String dayy);

  public Map<String, Object> getPayStub(String emplNo) throws Exception;

  public void paySalary(List<String> emplNos);
}
