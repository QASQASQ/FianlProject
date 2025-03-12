package kr.or.ddit.admin.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.admin.service.IAdminService;
import kr.or.ddit.employee.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hrms/admin")
public class AdminController {
	
	@Autowired
	IAdminService adminService;
	
	@GetMapping("/employeeList")
	public String employeeList() {
		log.info("employeeList 실행");
		return "admin/employeeList";
	}
	
	@GetMapping("/employeeDetail")
	public String employeeDetail() {
		log.info("employeeDetail 실행");
		return "admin/employeeDetail";
	}
	
	@GetMapping("/employeeDetail/{emplNo}")
	public String employeeDetail(@PathVariable("emplNo") String emplNo, Model model) {
		EmployeeVO emplVO = adminService.selectEmpl(emplNo);
		model.addAttribute("emplVO", emplVO);
		return "admin/employeeDetail";
	}
	
	@GetMapping("/adminAttendance")
	public String adminAttendance() {
		return "admin/adminAttendance";
	}
	
	@GetMapping("/analytics")
	public String analytics() {
		return "admin/analytics";
	}
	
}
