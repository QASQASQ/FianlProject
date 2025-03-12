package kr.or.ddit.pay.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.pay.vo.PayStubVO;

@Mapper
public interface IPayStubMapper {

  public List<PayStubVO> selectMyPayStubs(String emplNo, String yearr, String monthh, String dayy);

  public Map<String, Object> getPaidPayStub(String emplNo);

  public void generatePayStubPreview(String emplNo);

  public Map<String, Object> getPayStubPreview(String emplNo);

  public void deletePreviewPayStub(String emplNo);

  public void generatePayStub(String emplNo);

  public void updatePayStatus(String emplNo);

}
