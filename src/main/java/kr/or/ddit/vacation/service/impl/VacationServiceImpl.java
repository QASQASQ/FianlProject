package kr.or.ddit.vacation.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.sanction.vo.HistoryVO;
import kr.or.ddit.vacation.mapper.IVacationMapper;
import kr.or.ddit.vacation.service.IVacationService;
import kr.or.ddit.vacation.vo.YearlyVacationVO;

@Service
public class VacationServiceImpl implements IVacationService{

	@Autowired
	IVacationMapper vacationMapper;

	@Override
	public int getMemberTotalRecord(PaginationInfoVO<YearlyVacationVO> pageVO, String emplNm, String deptCode) {
		return vacationMapper.getMemberTotalRecord(pageVO, emplNm, deptCode);
	}

	@Override
	public List<EmployeeVO> getMemberVacation(PaginationInfoVO<YearlyVacationVO> pageVO, String emplNm,
			String deptCode) {
		return vacationMapper.getMemberVacation(pageVO, emplNm, deptCode);
	}

	@Override
	public int getMemberVacationHistoryTotalRecord(PaginationInfoVO<HistoryVO> pageVO) {
		return vacationMapper.getMemberVacationHistoryTotalRecord(pageVO);
	}

	@Override
	public List<HistoryVO> getMemberVacationList(PaginationInfoVO<HistoryVO> pageVO) {
		return vacationMapper.getMemberVacationList(pageVO);
	}

}
