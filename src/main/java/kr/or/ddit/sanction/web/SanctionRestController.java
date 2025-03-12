package kr.or.ddit.sanction.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.cmm.service.IFileService;
import kr.or.ddit.cmm.vo.DocFileVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.sanction.service.ISanctionService;
import kr.or.ddit.sanction.vo.DocSortVO;
import kr.or.ddit.sanction.vo.DocumentVO;
import kr.or.ddit.sanction.vo.EvaluationVO;
import kr.or.ddit.sanction.vo.HistoryVO;
import kr.or.ddit.sanction.vo.MySanctnerVO;
import kr.or.ddit.sanction.vo.ReferenceVO;
import kr.or.ddit.sanction.vo.SanctionerVO;
import kr.or.ddit.sanction.vo.VacationVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author 김원빈
 */

@Slf4j
@RestController
@RequestMapping("/sanction")
public class SanctionRestController {
	
	@Autowired
	private ISanctionService service;
	
	@Autowired
	private IFileService fileService;
	
	@GetMapping("/getDocSort")
	public List<DocSortVO> getDocSort() {
		log.info("문서 양식 select 데이터가 호출되었습니다.");
		List<DocSortVO> dvo = service.getDocSort();
		
		return dvo;
	}

	@GetMapping("/getEmplInfo")
	public EmployeeVO getEmplInfo(String userId) {
		log.info("사원 정보 전부 호출 컨트롤러 실행");
		
		EmployeeVO evo = service.getEmplInfo(userId);
		
		return evo;
	}
	
	@GetMapping("/getEmplRealInfo")
	public EmployeeVO getEmplRealInfo(EmployeeVO employeeVO) {
		log.info("사원 정보 재호출 컨트롤러 실행");
		
		EmployeeVO evo = service.getEmplRealInfo(employeeVO);
		
		return evo;
	}
	
	@PostMapping("/createNewDoc")
	public int createNewDoc(DocumentVO dvo) {
		log.info("결재 요청 컨트롤러 실행");

		int cnt = service.createNewDoc(dvo);
		
		return cnt;
	}
	
	// 기안 문서 목록 호출(페이징 작업중)
	@GetMapping("/getDocumentsInfo")
	public Map<String, Object> getDocumentsInfo(String userId, int currentPage) {
		log.info("개인 문서 호출 컨트롤러 실행");
		log.info("개인 문서 호출 컨트롤러 currentPage: " + currentPage);
		
		PaginationInfoVO<DocumentVO> pagingVO = new PaginationInfoVO<>(10, 5);
		pagingVO.setCurrentPage(currentPage);
		
		int totalCount = service.getDocumentsCount(userId);
		pagingVO.setTotalRecord(totalCount);
		
		int startRow = pagingVO.getStartRow();
		int endRow = pagingVO.getEndRow();
		
		List<DocumentVO> dvo = service.getDocumentsInfo(userId, startRow, endRow);
		
		Map<String, Object> result = new HashMap<>();
	    result.put("pagingInfo", pagingVO);
	    result.put("documentList", dvo);
		
		return result;
	}
	
	@GetMapping("/getApvDocInfo")
	public Map<String, Object> getApvDocInfo(String userId, int currentPage) {
		log.info("결재 문서 호출 컨트롤러 실행");
		log.info("결재 문서 호출 컨트롤러 currentPage: " + currentPage);
		
		PaginationInfoVO<DocumentVO> pagingVO = new PaginationInfoVO<>(10, 5);
		pagingVO.setCurrentPage(currentPage);
		
		int totalCount = service.getSanctionCount(userId);
		pagingVO.setTotalRecord(totalCount);
		
		int startRow = pagingVO.getStartRow();
		int endRow = pagingVO.getEndRow();
		
		List<DocumentVO> dvo = service.getApvDocInfo(userId, startRow, endRow);
		
		Map<String, Object> result = new HashMap<>();
	    result.put("pagingInfo", pagingVO);
	    result.put("documentList", dvo);
		
		return result;
	}
	
	@GetMapping("/getApvDocDetail")
	public DocumentVO getApvDocDetail(String docNo) {
		log.info("결재문서 상세 정보 호출에 성공했습니다.");
		
		DocumentVO dvo = service.getApvDocDetail(docNo);
		
		if(dvo.getFileIdentify() != null) {
			List<DocFileVO> dfvo = fileService.selectFileList(dvo.getFileIdentify());
			dvo.setFileList(dfvo);
		}
		
		return dvo;
	}
	
	@PostMapping("/apvStatusUpdate")
	public int apvStatusUpdate(String userId, String docNo) {
		log.info("결재 상태 업데이트 컨트롤러 실행");
		
		int cnt = service.apvStatusUpdate(userId, docNo);
		
		return cnt;
		
	}
	
	@PostMapping("/allowUpdate")
	public int allowUpdate(String userId, String docNo) {
		log.info("승인 처리 업데이트 컨트롤러 실행");
		
		int cnt = service.allowUpdate(userId, docNo);
		
		return cnt;
	}
	
	@GetMapping("/getSanctnerSign")
	public EmployeeVO getSanctnerSign(String userId) {
		log.info("결제자 서명 받아오기 컨트롤러 실행");
		
		EmployeeVO evo = service.getSanctnerSign(userId);
		
		return evo;
	}
	
	@PostMapping("/docSignUpdate")
	public int docSignUpdate(DocumentVO evo) {
		log.info("문서 서명 업데이트 컨트롤러 실행");
		int cnt = service.docSignUpdate(evo);
		
		return cnt;
	}
	
	@GetMapping("/thisDocApvStatus")
	public SanctionerVO thisDocApvStatus(SanctionerVO svo) {
		log.info("현재 문서 내 결재상태 컨트롤러 실행");
		
		SanctionerVO svo2 = service.thisDocApvStatus(svo);
		
		return svo2;
		
	}
	
	@PostMapping("/proxyUpdate")
	public int proxyUpdate(SanctionerVO svo) {
		log.info("전결 업데이트 컨트롤러 실행");
		
		int cnt = service.proxyUpdate(svo);
		
		return cnt;
	}
	
	@GetMapping("/nowEmplInfo")
	public EmployeeVO nowEmplInfo(String userId) {
		log.info("결재 상세 내부 내 사원정보 호출");
		
		EmployeeVO evo = service.nowEmplInfo(userId);
		
		return evo;
	}
	
	@PostMapping("/updateDocStatus")
	public int updateDocStatus(String docNo) {
		log.info("전결 후 문서 상태 업데이트 실행");
		
		int cnt = service.updateDocStatus(docNo);
		
		return cnt;
	}
	
	@PostMapping("/updateProxyDocContent")
	public int updateProxyDocContent(DocumentVO dvo) {
		log.info("전결 후 문서 교체 업데이트 실행");
		
		int cnt = service.updateProxyDocContent(dvo);
		
		return cnt;
	}
	
	@GetMapping("/getWriterNo")
	public DocumentVO getWriterNo(String docNo) {
		log.info("기안자 사원번호 받아오기 실행");
		
		DocumentVO str = service.getWriterNo(docNo);
		
		return str;
	}
	
	@PostMapping("/historyInsert")
	public int historyInsert(@RequestBody HistoryVO hvo) {
		log.info("히스토리 테이블 인서트 컨트롤러 실행");
		log.info("히스토리 인서트 hvo: " + hvo);
		
		int cnt = service.historyInsert(hvo);
		
		return cnt;
	}
	
	@PostMapping("/allowFinalStatus")
	public int allowFinalStatus(String docNo) {
		log.info("최종 승인 처리 컨트롤러 실행");
		log.info("docNo: " + docNo);
		
		int cnt = service.allowFinalStatus(docNo);
		
		return cnt;
	}
	
	@PostMapping("/insertEvaluation")
	public int insertEvaluation(@RequestBody EvaluationVO evo) {
		log.info("사원 평가 인서트 컨트롤러 실행");
		log.info("사원평가 evo: " + evo);
		
		int cnt = service.insertEvaluation(evo);
		
		return cnt;
	}
	
	@PostMapping("/insertVacationHistory")
	public int insertVacationHistory(@RequestBody HistoryVO hvo) {
		log.info("휴가 히스토리 생성 컨트롤러 실행");
		log.info("휴가 히스토리 hvo: " + hvo);
		
		int cnt = service.insertVacationHistory(hvo);
		
		return cnt;
	}
	
	@PostMapping("/calVacCount")
	public int calVacCount(@RequestBody VacationVO vvo) {
		log.info("휴가 일 수 차감 컨트롤러 실행");
		log.info("휴가 일 수 차감 vvo: " + vvo);
		
		int cnt = service.calVacCount(vvo);
		
		return cnt;
	}
	
	@GetMapping("/getRefList")
	public List<ReferenceVO> getRefList(String docNo) {
		log.info("참조자 목록 받아오기 컨트롤러 실행");
		
		List<ReferenceVO> rvo = service.getRefList(docNo);
		
		return rvo;
	}
	
	@GetMapping("/getRefDocuments")
	public List<DocumentVO> getRefDocuments(String userId) {
		log.info("참조문서 목록 출력 컨트롤러 실행");
		
		List<DocumentVO> dvo = service.getRefDocuments(userId);
		
		return dvo;
	}
	
	@PostMapping("/refReadUpdate")
	public int refReadUpdate(String userId, String docNo) {
		log.info("참조자 읽음 여부 업데이트 컨트롤러 실행");
		
		int cnt = service.refReadUpdate(userId, docNo);
		
		return cnt;
	}
	
	@PostMapping("/insertCustomApr")
	public int insertCustomApr(@RequestBody MySanctnerVO msvo) {
		log.info("커스텀 결재자 생성 컨트롤러 실행");
		log.info("커스텀 결재자 생성 msvo: " + msvo);
		
		int cnt = service.insertCustomApr(msvo);
		
		return cnt;
	}
	
	@GetMapping("/getCustomSanctionLine")
	public List<MySanctnerVO> getCustomSanctionLine(String userId) {
		log.info("커스텀 결재자 목록 받아오기 컨트롤러 실행");
		log.info("커스텀 결재자 목록 userId: " + userId);
		
		List<MySanctnerVO> msvo = service.getCustomSanctionLine(userId);
		
		return msvo;
	}
	
	@PostMapping("/rejectUpdate")
	public int rejectUpdate(@RequestBody SanctionerVO svo) {
		log.info("반려 버튼 처리 컨트롤러 실행");
		log.info("반려 처리 svo: " + svo);
		
		int cnt = service.rejectUpdate(svo);
		
		return cnt;
	}
	
	@PostMapping("/updtDocStatus")
	public int updtDocStatus(String docNo, String status) {
		log.info("문서 상태 업데이트 컨트롤러 실행");
		log.info("문서 상태 업데이트 docNo: " + docNo);
		
		int cnt = service.updtDocStatus(docNo, status);
		log.info("문서 상태 업데이트 결과 cnt: " + cnt);
		
		return cnt;
	}
	
	@PostMapping("/replaceDocHtml")
	public int replaceDocHtml(DocumentVO dvo) {
		log.info("문서 html 교체 컨트롤러 실행");
		log.info("문서 html 교체 dvo: " + dvo);
		
		int cnt = service.replaceDocHtml(dvo);
		
		return cnt;
	}
	
	@PostMapping("/deleteCustomApr")
	public int deleteCustomApr(int msNo) {
		log.info("커스텀 결재자 삭제 컨트롤러 실행");
		log.info("커스텀 결재자 삭제 msNo: " + msNo);
		
		int cnt = service.deleteCustomApr(msNo);
		
		return cnt;
	}
	
	@PostMapping("/updateOpinion")
	public ResponseEntity<Integer> updateOpinion(@RequestBody Map<String, String> data) {
		String userId = data.get("userId");
		String docNo = data.get("docNo");
		String sanctnOpinion = data.get("sanctnOpinion");
		
		int cnt = service.updateOpinion(userId, docNo, sanctnOpinion);
		
		if(cnt > 0) {
			return ResponseEntity.ok(cnt);
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(cnt);
		}
		
	}
	
}
