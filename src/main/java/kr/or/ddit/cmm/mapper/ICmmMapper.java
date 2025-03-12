package kr.or.ddit.cmm.mapper;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.board.vo.BoardVO;
import kr.or.ddit.board.notice.vo.NoticeVO;
import kr.or.ddit.calendar.vo.CalendarVO;
import kr.or.ddit.employee.vo.EmployeeVO;

@Mapper
public interface ICmmMapper {

	public List<EmployeeVO> getEmplList(String deptCode);

	public List<BoardVO> getNotice();

	public List<BoardVO> getBoard();

	public Map<String, BigDecimal> getDocumentCount(String emplNo);

	public List<CalendarVO> getCalendar(String emplNo, String today);

}
