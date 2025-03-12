package kr.or.ddit.sanction.service;

import java.util.List;

import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.sanction.vo.DocSortVO;
import kr.or.ddit.sanction.vo.DocumentVO;
import kr.or.ddit.sanction.vo.EvaluationVO;
import kr.or.ddit.sanction.vo.HistoryVO;
import kr.or.ddit.sanction.vo.MySanctnerVO;
import kr.or.ddit.sanction.vo.ReferenceVO;
import kr.or.ddit.sanction.vo.SanctionerVO;
import kr.or.ddit.sanction.vo.VacationVO;

public interface ISanctionService {

	public List<DocSortVO> getDocSort();

	public EmployeeVO getEmplInfo(String userId);

	public EmployeeVO getEmplRealInfo(EmployeeVO employeeVO);

	public int createNewDoc(DocumentVO dvo);
	
	// 기안 문서 목록 호출
	public List<DocumentVO> getDocumentsInfo(String userId, int startRow, int endRow);

	public List<DocumentVO> getApvDocInfo(String userId, int startRow, int endRow);

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

	public List<MySanctnerVO> getCustomSanctionLine(String userId);

	public int rejectUpdate(SanctionerVO svo);

	public int updtDocStatus(String docNo, String status);

	public int replaceDocHtml(DocumentVO dvo);

	public int deleteCustomApr(int msNo);

	public int updateOpinion(String userId, String docNo, String sanctnOpinion);

	public int getDocumentsCount(String userId);

	public int getSanctionCount(String userId);

}
