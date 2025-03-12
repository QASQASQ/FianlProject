package kr.or.ddit.attendance.web;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hrms/attendance")
public class AttendaceController {

	// 페이지 이동
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/page")
	public String attendancePage() {
		return "attendance/attendance-employee";
	}

	// 부서원의 출근기록을 조회하는 페이지
	@PreAuthorize("hasAnyAuthority('ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/authorityPage")
	public String attendanceAuthorityPage() {
		return "attendance/attendance-authority";
	}
}
