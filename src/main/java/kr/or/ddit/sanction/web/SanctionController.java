package kr.or.ddit.sanction.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hrms/sanction")
public class SanctionController {
	
	@GetMapping("/sanctionExample")
	public String sanctionExample() {
		return "sanction/docSortExample";
	}
	
	@GetMapping("/sanctionPage")
	public String callSanctionPage() {
		log.info("결재 페이지가 호출 되었습니다.");
		return "sanction/sanctionPage";
	}
	
	@GetMapping("/personalDocuments")
	public String personalDocuments() {
		log.info("개인 문서함이 호출 되었습니다.");
		return "sanction/personalDoc";
	}
	
	@GetMapping("/personalDocumentsDetail")
	public String personalDocumentsDetail() {
		log.info("개인 문서 상세 페이지가 호출 되었습니다.");
		return "sanction/personalDocDetail";
	}
	
	@GetMapping("/requestedApvDocuments")
	public String RequestedApvDocuments() {
		log.info("결재 문서함이 호출 되었습니다.");
		return "sanction/reqApvDoc";
	}
	
	@GetMapping("/reqApvDocDetail")
	public String requestedApvDocumentDetail() {
		log.info("결재 문서 상세 페이지가 호출되었습니다.");
		return "sanction/reqApvDocDetail";
	}
	
	@GetMapping("/referenceDocuments")
	public String referenceDocuments() {
		log.info("참조 문서함이 호출 되었습니다.");
		return "sanction/referenceDoc";
	}
	
}
