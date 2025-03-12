package kr.or.ddit.hr.vo;

import lombok.Data;

@Data
public class EmployeeVO {
	private String emplNo;
	private String emplPwd;
	private String emplNm;
	private String emplPosition;  // 직책
	private String deptCode;
	private String teamCode;
	private String emplSignature;
	private String emplBrthdy;
	private String hireDate;
	private String retireDate;
	private String retireResn;
	private String enable;
	private String profileImgPath;
	private String basicSalary;
	private String bankCode;
	private String bankName;
	private String account;
	private String zipCode;
	private String addrMain;
	private String addrDetail;
	private String emplTelno;
	private String emplGender;
	private String emplEmail;
	private String emplHobby;
	private String emplMrnry;
	private String householderAt;
	private String vehicleNumber;

	private DiligenceAndLazinessVO dildenceAndLaziness;
	private String dclzNo     ;
	private String dclzDate   ;
	private String dclzStime  ;
	private String dclzEtime  ;
	private String dclzStatus ;
	private String dclzType   ;
	
	private TeamVO team;
    private String teamHeader;     // 팀장 사원 번호
    private String teamName;       // 팀 이름
    
    private DepartmentVO department;
    private String deptName; // 부서 이름
    private String deptHeader;    // 부서장 코드
    
    private CommonCodeVO commonCode;
	private String ccCode   ;
	private String cgGroup  ;
	private String ccName   ;
	private String ccExplain;
	private String ccFlow   ;
	
}