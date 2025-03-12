package kr.or.ddit.employee.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.cmm.vo.CommonCodeVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.vo.AuthVO;
import kr.or.ddit.employee.vo.DepartmentVO;
import kr.or.ddit.employee.vo.EmpAuthVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.employee.vo.TeamVO;

public interface IEmployeeService {

	public List<DepartmentVO> getDeptCodes();

	public List<TeamVO> getTeamCodes(String deptCode);

	public List<CommonCodeVO> getPositionCodes(String position);

	public List<CommonCodeVO> getBankCodes(String bankCode);

	public void registerEmployee(EmployeeVO evo);

	public List<AuthVO> getAuthList();

	public void bulkRegisterEmployee(List<EmployeeVO> excel);

	public EmployeeVO getEmplInfo(EmployeeVO employeeVO);

	public int employeeUpdate(EmployeeVO evo);

	public int changePwd(EmployeeVO evo);

	public List<Map> getSomeCode(String userId);

	public String saveProfileImg(String emplNo, MultipartFile file);

	public String getBankCode(String userId);

	public int saveSignature(Map<String, String> payload);

	public List<EmpAuthVO> getEmpAuth(String userId);

}
