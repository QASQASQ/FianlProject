package kr.or.ddit.vacation.web;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hrms/vacation")
public class VacationController {

	@PreAuthorize("hasAnyAuthority('ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/authorityPage")
	public String vacationAuthorityPage() {
		return "vacation/vacation-authority";
	}
	
	@PreAuthorize("hasAnyAuthority('ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/authorityDetailPage")
	public String vacationAuthorityDetailPage() {
		return "vacation/vacation-authority-detail";
	}
	
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/page")
	public String page() {
		return "vacation/vacation-employee";
	}
	
	
}
