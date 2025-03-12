package kr.or.ddit.employee.service.impl;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.employee.service.IEmployeeExcelService;
import kr.or.ddit.employee.vo.EmployeeVO;

@Service
public class EmployeeExcelServiceImpl implements IEmployeeExcelService {

	@Override
	public List<EmployeeVO> parseExcelFile(MultipartFile file) {
	    List<EmployeeVO> employeeList = new ArrayList<>();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	    try (Workbook workbook = WorkbookFactory.create(file.getInputStream())) {
	        Sheet sheet = workbook.getSheetAt(0); // 첫번째 시트 사용
	        int startRow = 1; // 헤더 행 존재 시 첫 행 건너뛰기

	        for (int i = startRow; i <= sheet.getLastRowNum(); i++) {
	            Row row = sheet.getRow(i);
	            if (row == null) continue;

	            EmployeeVO employee = new EmployeeVO();
	            // 각 셀 값 매핑
	            employee.setEmplNo(getCellValue(row.getCell(0)));
	            employee.setEmplPwd(getCellValue(row.getCell(1)));
	            employee.setEmplNm(getCellValue(row.getCell(2)));
	            employee.setEmplPosition(getCellValue(row.getCell(3)));
	            employee.setDeptCode(getCellValue(row.getCell(4)));
	            employee.setTeamCode(getCellValue(row.getCell(5)));
	            
	            String brthdyStr = getCellValue(row.getCell(6));
	            try {
					Date brthdy = sdf.parse(brthdyStr);
					employee.setEmplBrthdy(sdf.format(brthdy));
				} catch (ParseException e) {
					e.printStackTrace();
				}
	            
	            String hireDateStr = getCellValue(row.getCell(7));
	            try {
					Date hireDate = sdf.parse(hireDateStr);
					employee.setHireDate(sdf.format(hireDate));
				} catch (ParseException e) {
					e.printStackTrace();
				}
	            
	            employee.setBasicSalary(Integer.parseInt(getCellValue(row.getCell(8))));
	            employee.setBankCode(getCellValue(row.getCell(9)));
	            employee.setBankName(getCellValue(row.getCell(10)));
	            employee.setAccount(getCellValue(row.getCell(11)));

	            // 12번째 컬럼: 권한 코드 (콤마로 구분되어 있다고 가정)
	            String authCodes = getCellValue(row.getCell(12));
	            List<String> authList = Arrays.asList(authCodes.split(","));
	            employee.setAuthListStr(authList);

	            employeeList.add(employee);
	        }
	    } catch (EncryptedDocumentException e) {
	        // 암호화된 파일일 경우 처리 로직
	        e.printStackTrace();
	    } catch (IOException e) {
	        // 입출력 예외 처리: 필요에 따라 재던지거나 로그를 남김
	        e.printStackTrace();
	    }
	    return employeeList;
	}
	
	private String getCellValue(Cell cell) {
	    if (cell == null) return "";
	    DataFormatter formatter = new DataFormatter();
	    return formatter.formatCellValue(cell).trim();
	}

}
