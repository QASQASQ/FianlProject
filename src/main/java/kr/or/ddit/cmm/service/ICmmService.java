package kr.or.ddit.cmm.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import kr.or.ddit.calendar.vo.CalendarVO;
import kr.or.ddit.employee.vo.EmployeeVO;

public interface ICmmService {

	public List<EmployeeVO> getEmplList(String deptCode);

	public Map<String, Object> getBoards();

	public Map<String, BigDecimal> getDocumentCount(String emplNo);

	//캘린더 일정 가져오기
	public List<CalendarVO> getCalendar(String emplNo,String today);

}
