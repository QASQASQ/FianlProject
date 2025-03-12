package kr.or.ddit.hr.vo;

import lombok.Data;
import java.util.List;

@Data
public class DepartmentVO {
    private String deptCode; // 부서 코드
    private String deptName; // 부서 이름
    private String deptHeader;    // 부서장 코드
    private List<TeamVO> teams; // 팀 리스트
}

