package kr.or.ddit.properties.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.cmm.security.CustomUserDetailsService;
import kr.or.ddit.properties.service.IPropService;
import kr.or.ddit.properties.vo.EmpPropVO;
import kr.or.ddit.properties.vo.PropertiesSortVO;
import kr.or.ddit.properties.vo.PropertiesVO;
import kr.or.ddit.properties.vo.PropertyRequestVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/hrms/prop")
@Controller
public class PropController {

	@Autowired
	private IPropService propSerivce;
    
	// 대여가능한 물품조회 페이지
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/userProp")
	public String getAllProp() {    
		return "properties/userProp";
	}
	
	// 대여가능한 물품조회 페이지 - 물건 대여신청
	@PostMapping("/rentItem")
    public ResponseEntity<String> rentItem(@AuthenticationPrincipal UserDetails userDetails, @RequestBody EmpPropVO rentalRequest) {
        // 빈 문자열이면 null로 변경
        if (rentalRequest.getEpRdate() != null && rentalRequest.getEpRdate().toString().trim().isEmpty()) {
            rentalRequest.setEpRdate(null);
        }
        String emplNo = userDetails.getUsername();  // 로그인한 사용자의 ID
        rentalRequest.setEmplNo(emplNo); // emplNo를 요청 객체에 추가
        boolean success = propSerivce.rentItem(rentalRequest);
        if (success) {
        	return ResponseEntity.ok("대여 신청이 완료되었습니다.");
        } else {
            return ResponseEntity.badRequest().body("대여 신청 중 오류 발생");
        }
    }
	
	// 대여가능한 물품조회 페이지 - 대여 상태 조회
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/checkRentalStatus")
	public ResponseEntity<Boolean> checkRentalStatus(@AuthenticationPrincipal UserDetails userDetails, @RequestParam("propNo") int propNo) {
		String emplNo = userDetails.getUsername();  // 로그인한 사용자의 ID
	    boolean isRented = propSerivce.isPropertyRented(emplNo, propNo);
	    return ResponseEntity.ok(isRented);
	}

	// 개인 대여 물품확인 페이지
    @PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
    @GetMapping("/userRentalAll")
    public String getMyProp(Model model, HttpServletRequest request) {
    	HttpSession session = request.getSession();
    	String emplNo = (String) session.getAttribute("userId");
        List<Map<String, Object>> userRentalAll = propSerivce.userRentalAll(emplNo);
        model.addAttribute("userRentalAll", userRentalAll);
        return "properties/userRentalAll";
    }
    
    // 개인 대여 물품확인 페이지 - 반납기능
    @PostMapping("/returnItem")
    public ResponseEntity<String> returnItem(@RequestBody Map<String, Object> requestData) {
        if (!requestData.containsKey("propNo")) {
            return ResponseEntity.badRequest().body("propNo가 없음");
        }
        int propNo;
        try {
            propNo = Integer.parseInt(requestData.get("propNo").toString());
        } catch (NumberFormatException e) {
            return ResponseEntity.badRequest().body("오류");
        }
        boolean success = propSerivce.updateReturnDate(propNo);
        if (success) {
        	propSerivce.increaseProp(propNo);
            return ResponseEntity.ok("반납 완료");
        } else {
            return ResponseEntity.badRequest().body("오류");
        }
    }
    
    // 사원들에게 제공하는 물품리스트 관리 페이지
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN')")
    @GetMapping("/propList")
    public String getAllCommandProp(Model model) {
        List<PropertiesVO> propList = propSerivce.findAll();
        model.addAttribute("propList", propList);
        return "properties/propList";
    }


    // 사원들에게 제공하는 물품리스트 관리 페이지 - 물품 저장기능
    @PostMapping("/insert")
    public ResponseEntity<String> saveProperty(@RequestBody List<PropertyRequestVO> insertData) {
    	for (PropertyRequestVO request : insertData) {
    		propSerivce.saveProp(request);
    	}
        return ResponseEntity.ok("새로운 데이터 추가 완료");
    }
    
    // 사원들에게 제공하는 물품리스트 관리 페이지 - 물품코드 저장기능
    @PostMapping("/insertPs")
    public ResponseEntity<String> savePropertyWithSort(@RequestBody List<PropertyRequestVO> insertData) {
    	for (PropertyRequestVO request : insertData) {
    		propSerivce.savePropCode(request);
    	}
        return ResponseEntity.ok("새로운 데이터 추가 완료");
    }
    
    // 사원들에게 제공하는 물품리스트 관리 페이지 -  물품 분류코드 리스트 가져오기
    @PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
    @GetMapping("/getPropertyCodes")
    public ResponseEntity<List<PropertiesSortVO>> getPropertyCodes() {
        List<PropertiesSortVO> propertyCodes = propSerivce.getPropertyCodes();
        return ResponseEntity.ok(propertyCodes);
    }

    // 사원들에게 제공하는 물품리스트 관리 페이지 -  개별 물품 데이터 가져오기 (수정용)
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN')")
    @GetMapping("/getProperty/{propNo}")
    public ResponseEntity<PropertiesVO> getProperty(@PathVariable int propNo) {
        PropertiesVO property = propSerivce.getPropertyById(propNo);
        return ResponseEntity.ok(property);
    }

    // 사원들에게 제공하는 물품리스트 관리 페이지 -  개별 물품 삭제하기
    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @PostMapping("/deleteProperty/{propNo}")  // ✅ `DELETE` 대신 `POST` 사용
    public ResponseEntity<String> deleteProperty(@PathVariable int propNo) {
        boolean isDeleted = propSerivce.deleteProperty(propNo);
        if (isDeleted) {
            return ResponseEntity.ok("삭제 성공");
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("삭제 실패");
        }
    }
    
    // 사원들에게 제공하는 물품리스트 관리 페이지 -  개별 물품 데이터 수정 후 저장
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN')")
    @PutMapping("/updateProperty")
    public ResponseEntity<String> updateProperty(@RequestBody PropertiesVO updatedProp) {
        boolean isUpdated = propSerivce.updateProperty(updatedProp);
        if (isUpdated) {
            return ResponseEntity.ok("수정 성공");
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("수정 실패");
        }
    }
}
