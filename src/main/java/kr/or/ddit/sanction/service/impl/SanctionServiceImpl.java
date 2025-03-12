package kr.or.ddit.sanction.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.cmm.service.IFileService;
import kr.or.ddit.cmm.service.INotificationService;
import kr.or.ddit.cmm.utils.FileUploadUtils;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.sanction.mapper.ISanctionMapper;
import kr.or.ddit.sanction.service.ISanctionService;
import kr.or.ddit.sanction.vo.DocSortVO;
import kr.or.ddit.sanction.vo.DocumentVO;
import kr.or.ddit.sanction.vo.EvaluationVO;
import kr.or.ddit.sanction.vo.HistoryVO;
import kr.or.ddit.sanction.vo.MsDetailVO;
import kr.or.ddit.sanction.vo.MySanctnerVO;
import kr.or.ddit.sanction.vo.ReferenceVO;
import kr.or.ddit.sanction.vo.SanctionerVO;
import kr.or.ddit.sanction.vo.VacationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SanctionServiceImpl implements ISanctionService {
	
	@Autowired
	private ISanctionMapper mapper;
	
	@Autowired
	private IFileService fileService;
	
	@Autowired
	private INotificationService nfService;
	
	@Override
	public List<DocSortVO> getDocSort() {
		
		List<DocSortVO> dvo = mapper.getDocSort();
		
		return dvo;
	}

	@Override
	public EmployeeVO getEmplInfo(String userId) {

		EmployeeVO evo = mapper.getEmplInfo(userId);
		
		return evo;
	}

	@Override
	public EmployeeVO getEmplRealInfo(EmployeeVO employeeVO) {

		EmployeeVO evo = mapper.getEmplRealInfo(employeeVO);
		
		return evo;
	}

	@Override
	public int createNewDoc(DocumentVO dvo) {
		
		
		if(dvo.getDocFile() != null) {
			String seq = fileService.selectFileSeq();
			
			for (MultipartFile file : dvo.getDocFile()) {
		        try {
					String filePath = FileUploadUtils.uploadFile(file); // 파일 c드라이브에 저장하기
					fileService.insertFile(file, filePath, seq); // 파일 DB에 인서트하기
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			dvo.setFileIdentify(seq);
		}
		
		int cnt = mapper.createNewDoc(dvo);
		
		// 받아온 결재자 사원번호 목록
		List<String> aprList = dvo.getAprList();
		
		// 결재 순번용 변수 초기화
		int flowOrder = 1;
		
		// 결재자 insert
		for(String aprEmplNo : aprList) {
			SanctionerVO svo = new SanctionerVO();
			svo.setDocNo(dvo.getDocNo());
			svo.setSanctnerNo(aprEmplNo);
			svo.setSanctnerAct(aprEmplNo);
			svo.setSanctnFlow(flowOrder++);
			svo.setSanctnStatus("01");
			mapper.createSanctner(svo);
			nfService.sendNotification(aprEmplNo, "새로운 결재 요청이 도착하였습니다.", "02");
		}
		
		// 받아온 참조자 사원번호 목록
		List<String> refList = dvo.getRefList();
		
		// 참조자 insert
		for(String refEmplNo : refList) {
			ReferenceVO rvo = new ReferenceVO();
			rvo.setDocNo(dvo.getDocNo());
			rvo.setRefNo(refEmplNo);
			mapper.createReference(rvo);
			nfService.sendNotification(refEmplNo, "새로운 결재 요청이 도착하였습니다.", "02");
		}
		
		return cnt;
	}

	@Override
	public List<DocumentVO> getDocumentsInfo(String userId, int startRow, int endRow) {
		
		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("startRow", startRow);
		params.put("endRow", endRow);
		
		List<DocumentVO> dvo = mapper.getDocumentsInfo(params);
		
		return dvo;
	}

	@Override
	public List<DocumentVO> getApvDocInfo(String userId, int startRow, int endRow) {
		
		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("startRow", startRow);
		params.put("endRow", endRow);
		
		List<DocumentVO> dvo = mapper.getApvDocInfo(params);
		
		return dvo;
	}

	@Override
	public DocumentVO getApvDocDetail(String docNo) {
		
		DocumentVO dvo = mapper.getApvDocDetail(docNo);
		
		return dvo;
	}

	@Override
	public int apvStatusUpdate(String userId, String docNo) {
		
		int cnt = mapper.apvStatusUpdate(userId, docNo);
		
		return cnt;
	}

	@Override
	public int allowUpdate(String userId, String docNo) {
		
		int cnt = mapper.allowUpdate(userId, docNo);
		
		return cnt;
	}

	@Override
	public EmployeeVO getSanctnerSign(String userId) {
		
		EmployeeVO evo = mapper.getSanctnerSign(userId);
		
		return evo;
	}

	@Override
	public int docSignUpdate(DocumentVO evo) {
		
		int cnt = mapper.docSignUpdate(evo);
		
		return cnt;
	}

	@Override
	public SanctionerVO thisDocApvStatus(SanctionerVO svo) {
		
		SanctionerVO svo2 = mapper.thisDocApvStatus(svo);
		
		return svo2;
	}

	@Override
	public int proxyUpdate(SanctionerVO svo) {
		
		int cnt = mapper.proxyUpdate(svo);
		
		return cnt;
	}

	@Override
	public EmployeeVO nowEmplInfo(String userId) {
		
		EmployeeVO evo = mapper.nowEmplInfo(userId);
		
		return evo;
	}

	@Override
	public int updateDocStatus(String docNo) {
		
		int cnt = mapper.updateDocStatus(docNo);
		
		return cnt;
	}

	@Override
	public int updateProxyDocContent(DocumentVO dvo) {
		
		int cnt = mapper.updateProxyDocContent(dvo);
		
		return cnt;
	}

	@Override
	public int historyInsert(HistoryVO hvo) {
		
		int cnt = mapper.historyInsert(hvo);
		
		return cnt;
	}

	@Override
	public DocumentVO getWriterNo(String docNo) {
		
		DocumentVO str = mapper.getWriterNo(docNo);
		
		return str;
	}

	@Override
	public int allowFinalStatus(String docNo) {
		
		int cnt = mapper.allowFinalStatus(docNo);
		
		return cnt;
	}

	@Override
	public int insertEvaluation(EvaluationVO evo) {
		
		int cnt = mapper.insertEvaluation(evo);
		
		return cnt;
	}

	@Override
	public int insertVacationHistory(HistoryVO hvo) {
		
		int cnt = mapper.insertVacationHistory(hvo);
		
		return cnt;
	}

	@Override
	public int calVacCount(VacationVO vvo) {

		int cnt = mapper.calVacCount(vvo);
		
		return cnt;
	}

	@Override
	public List<ReferenceVO> getRefList(String docNo) {
		
		List<ReferenceVO> rvo = mapper.getRefList(docNo);
		
		return rvo;
	}

	@Override
	public List<DocumentVO> getRefDocuments(String userId) {
		
		List<DocumentVO> dvo = mapper.getRefDocuments(userId);
		
		return dvo;
	}

	@Override
	public int refReadUpdate(String userId, String docNo) {
		
		int cnt = mapper.refReadUpdate(userId, docNo);
		
		return cnt;
	}

	@Override
	public int insertCustomApr(MySanctnerVO msvo) {
		
		int cnt = mapper.insertCustomApr(msvo);
		
		int flowOrder = 1;
		
		List<String> customAprList = msvo.getCsanctnerNoList();
		
		for(String apr : customAprList) {
			MsDetailVO mdvo = new MsDetailVO();
			mdvo.setMsNo(msvo.getMsNo());
			mdvo.setCsanctnerNo(apr);
			mdvo.setCsanctnerFlow(flowOrder++);
			mapper.insertCustomAprDetail(mdvo);
		}
		
		return cnt;
	}

	@Override
	public List<MySanctnerVO> getCustomSanctionLine(String userId) {
		
		List<MySanctnerVO> msvo = mapper.getCustomSanctionLine(userId);
		
		return msvo;
	}

	@Override
	public int rejectUpdate(SanctionerVO svo) {
		
		int cnt = mapper.rejectUpdate(svo);
		
		return cnt;
	}

	@Override
	public int updtDocStatus(String docNo, String status) {
		
		int cnt = mapper.updtDocStatus(docNo, status);
		
		return cnt;
	}

	@Override
	public int replaceDocHtml(DocumentVO dvo) {
		
		int cnt = mapper.replaceDocHtml(dvo);
		
		return cnt;
	}

	@Override
	@Transactional
	public int deleteCustomApr(int msNo) {
		
		int cnt = 0;
		
		// 먼저 해당 문서 번호의 개수 받아오기
		int msNoCount = mapper.selectCustomByMsNo(msNo);
		
		// 결재자 자체 먼저 삭제(무결성 오류)
		int count = mapper.deleteCustomAprDetail(msNo);
		
		if(msNoCount == count) {
			cnt = mapper.deleteCustomApr(msNo);
			return cnt;
		}
		
		return cnt;
	}

	@Override
	public int updateOpinion(String userId, String docNo, String sanctnOpinion) {
		
		int cnt = mapper.updateOpinion(userId, docNo, sanctnOpinion);
		
		return cnt;
	}

	@Override
	public int getDocumentsCount(String userId) {
		
		int cnt = mapper.getDocumentsCount(userId);
		
		return cnt;
	}

	@Override
	public int getSanctionCount(String userId) {
		
		int cnt = mapper.getSanctionCount(userId);
		
		return cnt;
	}

}
