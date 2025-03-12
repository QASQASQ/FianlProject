package kr.or.ddit.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.admin.mapper.IAdminMapper;
import kr.or.ddit.admin.mapper.IChartMapper;
import kr.or.ddit.admin.service.IAdminService;
import kr.or.ddit.attendance.vo.DiligenceAndLazinessVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminServiceImpl implements IAdminService{
	
	@Autowired
	IAdminMapper adminMapper;
	
	@Autowired
	IChartMapper chartMapper;
	
	@Override
	public EmployeeVO selectEmpl(String emplNo) {
		return adminMapper.selectEmpl(emplNo);
	}
	
	@Override
	public int selectEmplTotalRecord(EmployeeVO emplVO) {
		return adminMapper.selectEmplTotalRecord(emplVO);
	}

	@Override
	public List<EmployeeVO> selectEmployeeList(PaginationInfoVO<EmployeeVO> pageVO, EmployeeVO emplVO) {
		return adminMapper.selectEmployeeList(pageVO, emplVO);
	}

	@Override
	public int updateDal(DiligenceAndLazinessVO dalVO) {
		return adminMapper.updateDal(dalVO);
	}

	@Override
	public int insertAttendance(DiligenceAndLazinessVO dalVO) {
		return adminMapper.insertAttendance(dalVO);
	}

	@Override
	public Map<String, Map<String, Object>> getChartData() {
		Map<String, Map<String, Object>> resultMap = new HashMap<>();
		Map<String, Object> lateMap = chartMapper.getLateData(); // 월별 지각한사람 수
		Map<String, Object> emplCount = chartMapper.getEmplCountData(); // 부서별 인원 통계
		Map<String, Object> deptSal = chartMapper.getDeptSalary(); // 부서별 평균기본급여
		Map<String, Object> recruitCount = chartMapper.getRecruitCount();
		Map<String, Object> appCount = chartMapper.getAppCount();
		Map<String, Object> vacationData = chartMapper.getVacationData();
		Map<String, Object> yearsOfService = chartMapper.getYearsOfService();
		Map<String, Object> vacation = chartMapper.getVaction();
		
		
		resultMap.put("lateMap", lateMap);
		resultMap.put("emplCount", emplCount);
		resultMap.put("deptSal", deptSal);
		resultMap.put("recruitCount", recruitCount);
		resultMap.put("appCount", appCount);
		resultMap.put("vacationData", vacationData);
		resultMap.put("yearsOfService", yearsOfService);
		resultMap.put("vacation", vacation);
		return resultMap;
	}

}
