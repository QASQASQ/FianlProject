package kr.or.ddit.attendance.mapper;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.attendance.vo.DiligenceAndLazinessVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;

@Mapper
public interface IAttendanceMapper {
	public int insertDiligenceAndLaziness(String emplNo);
	public List<DiligenceAndLazinessVO> selectDiligenceAndLazinessList(PaginationInfoVO<DiligenceAndLazinessVO> paginVO);
	public int updateDiligenceAndLazinessForGoHome(String emplNo);
	public int selectDalCount(PaginationInfoVO<DiligenceAndLazinessVO> pageVO);
	public int selectDalMemberCount(@Param("pageVO") PaginationInfoVO<DiligenceAndLazinessVO> pageVO, @Param("deptCode") String deptCode, @Param("emplNm") String emplNm, @Param("emplNo") String emplNo);
	public List<DiligenceAndLazinessVO> selectMemberDiligenceAndLazinessList(@Param("pageVO") PaginationInfoVO<DiligenceAndLazinessVO> pageVO, @Param("deptCode") String deptCode, @Param("emplNm") String emplNm, @Param("emplNo") String emplNo);
	public DiligenceAndLazinessVO selectLastDal(String emplNo);
	public List<DiligenceAndLazinessVO> selectMemberDclz();
	public void insertAbsent(String emplNo);
	public Map<String, BigDecimal> selectThisMonthData(String emplNo);
}
