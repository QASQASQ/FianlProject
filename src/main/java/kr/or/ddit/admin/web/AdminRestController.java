package kr.or.ddit.admin.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.admin.service.IAdminService;
import kr.or.ddit.attendance.service.IAttendanceService;
import kr.or.ddit.attendance.vo.DiligenceAndLazinessVO;
import kr.or.ddit.cmm.vo.CommonCodeVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.service.IEmployeeService;
import kr.or.ddit.employee.vo.DepartmentVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/hrms/admin")
public class AdminRestController {
	
	@Autowired
	IAdminService adminService;
	
	@Autowired
	IEmployeeService employeeService;
	
	@Autowired
	IAttendanceService attendanceService;
	
	@PostMapping("/selectEmplList")
	public ResponseEntity<Map<String, Object>> getEmplList(@RequestBody Map<String, String> paramMap){
		// 뷰에서 전달한 데이터 가져오기
		int currentPage = Integer.parseInt(paramMap.get("page"));
		String emplNo = paramMap.get("emplNo");
		String emplNm = paramMap.get("emplNm");
		String emplPosition = paramMap.get("emplPosition");
		String deptCode = paramMap.get("deptCode");
		
		// 전달받은 데이터 객체에 세팅
		EmployeeVO emplVO = new EmployeeVO();
		if(emplNo != null && emplNo != "")emplVO.setEmplNo(emplNo);
		if(emplNm != null && emplNm != "")emplVO.setEmplNm(emplNm);
		if(emplPosition != null && emplPosition != "")emplVO.setEmplPosition(emplPosition);
		if(deptCode != null && deptCode != "")emplVO.setDeptCode(deptCode);
		
		// 총 게시글수 구하고 결과값 페이지vo에 세팅하기
		int totalRecord = adminService.selectEmplTotalRecord(emplVO);
		PaginationInfoVO<EmployeeVO> pageVO = new PaginationInfoVO<>(10, 5);
		pageVO.setCurrentPage(currentPage);
		pageVO.setTotalRecord(totalRecord);
		
		// 전체사원목록 가져오기
		List<EmployeeVO> emplList = adminService.selectEmployeeList(pageVO, emplVO);
		Map<String, Object> resultMap = new HashMap<>();
		
		// 결과값 맵에 저장해서 뷰로 전달하기
		resultMap.put("emplList", emplList);
		resultMap.put("pageVO", pageVO);
		return new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
	}
	
	@PostMapping("/getSelectBoxList")
	public ResponseEntity<Map<String, Object>> getSelectBoxList(){
		// 서비스에서 형이만든거 호출해서 결과가져오기
		List<CommonCodeVO> ccvo = employeeService.getPositionCodes("POSITION");
		List<DepartmentVO> dvo = employeeService.getDeptCodes();
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("emplPosition", ccvo);
		resultMap.put("deptCode", dvo);
		return new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
	}
	
	@PostMapping("/adminAttendance")
	public ResponseEntity<Map<String, Object>> adminAttendance(@RequestBody Map<String, String> paramMap){
		Map<String, Object> resultMap = new HashMap<>();
		PaginationInfoVO<DiligenceAndLazinessVO> pageVO = new PaginationInfoVO<>(10, 5);
		int currentPage = Integer.parseInt(paramMap.get("page"));
		if(paramMap.get("dateStart") != null) pageVO.setDateStart(paramMap.get("dateStart"));
		if(paramMap.get("dateEnd") != null) pageVO.setDateEnd(paramMap.get("dateEnd"));
		pageVO.setCurrentPage(currentPage);
		pageVO.setEmplNo(paramMap.get("emplNo"));
		int totalRecord = attendanceService.selectDalCount(pageVO);
		pageVO.setTotalRecord(totalRecord);
		List<DiligenceAndLazinessVO> dalList = attendanceService.selectDiligenceAndLazinessList(pageVO);
		resultMap.put("dalList", dalList);
		resultMap.put("pageVO", pageVO);
		return new ResponseEntity<Map<String,Object>>(resultMap, HttpStatus.OK);
	}
	
	@PostMapping("/updateAttendance")
	public int updateAttendance(@RequestBody Map<String, String> paramMap){
		String dclzStime = paramMap.get("dclzStime");
		String dclzEtime = paramMap.get("dclzEtime");
		String dclzNo = paramMap.get("dclzNo");
		log.info("dclzNo : " + dclzNo + dclzStime + dclzEtime);
		DiligenceAndLazinessVO dalVO = new DiligenceAndLazinessVO();
		dalVO.setDclzNo(dclzNo);
		dalVO.setDclzStime(dclzStime);
		dalVO.setDclzEtime(dclzEtime);
		int result = adminService.updateDal(dalVO);
		return result;
	}
	
	@PostMapping("/insertAttendance")
	public String insertAttendance(@RequestBody Map<String, String> paramMap) {
		DiligenceAndLazinessVO dalVO = new DiligenceAndLazinessVO();
		
		String emplNo = paramMap.get("emplNo");
		String dclzDate = paramMap.get("dclzDate");
		String dclzStime = paramMap.get("dclzStime");
		String dclzEtime = null;
		
		dalVO.setEmplNo(emplNo);
		dalVO.setDclzDate(dclzDate);
		dalVO.setDclzStime(dclzStime);
		dalVO.setDclzType("01");
		if(paramMap.get("dclzEtime") != null) {
			dclzEtime = paramMap.get("dclzEtime");
			dalVO.setDclzEtime(dclzEtime);
			dalVO.setDclzType("02");
		}
		int result = adminService.insertAttendance(dalVO);
		
		return null;
	}

	// 통계 데이터 가져오기
	@PostMapping("/getChartsData")
	public ResponseEntity<Map<String, Map<String, Object>>> getChartsData(){
		Map<String, Map<String, Object>> resultMap = adminService.getChartData();
		
		return new ResponseEntity<Map<String,Map<String,Object>>>(resultMap, HttpStatus.OK);
	}
}
