package kr.or.ddit.attendance.web;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.attendance.service.IAttendanceService;
import kr.or.ddit.attendance.vo.DiligenceAndLazinessVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 출퇴근관련 컨트롤러
 * 김동준
 */
@Slf4j
@Controller
@RequestMapping("/hrms/attendance")
public class AttendanceRestController {

	@Autowired
	IAttendanceService service;
	
	// 나의 출근기록을 가져오는 메소드
	@PostMapping("/getMyPunchOut")
	public ResponseEntity<Map<String, Object>> getMyPunchOut(
			@RequestBody Map<String, String> paramMap
		) {
		Map<String, Object> resultMap = new HashMap<>(); // 리스폰스엔티티에 담을 맵
		ResponseEntity<Map<String, Object>> entity = null; // 리턴할 리스폰스엔티티 객체
		String emplNo = paramMap.get("emplNo").toString(); // 사원정보 가져오기
		int cuurentPage = Integer.parseInt(paramMap.get("page").toString()); // 사원정보 가져오기
		String dateStart = null;
		String dateEnd = null;
		if(paramMap.get("dateStart") != null) {
			dateStart = paramMap.get("dateStart").toString().replace('-', '/');
		}
		if(paramMap.get("dateEnd") != null) {
			dateEnd = paramMap.get("dateEnd").toString().replace('-', '/');
		}
		log.info("dateFrom : " + dateStart);
		log.info("dateEnd : " + dateEnd);
		
		PaginationInfoVO<DiligenceAndLazinessVO> pagingVO = new PaginationInfoVO<>(); // 페이지VO 객체생성
		pagingVO.setEmplNo(emplNo);
		pagingVO.setDateStart(dateStart);
		pagingVO.setDateEnd(dateEnd);
		int totalRecord = service.selectDalCount(pagingVO); // 총 게시글수 가져오기
		pagingVO.setCurrentPage(cuurentPage);
		pagingVO.setTotalRecord(totalRecord);
		List<DiligenceAndLazinessVO> dalList = service.selectDiligenceAndLazinessList(pagingVO);
		resultMap.put("pagingVO", pagingVO);
		if(dalList != null && dalList.size() > 0) {
			resultMap.put("dalList", dalList);
			entity = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
		}
		return entity;
	}
	
	// 나의 가장 최근출근기록 하나를 가져오기
	@PostMapping("/getTodayPunchOut")
	public ResponseEntity<DiligenceAndLazinessVO> getTodayPunchOut(@RequestBody Map<String, String> paramMap){
		String emplNo = paramMap.get("emplNo");
		DiligenceAndLazinessVO dalVO = service.selectLastDal(emplNo);
		return new ResponseEntity<DiligenceAndLazinessVO>(dalVO, HttpStatus.OK);
	}
	
	// 출근하기
	@PostMapping("/punchOut")
	public ResponseEntity<String> punchOut(@RequestBody Map<String, String> map){
		String emplNo = map.get("emplNo").toString();
		log.info("출근한 사원의 사번 " + emplNo);
		int result = service.insertDiligenceAndLaziness(emplNo);
		ResponseEntity<String> entity = null;
		if(result > 0) {
			entity = new ResponseEntity<String>("출근 성공", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>("출근 실패", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// 퇴근하기
	@PostMapping("/goHome")
	public ResponseEntity<String> goHome(@RequestBody Map<String, String> map){
		String emplNo = map.get("emplNo").toString();
		log.info("퇴근한 사원의 사번 " + emplNo);
		int result = service.updateDiligenceAndLazinessForGoHome(emplNo);
		ResponseEntity<String> entity = null;
		if(result > 0) {
			entity = new ResponseEntity<String>("퇴근 성공", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>("퇴근 실패", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// 부서원의 출근기록을 가져오는 메소드
	@PostMapping("/getMemberPunchOut")
	public ResponseEntity<Map<String, Object>> getMemberPunchOut(@RequestBody Map<String, String> paramMap){
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> resultMap = new HashMap<>();
		
		// 뷰에서 전달받은 데이터 가져오기
		String deptCode = paramMap.get("deptCode");
		String dateStart = paramMap.get("dateStart");
		String dateEnd = paramMap.get("dateEnd");
		log.info("dateStart : " + dateStart + "dateEnd" + dateEnd);
		String emplNm = paramMap.get("emplNm");
		String emplNo = paramMap.get("emplNo");
		int currentPage = Integer.parseInt(paramMap.get("page"));
		
		// 페이지와 검색어를 위한 데이터 세팅하기
		PaginationInfoVO<DiligenceAndLazinessVO> pageVO = new PaginationInfoVO<>();
		pageVO.setCurrentPage(currentPage);
		pageVO.setDateStart(dateStart);
		pageVO.setDateEnd(dateEnd);
		int totalRecord = service.selectDalMemberCount(pageVO, deptCode, emplNm, emplNo); // 페이지와 검색어를 기준으로 총게시글 수 가져오기
		// 토탈레코드 가져왔고, 데이터 셀렉트해오기
		pageVO.setTotalRecord(totalRecord);
		List<DiligenceAndLazinessVO> dalList = service.selectMemberDiligenceAndLazinessList(pageVO, deptCode, emplNm, emplNo); // 페이지와 검색어를 기준으로 게시글 리스트 가져오기
		if(dalList.size() > 0) {
			resultMap.put("dalList", dalList);
		}
		resultMap.put("pageVO", pageVO);
		
		entity = new ResponseEntity<Map<String,Object>>(resultMap, HttpStatus.OK);
		return entity;
	}
	
	@PostMapping("/selectThisMonthData")
	public ResponseEntity<Map<String, BigDecimal>> selectThisMonthData(@RequestBody Map<String, String> paramMap){
		String emplNo = paramMap.get("emplNo");
		Map<String, BigDecimal> resultMap = service.selectThisMonthData(emplNo); // 이렇게하면 된다고했는데 안되네 null나옴
		BigDecimal result1 = resultMap.get("LATE");
		BigDecimal result2 = resultMap.get("NORMAL");
		BigDecimal result3 = resultMap.get("OVERTIMEHOUR");
		return new ResponseEntity<Map<String,BigDecimal>>(resultMap, HttpStatus.OK);
	}
}
