package kr.or.ddit.employee.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.cmm.vo.CommonCodeVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.vo.AuthVO;
import kr.or.ddit.employee.vo.DepartmentVO;
import kr.or.ddit.employee.vo.EmpAuthVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.employee.vo.TeamVO;

@Mapper
public interface IEmployeeMapper {

	public List<DepartmentVO> getDeptCodes();	// 부서코드 조회

	public List<TeamVO> getTeamCodes(String deptCode);	// 팀코드 조회

	public List<CommonCodeVO> getPositionCodes(String position);	// 직위코드 조회

	public List<CommonCodeVO> getBankCodes(String bankCode);	// 은행코드 조회

	public void registerEmployee(EmployeeVO evo);	// 사원 등록(기본정보 by 인사관리자)

	public List<AuthVO> getAuthList();	// 권한코드 조회

	public void registerAuth(EmpAuthVO eavo);	// 권한 등록

	public EmployeeVO getEmplInfo(EmployeeVO employeeVO);

	public int employeeUpdate(EmployeeVO evo);

	public int changePwd(EmployeeVO evo);

	public List<Map> getSomeCode(String userId);

	public int profileImgUpload(EmployeeVO evo);

	public String getBankCode(String userId);

	public int saveSignature(EmployeeVO evo);

	public List<EmpAuthVO> getEmpAuth(String userId);

	public void giveVacation(EmployeeVO employee);
}
