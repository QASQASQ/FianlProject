package kr.or.ddit.calendar.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.calendar.vo.CalendarVO;




@Mapper
public interface ICalendarMapper {

	public List<CalendarVO> findAll();

	public void insert(CalendarVO cal);

	public void delete(int schNo);

	public int update(CalendarVO cal);

	public CalendarVO selectSchNo(int schNo);

	public List<CalendarVO> selectAll(CalendarVO calVO);

	public List<CalendarVO> selectPersonal(String emplNo);

	public List<CalendarVO> selectDepartment(String groupId);


	
}
