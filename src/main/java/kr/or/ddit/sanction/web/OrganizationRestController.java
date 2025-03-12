package kr.or.ddit.sanction.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.sanction.service.IOrganizationService;
import kr.or.ddit.sanction.vo.TreeNodeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/organization")
public class OrganizationRestController {

	@Autowired
	private IOrganizationService service;
	
	@GetMapping("/getTree")
	public List<TreeNodeVO> getOrganizationTree() {
		log.info("조직도 트리 호출 컨트롤러 실행");
		return service.getOrganizationTree();
	}
	
}
