package kr.or.ddit.admin.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.attendance.vo.DiligenceAndLazinessVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.vo.EmployeeVO;

@Mapper
public interface IAdminMapper {

	public EmployeeVO selectEmpl(String emplNo);
	
	public int selectEmplTotalRecord(EmployeeVO emplVO);

	public List<EmployeeVO> selectEmployeeList(@Param("pageVO") PaginationInfoVO<EmployeeVO> pageVO, @Param("emplVO") EmployeeVO emplVO);

	public int updateDal(DiligenceAndLazinessVO dalVO);

	public int insertAttendance(DiligenceAndLazinessVO dalVO);

}
