package kr.or.ddit.cmm.web;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.admin.service.IAdminService;
import kr.or.ddit.calendar.vo.CalendarVO;
import kr.or.ddit.cmm.service.ICmmService;
import kr.or.ddit.employee.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/cmm")
public class CmmRestController {

	@Autowired
	ICmmService cmmService;
	
	@Autowired
	IAdminService adminService;
	
	@PostMapping("/getEmplList")
	public ResponseEntity<List<EmployeeVO>> getDatas(@RequestBody Map<String, String> paramMap){
		String deptCode = paramMap.get("deptCode");
		log.info("deptCode : " + deptCode);
		List<EmployeeVO> emplList = cmmService.getEmplList(deptCode);
		return new ResponseEntity<List<EmployeeVO>>(emplList, HttpStatus.OK);
	}
	
	@PostMapping("/getBoards")
	public ResponseEntity<Map<String, Object>> getBoards(){
		Map<String, Object> resultMap = cmmService.getBoards();
		return new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
	}
	
	@PostMapping("/getMyInfo")
	public ResponseEntity<EmployeeVO> getMyInfo(@RequestBody Map<String, String> paramMap){
		String emplNo = paramMap.get("emplNo");
		EmployeeVO emplVO = adminService.selectEmpl(emplNo);
		return new ResponseEntity<EmployeeVO>(emplVO, HttpStatus.OK);
	}
	
	@PostMapping("/getDocumentCount")
	public ResponseEntity<Map<String, String>> getDocumentCount(@RequestBody Map<String, String> paramMap){
		Map<String, String> resultMap = new HashMap<>();
		String emplNo = paramMap.get("emplNo");

		Map<String, BigDecimal> countMap = cmmService.getDocumentCount(emplNo);
		// 원결재자사번이 나 && 결재상태가 결재대기 or 결재중 => SANCTN_STATUS 가 01 또는 02 인것
		resultMap.put("doc", countMap.get("DOC").toString());
		resultMap.put("sanc", countMap.get("SANC").toString());
		return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.OK);
	}
	
	//캘린더
	@ResponseBody
	@PostMapping("/getCalendarDay")
	public List<Map<String, Object>> getCalendar(@RequestBody Map<String, String> empMap){
		
		String emplNo = empMap.get("emplNo");
		String today = empMap.get("today");
		
		List<CalendarVO> cals = cmmService.getCalendar(emplNo,today);
		log.info("사번 : " + emplNo);
		log.info("오늘날짜 : " + today);
		
		return cals.stream().map(event -> {
			Map<String, Object> map = new HashMap<>();
			map.put("id", event.getSchNo());
			map.put("title", event.getSchTitle());
			map.put("start", event.getSchSDate());
			map.put("end", event.getSchEDate());
			map.put("color", event.getSchColor());
			map.put("textColor", event.getSchTextColor());
			map.put("allDay", event.isSchAllDay());
			return map;
		}).collect(Collectors.toList());
	}
}
