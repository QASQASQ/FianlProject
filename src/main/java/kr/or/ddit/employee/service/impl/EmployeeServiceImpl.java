package kr.or.ddit.employee.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.cmm.vo.CommonCodeVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.mapper.IEmployeeMapper;
import kr.or.ddit.employee.service.IEmployeeService;
import kr.or.ddit.employee.vo.AuthVO;
import kr.or.ddit.employee.vo.DepartmentVO;
import kr.or.ddit.employee.vo.EmpAuthVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.employee.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EmployeeServiceImpl implements IEmployeeService {
	
	@Autowired
	private IEmployeeMapper mapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	private static final String UPLOAD_DIR = "C:/profile_images/";
	
	@Override
	public List<CommonCodeVO> getPositionCodes(String position) {
		
		List<CommonCodeVO> ccvo = mapper.getPositionCodes(position);
		
		return ccvo;
	}

	@Override
	public List<DepartmentVO> getDeptCodes() {
		
		List<DepartmentVO> dvo = mapper.getDeptCodes();
		
		return dvo;
		
	}

	@Override
	public List<TeamVO> getTeamCodes(String deptCode) {

		List<TeamVO> tvo = mapper.getTeamCodes(deptCode);
		
		return tvo;
	}

	@Override
	public List<CommonCodeVO> getBankCodes(String bankCode) {
		
		List<CommonCodeVO> ccvo = mapper.getBankCodes(bankCode);
		
		return ccvo;
	}

	@Override
	@Transactional
	public void registerEmployee(EmployeeVO evo) {
		
		mapper.registerEmployee(evo);
		mapper.giveVacation(evo);
		String emplNo = evo.getEmplNo();
		List<String> authList = evo.getAuthListStr();
		
		EmpAuthVO eavo = new EmpAuthVO();
		eavo.setEmplNo(emplNo);
		
		for(int i = 0; i < authList.size(); i++) {
			eavo.setAuthCode(authList.get(i));
			mapper.registerAuth(eavo);
		}
		
	}

	@Override
	public List<AuthVO> getAuthList() {
		
		List<AuthVO> avo = mapper.getAuthList();
		
		return avo;
	}

	@Override
	@Transactional
	public void bulkRegisterEmployee(List<EmployeeVO> excel) {
	    try {
	        for (EmployeeVO employee : excel) {
	            // 비밀번호 인코딩 (passwordEncoder는 주입받은 인스턴스)
	            String pwd = passwordEncoder.encode(employee.getEmplPwd());
	            employee.setEmplPwd(pwd);
	            mapper.giveVacation(employee);
	            // 사원 기본 정보 등록
	            mapper.registerEmployee(employee);
	            
	            // 엑셀 파일에 권한 정보가 포함되어 있다면 등록 처리
	            if (employee.getAuthListStr() != null) {
	                EmpAuthVO eavo = new EmpAuthVO();
	                eavo.setEmplNo(employee.getEmplNo());
	                for (String authCode : employee.getAuthListStr()) {
	                    eavo.setAuthCode(authCode);
	                    mapper.registerAuth(eavo);
	                }
	            }
	        }
	    } catch (Exception e) {
	        // 예외 발생 시 로그 출력 후 예외를 재던져 롤백 처리
	        e.printStackTrace();
	        throw new RuntimeException("Bulk employee registration failed", e);
	    }
	}
	
	/**
	 * 사원 정보 조회(사원 정보 페이지)
	 */
	@Override
	public EmployeeVO getEmplInfo(EmployeeVO employeeVO) {
		
		EmployeeVO evo = mapper.getEmplInfo(employeeVO);
		
		return evo;
	}

	@Override
	public int employeeUpdate(EmployeeVO evo) {

		int cnt = mapper.employeeUpdate(evo);
		
		return cnt;
	}

	@Override
	public int changePwd(EmployeeVO evo) {
		
		String pwd = passwordEncoder.encode(evo.getEmplPwd());
		evo.setEmplPwd(pwd);
		
		int cnt = mapper.changePwd(evo);
		
		return cnt;
	}

	@Override
	public List<Map> getSomeCode(String userId) {
		
		List<Map> list = mapper.getSomeCode(userId);
		
		return list;
	}

	@Override
	public String saveProfileImg(String emplNo, MultipartFile file) {
		
		if(file.isEmpty()) {
			return null;
		}
		
		// 파일 저장 디렉토리 확인 및 생성 (UPLOAD_DIR 상수는 미리 선언되어 있어야 합니다.)
	    File uploadDir = new File(UPLOAD_DIR);
	    if (!uploadDir.exists()) {
	        uploadDir.mkdirs(); // 디렉토리가 없으면 생성
	    }

		 // 원본 파일명과 고유 파일명 생성 (예: UUID 이용)
	    String originalFilename = file.getOriginalFilename();
	    int idx = originalFilename.lastIndexOf(".");
	    String fileName = null;
	    
	    if (idx >= 0) {
	    	String extension = originalFilename.substring(idx);
	    	fileName = emplNo + extension;
	    }
	    
	    // 파일 저장 경로 (FILE_PATH 상수는 미리 선언되어 있어야 합니다.)
	    File dest = new File(UPLOAD_DIR + fileName);
	    try {
	        file.transferTo(dest); // 파일을 지정 경로에 저장
	    } catch (IOException e) {
	        e.printStackTrace();
	        return null;
	    }
	    
	    // DB 업데이트를 위한 EmployeeVO 객체 생성 및 파일명 세팅
	    EmployeeVO evo = new EmployeeVO();
	    evo.setEmplNo(emplNo);
	    evo.setProfileImgpath(fileName);
	    
	    // Mapper를 통해 DB에 프로필 이미지 경로 업데이트
	    int cnt = mapper.profileImgUpload(evo);
		
		return cnt == 1 ? fileName : null;
	}

	@Override
	public String getBankCode(String userId) {
		
		String str = mapper.getBankCode(userId);
		
		return str;
	}

	@Override
	public int saveSignature(Map<String, String> payload) {
		
		String emplNo = payload.get("emplNo");
		String signatureData = payload.get("signatureData");
		
		// 데이터 URL에서 "data:image/png;base64," 부분 제거
	    if (signatureData.contains(",")) {
	        signatureData = signatureData.split(",")[1];
	    }
	    
	    // base64 문자열을 byte[]로 디코딩
	    byte[] signatureBytes = Base64.getDecoder().decode(signatureData);
	    
	    EmployeeVO evo = new EmployeeVO();
	    evo.setEmplNo(emplNo);
	    evo.setEmplSignature(signatureBytes);
	    log.info("서명 저장 Mapper VO 확인: " + evo);
	    
	    int cnt = mapper.saveSignature(evo);
		
		return cnt;
	}

	@Override
	public List<EmpAuthVO> getEmpAuth(String userId) {
		
		List<EmpAuthVO> eavo = mapper.getEmpAuth(userId);
		
		return eavo;
	}

}
