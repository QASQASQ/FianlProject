package kr.or.ddit.employee.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.employee.vo.EmployeeVO;

public interface IEmployeeExcelService {

	public List<EmployeeVO> parseExcelFile(MultipartFile file);

}
