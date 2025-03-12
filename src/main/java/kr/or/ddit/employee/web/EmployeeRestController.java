package kr.or.ddit.employee.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.cmm.vo.CommonCodeVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.service.IEmployeeExcelService;
import kr.or.ddit.employee.service.IEmployeeService;
import kr.or.ddit.employee.vo.AuthVO;
import kr.or.ddit.employee.vo.DepartmentVO;
import kr.or.ddit.employee.vo.EmpAuthVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.employee.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@RestController
@RequestMapping("/employee")
public class EmployeeRestController {
	
	private static final String FILE_PATH = "C:/uploads/";
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private IEmployeeService service;
	
	@Autowired
	private IEmployeeExcelService xlsService;
	
	/**
	 * @author 김원빈
	 * @return 신규 사원 생성 시 selectbox 직위 목록 조회
	 */
	@GetMapping("/getPositionCodes")
	public List<CommonCodeVO> getPositionCodes(String position) {
		log.info("# 공통 코드 직위 목록 가져오기 성공");
		
		List<CommonCodeVO> ccvo = service.getPositionCodes(position);
		
		return ccvo;
	}
	
	
	/**
	 * @author 김원빈
	 * @return 신규 사원 생성 시 selectbox 부서 목록 조회
	 */
	@GetMapping("/getDeptCodes")
	public List<DepartmentVO> getDeptCodes() {
		
		log.info("# 부서 목록 가져오기 성공");
		
		List<DepartmentVO> dvo = service.getDeptCodes();
		
		return dvo;
	}
	
	/**
	 * @author 김원빈
	 * @return 신규 사원 생성 시 selectbox 팀 목록 조회
	 */
	@GetMapping("/getTeamCodes")
	public List<TeamVO> getTeamCodes(String deptCode) {
		
		log.info("# 팀 목록 가져오기 성공");
		
		List<TeamVO> tvo = service.getTeamCodes(deptCode);
		
		return tvo;
	}
	
	/**
	 * @author 김원빈
	 * @return 신규 사원 생성 시 selectbox 은행 목록 조회
	 */
	@GetMapping("/getBankCodes")
	public List<CommonCodeVO> getBankCodes(String bankCode) {
		
		log.info("은행 목록 가져오기 성공");
		
		List<CommonCodeVO> ccvo = service.getBankCodes(bankCode);
		
		return ccvo;
	}
	
	/**
	 * @author 김원빈
	 * @return 신규 사원 DB INSERT 기능
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	@PostMapping("/register")
	public ResponseEntity<Map<String, String>> insertEmployee(@RequestBody EmployeeVO evo) throws IOException {
		log.info("evo : " + evo.toString());
		log.info("권한 목록: " + evo.getAuthListStr());
		
		String pwd = passwordEncoder.encode(evo.getEmplPwd());
		
		evo.setEmplPwd(pwd);
		log.info("인코딩 된 비밀번호: " + pwd);
		
        service.registerEmployee(evo);
        
        // EmployeeVO 대신 간단한 응답을 반환
        Map<String, String> response = new HashMap<>();
        response.put("message", "등록 성공");

        return ResponseEntity.ok(response);
		
	}
	
	/**
	 * @author 김원빈
	 * @return 사원 권한 조회
	 */
	@GetMapping("/getAuthList")
	public List<AuthVO> getAuthList() {
		
		List<AuthVO> avo = service.getAuthList();
		
		return avo;
	}
	
	/**
	 * @author 김원빈
	 * @return 엑셀 파일 이용하여 사원 일괄 등록
	 */
	@PostMapping("/bulkRegister")
	public ResponseEntity<Map<String, String>> bulkRegister(@RequestParam("excelFile") MultipartFile file) {
		
		Map<String, String> response = new HashMap<>();
		
		try {
			
			// 엑셀 파싱 서비스 호출
			List<EmployeeVO> excel = xlsService.parseExcelFile(file);
			
			// 서비스에서 일괄 등록 처리
			service.bulkRegisterEmployee(excel);
			response.put("message", "일괄 등록이 완료되었습니다.");
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			e.printStackTrace();
			response.put("message", "일괄 등록에 실패하였습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
		
	}
	
	/**
	 * @author 김원빈
	 * @return 사원 정보 페이지 데이터 호출
	 */
	@GetMapping("/getEmplInfo")
	public EmployeeVO getEmplInfo(EmployeeVO employeeVO, Model model) {
		EmployeeVO evo = service.getEmplInfo(employeeVO);
		
		if(evo != null) {
			log.info("사원 정보 호출 완료: " + evo);
		} else {
			log.info("사원 정보 호출에 오류 발생: " + evo);
		}
		
		return evo;
	}
	
	/**
	 * @author 김원빈
	 * @return 사원 정보 수정(업데이트)
	 */
	@PostMapping("/employeeUpdate")
	public int employeeUpdate(@RequestBody EmployeeVO evo) {
		log.info("사원 정보 수정 기능 실행");
		log.info("evo: " + evo);
		int cnt = service.employeeUpdate(evo);
		
		return cnt;
	}
	
	@PostMapping("/changePwd")
	public int changePwd(@RequestBody EmployeeVO evo) {
		log.info("비밀번호 변경 기능 실행");

		int cnt = service.changePwd(evo);
		
		return cnt;
		
	}
	
	@GetMapping("/getSomeCode")
	public List<Map> getSomeCode(String userId) {
		log.info("getSomeCode 실행");
		
		List<Map> list = service.getSomeCode(userId);
		log.info("컨트롤러 내부 getSomeCode list: " + list);
		
		return list;
		
	}
	
	@PostMapping("/profileImgUpload")
	public String profileImgUpload(@RequestParam("profileImgpath") MultipartFile file,
	        @RequestParam("emplNo") String emplNo) {
		log.info("프로필이미지(컨트롤러) emplNo: " + emplNo);
		log.info("프로필이미지(컨트롤러) file: " + file);
		log.info("프로필 이미지 저장 컨트롤러 실행");
		
		String str = service.saveProfileImg(emplNo, file);
		
		return str;
	}
	
	@GetMapping("/getBankCode")
	public String getBankCode(String userId) {
		log.info("아힘들다진짜 컨트롤러 실행");
		
		String str = service.getBankCode(userId);
		
		return str;
	}
	
	@PostMapping("/saveSignature")
	public int saveSignature(@RequestBody Map<String, String> payload) {
		log.info("서명 저장 컨트롤러 실행: " + payload);
		int cnt = service.saveSignature(payload);
		
		return cnt;
	}
	
	@GetMapping("/getEmpAuth")
	public List<EmpAuthVO> getEmpAuth(String userId) {
		log.info("사원 권한 가져오기 실행");
		
		List<EmpAuthVO> eavo = service.getEmpAuth(userId);
		
		return eavo;
	}
}
