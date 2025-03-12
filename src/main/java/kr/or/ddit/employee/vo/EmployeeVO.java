package kr.or.ddit.employee.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vacation.vo.YearlyVacationVO;
import lombok.Data;

@Data
public class EmployeeVO {
	
	private String emplNo;			// 사원 번호
	private String emplPwd;			// 사원 비밀번호
	private String emplNm;			// 사원 명
	private String emplPosition;	// 사원 직위
	private String deptCode;		// 부서 코드
	private String teamCode;		// 팀 코드
	private byte[] emplSignature;	// 사원 서명
	private String emplBrthdy;		// 사원 생년월일
	private String hireDate;		// 입사일자
	private String retireDate;		// 퇴사일자
	private String retireResn;		// 퇴사 사유
	private String enable;			// 시큐리티 사용 여부
	private String profileImgpath;	// 프로필 이미지 경로
	private int basicSalary;		// 기본 급여 금액
	private String bankCode;		// 은행 코드
	private String bankName;		// 은행 지점명
	private String account;			// 계좌 번호
	private String zipCode;			// 우편 번호
	private String addrMain;		// 기본 주소
	private String addrDetail;		// 상세 주소
	private String emplTelno;		// 연락처
	private String emplGender;		// 성별
	private String emplEmail;		// 이메일
	private String emplHobby;		// 취미
	private String emplMrnry;		// 결혼기념일
	private String householderAt;	// 세대주 여부
	private String vehicleNumber;	// 차량 번호
	
	private MultipartFile profileImg;	// 프로필 이미지
	
	private List<EmpAuthVO> authList;	// 사원 권한
	private List<String> authListStr;	// 사원 권한을 문자열로 담기 위한 리스트

	private String deptName;			// 부서 이름
	private String ccName; 				// 직책 이름

	private YearlyVacationVO yearlyVacationVO;
	
}
