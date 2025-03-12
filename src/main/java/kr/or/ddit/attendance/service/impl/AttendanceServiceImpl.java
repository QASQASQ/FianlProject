package kr.or.ddit.attendance.service.impl;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import kr.or.ddit.attendance.mapper.IAttendanceMapper;
import kr.or.ddit.attendance.service.IAttendanceService;
import kr.or.ddit.attendance.vo.DiligenceAndLazinessVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;

@Service
public class AttendanceServiceImpl implements IAttendanceService{

	@Autowired
	IAttendanceMapper mapper;
	
	@Override
	public int insertDiligenceAndLaziness(String emplNo) {
		int result = mapper.insertDiligenceAndLaziness(emplNo);
		return result;
	}

	@Override
	public List<DiligenceAndLazinessVO> selectDiligenceAndLazinessList(PaginationInfoVO<DiligenceAndLazinessVO> paginVO) {
		return mapper.selectDiligenceAndLazinessList(paginVO);
	}

	@Override
	public int updateDiligenceAndLazinessForGoHome(String emplNo) {
		return mapper.updateDiligenceAndLazinessForGoHome(emplNo);
	}

	@Override
	public int selectDalCount(PaginationInfoVO<DiligenceAndLazinessVO> pageVO) {
		return mapper.selectDalCount(pageVO);
	}

	@Override
	public int selectDalMemberCount(PaginationInfoVO<DiligenceAndLazinessVO> pageVO, String deptCode, String emplNm, String emplNo) {
		return mapper.selectDalMemberCount(pageVO, deptCode, emplNm, emplNo);
	}

	@Override
	public List<DiligenceAndLazinessVO> selectMemberDiligenceAndLazinessList(PaginationInfoVO<DiligenceAndLazinessVO> pageVO, String deptCode, String emplNm, String emplNo) {
		return mapper.selectMemberDiligenceAndLazinessList(pageVO, deptCode, emplNm, emplNo);
	}

	@Override
	public DiligenceAndLazinessVO selectLastDal(String emplNo) {
		return mapper.selectLastDal(emplNo);
	}
	
	//@Scheduled(cron = "1 43 17 * * *")
	public void absent() {
		String today = LocalDate.now().toString()+1;
		List<DiligenceAndLazinessVO> dalList = mapper.selectMemberDclz();
		for (DiligenceAndLazinessVO diligenceAndLazinessVO : dalList) {
			System.out.println("시간으로보기 : " + diligenceAndLazinessVO.toString());
			String dclzDate = diligenceAndLazinessVO.getDclzDate().substring(0, 10);
			System.out.println("today : " + today);
			System.out.println("dclzDate : " + dclzDate);
			if(today.equals(dclzDate)) {
				System.out.println("똑같으니까 패스");
			}else {
				mapper.insertAbsent(diligenceAndLazinessVO.getEmplNo());
			}
		}
	}

	@Override
	public Map<String, BigDecimal> selectThisMonthData(String emplNo) {
		return mapper.selectThisMonthData(emplNo);
	}



}
