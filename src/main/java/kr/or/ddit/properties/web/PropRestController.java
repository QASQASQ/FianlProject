package kr.or.ddit.properties.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import kr.or.ddit.attendance.vo.DiligenceAndLazinessVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.education.service.IEducationService;
import kr.or.ddit.education.vo.BookVO;
import kr.or.ddit.education.vo.EducationVO;
import kr.or.ddit.properties.service.IPropService;
import kr.or.ddit.properties.vo.PropertiesVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/hrms/prop/rest")
public class PropRestController {

	@Autowired
	private IPropService propSerivce;
	
	/* getPropAllList */
    @PostMapping("/getPropAllList")
	public ResponseEntity<Map<String, Object>> getEducationAllList(@RequestBody Map<String, String> paramMap) {
	    ResponseEntity<Map<String, Object>> entity = null;
	    Map<String, Object> resultMap = new HashMap<>();

	    String psCode = paramMap.get("psCode");
	    String propName = paramMap.get("propName");
	    int currentPage = Integer.parseInt(paramMap.get("page"));
	    log.info("psCode, propName, currentPage "  + psCode + propName + currentPage);
	    
	    PropertiesVO propVO = new PropertiesVO();
	    propVO.setPsCode(psCode);
	    propVO.setPropName(propName);
	    
	    PaginationInfoVO<PropertiesVO> pageVO = new PaginationInfoVO<>();
	    pageVO.setCurrentPage(currentPage);
	    int totalRecord = propSerivce.selectPropListCount(propVO);
	    pageVO.setTotalRecord(totalRecord);
	    List<PropertiesVO> propAllList = propSerivce.selectPropList(pageVO, propVO);

	    if (!propAllList.isEmpty()) {
	        resultMap.put("propAllList", propAllList);
	    }
	    resultMap.put("pageVO", pageVO);

	    entity = new ResponseEntity<>(resultMap, HttpStatus.OK);
	    return entity;
	}
}
