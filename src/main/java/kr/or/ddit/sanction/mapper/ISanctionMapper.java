package kr.or.ddit.sanction.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.sanction.vo.DocSortVO;
import kr.or.ddit.sanction.vo.DocumentVO;
import kr.or.ddit.sanction.vo.EvaluationVO;
import kr.or.ddit.sanction.vo.HistoryVO;
import kr.or.ddit.sanction.vo.MsDetailVO;
import kr.or.ddit.sanction.vo.MySanctnerVO;
import kr.or.ddit.sanction.vo.ReferenceVO;
import kr.or.ddit.sanction.vo.SanctionerVO;
import kr.or.ddit.sanction.vo.VacationVO;

@Mapper
public interface ISanctionMapper {

	public List<DocSortVO> getDocSort();

	public EmployeeVO getEmplInfo(String userId);

	public EmployeeVO getEmplRealInfo(EmployeeVO employeeVO);

	public int createNewDoc(DocumentVO dvo);

	public void createSanctner(SanctionerVO svo);

	public void createReference(ReferenceVO rvo);
	
	// 기안문서 호출 페이징
	public List<DocumentVO> getDocumentsInfo(Map<String, Object> params);

	public List<DocumentVO> getApvDocInfo(Map<String, Object> params);

	public DocumentVO getApvDocDetail(String docNo);

	public int apvStatusUpdate(String userId, String docNo);

	public int allowUpdate(String userId, String docNo);

	public EmployeeVO getSanctnerSign(String userId);

	public int docSignUpdate(DocumentVO evo);

	public SanctionerVO thisDocApvStatus(SanctionerVO svo);

	public int proxyUpdate(SanctionerVO svo);

	public EmployeeVO nowEmplInfo(String userId);

	public int updateDocStatus(String docNo);

	public int updateProxyDocContent(DocumentVO dvo);

	public int historyInsert(HistoryVO hvo);

	public DocumentVO getWriterNo(String docNo);

	public int allowFinalStatus(String docNo);

	public int insertEvaluation(EvaluationVO evo);

	public int insertVacationHistory(HistoryVO hvo);

	public int calVacCount(VacationVO vvo);

	public List<ReferenceVO> getRefList(String docNo);

	public List<DocumentVO> getRefDocuments(String userId);

	public int refReadUpdate(String userId, String docNo);

	public int insertCustomApr(MySanctnerVO msvo);

	public void insertCustomAprDetail(MsDetailVO mdvo);

	public List<MySanctnerVO> getCustomSanctionLine(String userId);

	public int rejectUpdate(SanctionerVO svo);

	public int updtDocStatus(String docNo, String status);

	public int replaceDocHtml(DocumentVO dvo);

	public int deleteCustomApr(int msNo);

	public int selectCustomByMsNo(int msNo);

	public int deleteCustomAprDetail(int msNo);

	public int updateOpinion(String userId, String docNo, String sanctnOpinion);

	public int getDocumentsCount(String userId);

	public int getSanctionCount(String userId);
	
}
