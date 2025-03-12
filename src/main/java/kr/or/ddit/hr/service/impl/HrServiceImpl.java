package kr.or.ddit.hr.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.hr.mapper.IHrMapper;
import kr.or.ddit.hr.service.IHrService;
import kr.or.ddit.hr.vo.DepartmentVO;
import kr.or.ddit.hr.vo.EmployeeVO;
import kr.or.ddit.hr.vo.TeamVO;

@Service
public class HrServiceImpl implements IHrService {

	@Autowired
	private IHrMapper hrMapper;

	@Override
	public List<DepartmentVO> getAllDepartments() {
		return hrMapper.getAllDepartments();
	}

	@Override
	public List<EmployeeVO> getTeamMembers(String teamName) {
		return hrMapper.getTeamMembers(teamName);
	}

	@Override
	public void createDepartment(DepartmentVO department) {
		hrMapper.insertDepartment(department);
	}

	@Override
	public void createTeam(TeamVO team) {
		hrMapper.insertTeam(team);
	}

	@Override
	public void deleteTeam(TeamVO team) {
		hrMapper.deleteTeam(team);
		
	}

	@Override
	public void deleteDepartment(DepartmentVO department) {
		hrMapper.deleteDepartment(department);
		
	}
}
