package kr.or.ddit.promotion.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.cmm.vo.CommonCodeVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.vo.DepartmentVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.promotion.mapper.IPromMapper;
import kr.or.ddit.promotion.service.IPromService;
import kr.or.ddit.promotion.vo.EvaluationVO;
@Service
public class PromServiceImpl implements IPromService {

	@Autowired
	private IPromMapper promMapper;
	@Override
	public List<EmployeeVO> emplList() {
		return promMapper.emplList();
	}
	@Override
	public int getTotalRecord(String emplNo, String emplNm, String deptCode, String position) {
		return promMapper.getTotalRecord(emplNo,emplNm,deptCode,position);
	}
	@Override
	public List<EvaluationVO> getEvaluList(PaginationInfoVO<EvaluationVO> pageVO, String emplNo,
			String emplNm, String deptCode, String position, String sorting) {
		return promMapper.getEvaluList(pageVO, emplNo, emplNm, deptCode, position, sorting);
	}
	@Override
	public int promoteTarget(String emplNo) {
		return promMapper.promoteTarget(emplNo);
	}
	@Override
	public List<EvaluationVO> getPromList() {
		return promMapper.getPromList();
	}
	@Override
	public int promEmpl(String emplNo) {
		return promMapper.promEmpl(emplNo);
	}
	
	@Override
	public int promCancel(List<String> emplList) {
		int result = 0;
		for(String empl : emplList) {
			result += promMapper.promCancel(empl);
		}
		return result;
	}
	@Override
	public Map<String, Object> getSelect() {
		Map<String, Object> resultMap = new HashMap<>();
		List<DepartmentVO> deptList = promMapper.getDept();
		List<CommonCodeVO> commonCodeList = promMapper.getPosition();
		resultMap.put("deptList", deptList);
		resultMap.put("commonCodeList", commonCodeList);
		return resultMap;
	}

}
