package kr.or.ddit.promotion.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.promotion.service.IPromService;
import kr.or.ddit.promotion.vo.EvaluationVO;
import lombok.experimental.PackagePrivate;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("hrms/prom")
public class PromotionController {
	
	@Autowired
	private IPromService promService;

	@GetMapping("/promotion")
	public String promotion() {
		return "/promotion/promotion";
	}
	
	//사원목록
	@PostMapping("/getEmplList")
	public ResponseEntity<Map<String, Object>> getEmplList(@RequestBody Map<String, String> paramMap) {
		String page = paramMap.get("page");
		int currentPage = Integer.parseInt(page);
		String emplNo = null;
		String emplNm = null;
		String deptCode= null;
		String position = null;
		String sorting = null;
		
		PaginationInfoVO<EvaluationVO> pageVO = new PaginationInfoVO<>();
		
		if(paramMap.get("emplNo") != null && paramMap.get("emplNo") != "") emplNo = paramMap.get("emplNo");
		if(paramMap.get("emplNm") != null && paramMap.get("emplNm") != "") emplNm = paramMap.get("emplNm");
		if(paramMap.get("deptCode") != null && paramMap.get("deptCode") != "") deptCode = paramMap.get("deptCode");
		if(paramMap.get("position") != null && paramMap.get("position") != "") position = paramMap.get("position");
		if(paramMap.get("sorting") != null && paramMap.get("sorting") != "") sorting = paramMap.get("sorting");
		log.info("sortingsortingsortingsorting : " + sorting);
		int totalRecord = promService.getTotalRecord(emplNo, emplNm, deptCode, position);
		
		
		pageVO.setCurrentPage(currentPage);
		pageVO.setTotalRecord(totalRecord);
		
		List<EvaluationVO> evaluList = promService.getEvaluList(pageVO, emplNo, emplNm, deptCode, position, sorting);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("pageVO", pageVO);
		resultMap.put("evaluList", evaluList);
		
		return new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
	}
	
	//승진대상자 추가
	@PostMapping("/promoteTarget")
	public ResponseEntity<String> promoteTarget(@RequestBody Map<String, String> paramMap){
		ResponseEntity<String> entity = null;
		String emplNo = paramMap.get("emplNo");
		int result = promService.promoteTarget(emplNo);
		log.info("zzzzzzzzz:" + emplNo);
		if(result > 0) {
			entity = new ResponseEntity<String>("성공", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>("실패", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@PostMapping("/getPromList")
	public ResponseEntity<List<EvaluationVO>> getPromList(){
		List<EvaluationVO> evaluationList = promService.getPromList();
		return new ResponseEntity<List<EvaluationVO>>(evaluationList, HttpStatus.OK);
	} 
	
	//승진
	@PostMapping("/promEmpl")
	public ResponseEntity<String> promEmpl(@RequestBody Map<String, String> paramMap){
		ResponseEntity<String> entity = null;
		String emplNo = paramMap.get("emplNo");
		int result = promService.promEmpl(emplNo);
		if(result > 0) {
			entity = new ResponseEntity<String>("성공", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>("실패", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//심사종료
	@PostMapping("/promCancel")
	public ResponseEntity<String> receiveArray(@RequestBody List<String> emplList) {
		int result = promService.promCancel(emplList);
		if(result == emplList.size()) {
			return new ResponseEntity<String>("성공", HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("실패", HttpStatus.BAD_REQUEST);
		}
	}
	
	//검색 
	 @PostMapping("/getSelect")
	 public ResponseEntity<Map<String, Object>> getSelect() {
		Map<String, Object> selectMap = promService.getSelect();
		return new ResponseEntity<Map<String,Object>>(selectMap, HttpStatus.OK);
	}
}
