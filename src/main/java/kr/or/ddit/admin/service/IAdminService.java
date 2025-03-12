package kr.or.ddit.admin.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.attendance.vo.DiligenceAndLazinessVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.vo.EmployeeVO;

public interface IAdminService {

	public EmployeeVO selectEmpl(String emplNo); // 사원정보 가져오기
	
	public int selectEmplTotalRecord(EmployeeVO emplVO); // 전체사원수 가져오기

	public List<EmployeeVO> selectEmployeeList(PaginationInfoVO<EmployeeVO> pageVO, EmployeeVO emplVO); // 전체사원 가져오기

	public int updateDal(DiligenceAndLazinessVO dalVO); // 출퇴근 기록 수정하기

	public int insertAttendance(DiligenceAndLazinessVO dalVO); // 출퇴근 기록 추가하기

	public Map<String, Map<String, Object>> getChartData(); // 차트데이터 일괄 가져오기

}
