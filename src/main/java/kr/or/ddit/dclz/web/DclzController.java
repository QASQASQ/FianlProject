package kr.or.ddit.dclz.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/hrms/dclz")
public class DclzController {

	@GetMapping("/overtime/employee")
	public String overTimePage() {
		return "dclz/overtime-employee";
	}
	
}
