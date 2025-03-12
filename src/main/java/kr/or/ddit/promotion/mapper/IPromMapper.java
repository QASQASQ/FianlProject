package kr.or.ddit.promotion.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.cmm.vo.CommonCodeVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.vo.DepartmentVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.promotion.vo.EvaluationVO;

@Mapper
public interface IPromMapper {

	public List<EmployeeVO> emplList();

	public int getTotalRecord(
			@Param("emplNo") String emplNo,
			@Param("emplNm") String emplNm,
			@Param("deptCode") String deptCode,
			@Param("emplPosition") String position);

	public List<EvaluationVO> getEvaluList(
			@Param("pageVO") PaginationInfoVO<EvaluationVO> pageVO, 
			@Param("emplNo") String emplNo, 
			@Param("emplNm") String emplNm, 
			@Param("deptCode") String deptCode, 
			@Param("position") String position,
			@Param("sorting") String sorting
			);

	public int promoteTarget(String emplNo);

	public List<EvaluationVO> getPromList();

	public int promEmpl(String emplNo);

	public int promCancel(String empl);

	public int getSelect();

	public List<DepartmentVO> getDept();

	public List<CommonCodeVO> getPosition();

}
