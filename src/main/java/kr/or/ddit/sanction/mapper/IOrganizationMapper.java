package kr.or.ddit.sanction.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.employee.vo.DepartmentVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.employee.vo.TeamVO;

@Mapper
public interface IOrganizationMapper {
	
	// 모든 부서를 조회
	public List<DepartmentVO> getAllDepartments();
	
	// 특정 부서에 속한 팀들을 조회
	public List<TeamVO> getTeamsByDept(String deptCode);
	
	// 특정 팀에 속한 사원들을 조회
	public List<EmployeeVO> getEmployeesByTeam(String teamCode);

}
