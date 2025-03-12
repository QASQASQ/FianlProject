package kr.or.ddit.attendance.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import kr.or.ddit.attendance.vo.DiligenceAndLazinessVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;

public interface IAttendanceService {
	public int insertDiligenceAndLaziness(String emplNo); // 출근하기 메소드
	public List<DiligenceAndLazinessVO> selectDiligenceAndLazinessList(PaginationInfoVO<DiligenceAndLazinessVO> paginVO); // 나의 출근기록을 가져오는 메소드
	public int updateDiligenceAndLazinessForGoHome(String emplNo); // 퇴근하기 메소드
	public int selectDalCount(PaginationInfoVO<DiligenceAndLazinessVO> pageVO); // 총 게시글수 가져오기
	public int selectDalMemberCount(PaginationInfoVO<DiligenceAndLazinessVO> pageVO, String deptCode, String emplNm, String emplNo); // 부서원 출퇴근 기록 개수 가져오기
	public List<DiligenceAndLazinessVO> selectMemberDiligenceAndLazinessList(PaginationInfoVO<DiligenceAndLazinessVO> pageVO, String deptCode, String emplNm, String emplNo); // 부서원 출퇴근 기록 가져오기
	public DiligenceAndLazinessVO selectLastDal(String emplNo); // 마지막 출퇴근 기록 가져오기
	public Map<String, BigDecimal> selectThisMonthData(String emplNo); // 이번달 데이터 가져오기

}
