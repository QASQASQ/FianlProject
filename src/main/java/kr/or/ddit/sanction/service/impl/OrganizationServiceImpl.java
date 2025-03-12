package kr.or.ddit.sanction.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.employee.vo.DepartmentVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.employee.vo.TeamVO;
import kr.or.ddit.sanction.mapper.IOrganizationMapper;
import kr.or.ddit.sanction.service.IOrganizationService;
import kr.or.ddit.sanction.vo.TreeNodeVO;

@Service
public class OrganizationServiceImpl implements IOrganizationService {
	
	@Autowired
	private IOrganizationMapper mapper;

	@Override
	public List<TreeNodeVO> getOrganizationTree() {
		
		List<TreeNodeVO> tree = new ArrayList<>();
		
		// 1. 모든 부서 조회
		List<DepartmentVO> deptList = mapper.getAllDepartments();
		
		for(DepartmentVO dept : deptList) {
			TreeNodeVO deptNode = new TreeNodeVO();
			
			deptNode.setId("dept_" + dept.getDeptCode());
			deptNode.setText(dept.getDeptName());
			
			// 2. 부서 별 팀 조회
			List<TeamVO> teamList = mapper.getTeamsByDept(dept.getDeptCode());
			List<TreeNodeVO> teamNodes = new ArrayList<>();
			
			for(TeamVO team : teamList) {
				TreeNodeVO teamNode = new TreeNodeVO();
				teamNode.setId("team_" + team.getTeamCode());
				teamNode.setText(team.getTeamName());
				
				// 3. 팀 별 사원 조회
				List<EmployeeVO> empList = mapper.getEmployeesByTeam(team.getTeamCode());
				List<TreeNodeVO> empNodes = new ArrayList<>();
				
				for(EmployeeVO emp : empList) {
					TreeNodeVO empNode = new TreeNodeVO();
					empNode.setId("emp_" + emp.getEmplNo());
					if(emp.getEmplPosition().equals("01")) {
						emp.setEmplPosition("사원");
					}
					if(emp.getEmplPosition().equals("02")) {
						emp.setEmplPosition("대리");
					}
					if(emp.getEmplPosition().equals("03")) {
						emp.setEmplPosition("과장");
					}
					if(emp.getEmplPosition().equals("04")) {
						emp.setEmplPosition("차장");
					}
					if(emp.getEmplPosition().equals("05")) {
						emp.setEmplPosition("부장");
					}
					empNode.setText("(" + emp.getEmplPosition() + ") " + emp.getEmplNm());
					empNode.setData(emp.getEmplNo());
					empNodes.add(empNode);
				}
				teamNode.setChildren(empNodes);
				teamNodes.add(teamNode);
			}
			deptNode.setChildren(teamNodes);
			tree.add(deptNode);
		}
		
		return tree;
	}

}
