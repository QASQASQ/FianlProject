package kr.or.ddit.hr.vo;

import java.util.List;
import kr.or.ddit.hr.vo.TeamVO;
import lombok.Data;

@Data
public class TeamVO {
    private String teamCode;       // 팀 코드
    private String deptCode;       // 부서 코드
    private String teamHeader;     // 팀장 사원 번호
    private String teamName;       // 팀 이름
    private List<EmployeeVO> employees; // 사원 리스트
}
