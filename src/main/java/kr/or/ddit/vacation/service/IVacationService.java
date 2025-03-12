package kr.or.ddit.vacation.service;

import java.util.List;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.sanction.vo.HistoryVO;
import kr.or.ddit.vacation.vo.YearlyVacationVO;

public interface IVacationService {

	public int getMemberTotalRecord(PaginationInfoVO<YearlyVacationVO> pageVO, String emplNm, String deptCode);

	public List<EmployeeVO> getMemberVacation(PaginationInfoVO<YearlyVacationVO> pageVO, String emplNm,
			String deptCode);

	public int getMemberVacationHistoryTotalRecord(PaginationInfoVO<HistoryVO> pageVO);

	public List<HistoryVO> getMemberVacationList(PaginationInfoVO<HistoryVO> pageVO);

}
