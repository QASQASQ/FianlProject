package kr.or.ddit.dclz.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.dclz.service.IDclzService;
import kr.or.ddit.sanction.vo.HistoryVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/dclz")
public class DclzRestController {

	@Autowired
	IDclzService dclzService;
	
	@PostMapping("/getOvertimeList")
	public ResponseEntity<Map<String, Object>> getOvertimeList(@RequestBody PaginationInfoVO<HistoryVO> pageVO){
		Map<String, Object> resultMap = new HashMap<>();
		int totalRecord = dclzService.getOverTimeTotalRecord(pageVO);
		pageVO.setTotalRecord(totalRecord);
		List<HistoryVO> historyList = dclzService.getOvertimeList(pageVO);
		
		resultMap.put("historyList", historyList);
		resultMap.put("pageVO", pageVO);
		return new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
	}

}
