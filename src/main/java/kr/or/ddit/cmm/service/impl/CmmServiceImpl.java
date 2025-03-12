package kr.or.ddit.cmm.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.board.board.vo.BoardVO;
import kr.or.ddit.board.notice.vo.NoticeVO;
import kr.or.ddit.calendar.vo.CalendarVO;
import kr.or.ddit.cmm.mapper.ICmmMapper;
import kr.or.ddit.cmm.service.ICmmService;
import kr.or.ddit.employee.vo.EmployeeVO;

@Service
public class CmmServiceImpl implements ICmmService{

	@Autowired
	ICmmMapper cmmMapper;
	
	@Override
	public List<EmployeeVO> getEmplList(String deptCode) {
		
		return cmmMapper.getEmplList(deptCode);
	}

	@Override
	public Map<String, Object> getBoards() {
		Map<String, Object> resultMap = new HashMap<>();
		List<BoardVO> noticeList = cmmMapper.getNotice();
		List<BoardVO> boardList = cmmMapper.getBoard();
		
		resultMap.put("noticeList", noticeList);
		resultMap.put("boardList", boardList);
		
		return resultMap;
	}

	@Override
	public Map<String, BigDecimal> getDocumentCount(String emplNo) {
		return cmmMapper.getDocumentCount(emplNo);
	}

	//캘린더 일정 가져오기
	@Override
	public List<CalendarVO> getCalendar(String emplNo, String today) {
		return cmmMapper.getCalendar(emplNo,today);
	}

}
