package kr.or.ddit.hr.service;

import java.util.List;

import kr.or.ddit.hr.vo.DepartmentVO;
import kr.or.ddit.hr.vo.EmployeeVO;
import kr.or.ddit.hr.vo.TeamVO;

public interface IHrService {

	List<DepartmentVO> getAllDepartments();

	List<EmployeeVO> getTeamMembers(String teamName);

	public void createDepartment(DepartmentVO department);

	public void createTeam(TeamVO team);

	public void deleteTeam(TeamVO team);

	public void deleteDepartment(DepartmentVO department);

}
