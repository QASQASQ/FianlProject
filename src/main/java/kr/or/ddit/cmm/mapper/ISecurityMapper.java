package kr.or.ddit.cmm.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.employee.vo.EmployeeVO;

@Mapper
public interface ISecurityMapper {

	public EmployeeVO selectEmployee(String username);

}
