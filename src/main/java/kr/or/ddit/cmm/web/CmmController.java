package kr.or.ddit.cmm.web;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hrms/cmm")
public class CmmController {

	@GetMapping("/login")
	public String loginPage(String error, String logout, String msg, Model model) {
		log.info("loginPage() 실행...");
		return "cmm/login/login";
	}
	
	@PostMapping("/login")
	public String login() {
		log.info("login() 실행...");
		return "cmm/login/login";
	}
	
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/index")
	public String goMain() {
		return "cmm/main/index";
	}
	
	@GetMapping("/err404")
	public String go404() {
		return "cmm/error/error404";
	}
	
	@GetMapping("/err500")
	public String go500() {
		return "cmm/error/error500";
	}
}
