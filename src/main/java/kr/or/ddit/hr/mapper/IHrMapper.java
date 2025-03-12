package kr.or.ddit.hr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.hr.vo.DepartmentVO;
import kr.or.ddit.hr.vo.EmployeeVO;
import kr.or.ddit.hr.vo.TeamVO;

@Mapper
public interface IHrMapper {

	List<DepartmentVO> getAllDepartments();

	List<EmployeeVO> getTeamMembers(String teamName);

	public void insertDepartment(DepartmentVO department);

	public void insertTeam(TeamVO team);

	public void deleteTeam(TeamVO team);

	public void deleteDepartment(DepartmentVO department);

}
