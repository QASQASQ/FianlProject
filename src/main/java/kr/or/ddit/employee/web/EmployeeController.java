package kr.or.ddit.employee.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hrms/employee")
public class EmployeeController {
	
	
	/**
	 * @Writer 김원빈
	 * @return 전체 사원 관리 페이지(by 인사관리자)
	 */
	@GetMapping("/managingEmployees")
	public String ManagingEmployees() {
		log.info("# 사원 관리 페이지 호출 성공");
		// 사원관리 페이지 '임시'
//		return "employee/managingEmployees_Temp";
		return "employee/employeeList";
	}
	
	/**
	 * @Writer 김원빈
	 * @return 사원 정보 조회 페이지
	 */
	@GetMapping("/employeeInfo")
	public String employeeInfo() {
		log.info("# 사원 정보 페이지 호출 성공");
		// 사원 정보 페이지 임시
		return "employee/employeeInfo";
	}
	
	/**
	 * @Writer: 김원빈
	 * @return 사원 정보 수정 페이지
	 */
	@GetMapping("/employeeUpdate")
	public String employeeUpdate() {
		log.info("사원 정보 수정 페이지 호출 성공");
		
		return "employee/employeeInfoUpdate";
	}
	
}
