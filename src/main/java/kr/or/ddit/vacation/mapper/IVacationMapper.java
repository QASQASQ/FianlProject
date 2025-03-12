package kr.or.ddit.vacation.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.sanction.vo.HistoryVO;
import kr.or.ddit.vacation.vo.YearlyVacationVO;

@Mapper
public interface IVacationMapper {

	public int getMemberTotalRecord(@Param("pageVO") PaginationInfoVO<YearlyVacationVO> pageVO, @Param("emplNm") String emplNm, @Param("deptCode") String deptCode);

	public List<EmployeeVO> getMemberVacation(@Param("pageVO") PaginationInfoVO<YearlyVacationVO> pageVO, @Param("emplNm") String emplNm, @Param("deptCode") String deptCode);

	public int getMemberVacationHistoryTotalRecord(PaginationInfoVO<HistoryVO> pageVO);

	public List<HistoryVO> getMemberVacationList(PaginationInfoVO<HistoryVO> pageVO);

}
