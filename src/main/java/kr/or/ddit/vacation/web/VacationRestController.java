package kr.or.ddit.vacation.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.sanction.vo.HistoryVO;
import kr.or.ddit.vacation.service.IVacationService;
import kr.or.ddit.vacation.vo.YearlyVacationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/vacation")
public class VacationRestController {

	@Autowired
	IVacationService vacationService;
	
	@PostMapping("/getMyVacation")
	public ResponseEntity<Map<String, Object>> getMemberVacation(@RequestBody PaginationInfoVO<HistoryVO> pageVO){
		int totalRecord = vacationService.getMemberVacationHistoryTotalRecord(pageVO);
		pageVO.setTotalRecord(totalRecord);
		List<HistoryVO> vacationList = vacationService.getMemberVacationList(pageVO);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("vacationList", vacationList);
		resultMap.put("pageVO", pageVO);
		return new ResponseEntity<Map<String,Object>>(resultMap, HttpStatus.OK);
	}
	
	// 부서원의 출근기록을 가져오는 메소드
	@PostMapping("/getMemberVacation")
	public ResponseEntity<Map<String, Object>> getMemberVacation(@RequestBody Map<String, String> paramMap){
		Map<String, Object> resultMap = new HashMap<>();
		
		String page = paramMap.get("currentPage");
		String dateStart = paramMap.get("dateStart");
		String dateEnd = paramMap.get("dateEnd");
		String emplNm = paramMap.get("emplNm");
		String emplNo = paramMap.get("emplNo");
		String deptCode = paramMap.get("deptCode");
		PaginationInfoVO<YearlyVacationVO> pageVO = new PaginationInfoVO<>();
		pageVO.setCurrentPage(Integer.parseInt(page));
		pageVO.setDateStart(dateStart);
		pageVO.setDateEnd(dateEnd);
		pageVO.setEmplNo(emplNo);
		
		int totalRecord = vacationService.getMemberTotalRecord(pageVO, emplNm, deptCode);
		pageVO.setTotalRecord(totalRecord);
		List<EmployeeVO> emplList = vacationService.getMemberVacation(pageVO, emplNm, deptCode);
		resultMap.put("emplList", emplList);
		resultMap.put("pageVO", pageVO);
		
		return new ResponseEntity<Map<String,Object>>(resultMap, HttpStatus.OK);
	}
	
	@PostMapping("/getMemberVacationHistory")
	public ResponseEntity<Map<String, Object>> getMemberVacationHistory(@RequestBody PaginationInfoVO<HistoryVO> pageVO){
		int totalRecord = vacationService.getMemberVacationHistoryTotalRecord(pageVO);
		pageVO.setTotalRecord(totalRecord);
		List<HistoryVO> historyList = vacationService.getMemberVacationList(pageVO);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("historyList", historyList);
		resultMap.put("pageVO", pageVO);
		return new ResponseEntity<Map<String,Object>>(resultMap, HttpStatus.OK);
	}
}
