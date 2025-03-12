package kr.or.ddit.promotion.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.promotion.vo.EvaluationVO;

public interface IPromService {

	public List<EmployeeVO> emplList();

	public int getTotalRecord(String emplNo, String emplNm, String deptCode, String position);

	public List<EvaluationVO> getEvaluList(PaginationInfoVO<EvaluationVO> pageVO, String emplNo,
			String emplNm, String deptCode, String position, String sorting);

	public int promoteTarget(String emplNo);

	public List<EvaluationVO> getPromList();

	public int promEmpl(String emplNo);

	public int promCancel(List<String> emplList);

	public Map<String, Object> getSelect();


}
