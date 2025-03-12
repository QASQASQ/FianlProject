package kr.or.ddit.hr.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;
import kr.or.ddit.hr.service.IHrService;
import kr.or.ddit.hr.vo.DepartmentVO;
import kr.or.ddit.hr.vo.EmployeeVO;
import kr.or.ddit.hr.vo.TeamVO;

@Controller
@RequestMapping("/hrms/hr")
public class HrController {

	@Autowired
	private IHrService hrService;
	
	@GetMapping("/hr")
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	public String goHr(DepartmentVO deparment,Model model) {
        
        List<DepartmentVO> departments = hrService.getAllDepartments();
        if (departments.isEmpty()) {
            System.out.println("DB 데이터 없음.");
        } else {
            System.out.println("부서 개수: " + departments.size());
            departments.forEach(dept -> System.out.println("Department: " + dept.getDeptName()));
        }
        model.addAttribute("departments", departments); 
        return "hr/hr"; // JSP (WEB-INF/views/hr/hr.jsp)
    }
	
	@GetMapping("/hrAdmin")
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	public String goHrAdmin(DepartmentVO deparment,Model model) {
        
        List<DepartmentVO> departments = hrService.getAllDepartments();
        if (departments.isEmpty()) {
            System.out.println("DB 데이터 없음.");
        } else {
            System.out.println("부서 개수: " + departments.size());
            departments.forEach(dept -> System.out.println("Department: " + dept.getDeptName()));
        }
        model.addAttribute("departments", departments); 
        return "hr/hrAdmin"; // JSP (WEB-INF/views/hr/hrAdmin.jsp)
    }
	
	@GetMapping("/members")
	@ResponseBody
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	public List<EmployeeVO> getTeamMembers(@RequestParam("teamName") String teamName) {
	    List<EmployeeVO> members = hrService.getTeamMembers(teamName);

	    members.forEach(member -> {
	        System.out.println("emplNm: " + member.getEmplNm());
	        System.out.println("deptName: " + member.getDeptName());
	        System.out.println("ccName: " + member.getCcName());
	        System.out.println("emplNo: " + member.getEmplNo());
	        System.out.println("emplEmail: " + member.getEmplEmail());
	        System.out.println("emplTelno: " + member.getEmplTelno());
	        System.out.println("dclzType: " + member.getDclzType());
	    });

	    return members;
	}
	
	
	
	@PostMapping("/saveSelectedValue")
    public String saveSelectedValue(@RequestParam("selectedValue") String selectedValue, HttpSession session) {
        session.setAttribute("selectedValue", selectedValue);
        return "hr/saveSelectedValue"; // 클라이언트에게 성공 응답
    }
	
	// 부서 생성 요청 처리
    @PostMapping("/createDepartment")
    @ResponseBody
    public ResponseEntity<String> createDepartment(@RequestBody DepartmentVO department) {
        try {
        	hrService.createDepartment(department);
            return ResponseEntity.ok("부서 생성 성공");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("부서 생성 실패");
        }
    }
    
    // 팀 생성 요청 처리
    @PostMapping("/createTeam")
    @ResponseBody
    public ResponseEntity<String> createTeam(@RequestBody TeamVO team) {
        try {
            System.out.println("Received TeamCode: " + team.getTeamCode());
            hrService.createTeam(team);
            return ResponseEntity.ok("팀 생성 성공");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("팀 생성 실패");
        }
    }
    
    @PostMapping("/deleteTeam")
    public ResponseEntity<String> deleteTeam(@RequestBody Map<String, String> requestBody) {
        String teamCode = requestBody.get("teamCode");

        if (teamCode == null || teamCode.isEmpty()) {
            return ResponseEntity.badRequest().body("팀 코드가 비어 있습니다.");
        }

        try {
            TeamVO team = new TeamVO();
            team.setTeamCode(teamCode); // TeamVO에 팀 코드를 설정
            hrService.deleteTeam(team); // 서비스 호출
            return ResponseEntity.ok("팀 삭제 성공");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("팀 삭제 실패");
        }
    }
 
    @PostMapping("/deleteDepartment")
    public ResponseEntity<String> deleteDepartment(@RequestBody Map<String, String> requestBody) {
        String deptCode = requestBody.get("deptCode");

        if (deptCode == null || deptCode.isEmpty()) {
            return ResponseEntity.badRequest().body("부서 코드가 비어 있습니다.");
        }
        try {
            DepartmentVO department = new DepartmentVO();
            department.setDeptCode(deptCode);
            hrService.deleteDepartment(department); // 서비스 호출
            return ResponseEntity.ok("팀 삭제 성공");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("부서 삭제 실패");
        }
    }
}
