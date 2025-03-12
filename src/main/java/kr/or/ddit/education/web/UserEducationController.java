package kr.or.ddit.education.web;

import java.util.List;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.education.service.IEducationService;
import kr.or.ddit.education.vo.BookVO;
import kr.or.ddit.education.vo.CurriculumVO;
import kr.or.ddit.education.vo.EducationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hrms/education/user")
public class UserEducationController {

	@Autowired
	private IEducationService eduService;
	
	/* 사용자 : 전체 교육 목록보기 페이지 */
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/userAllTrainingListSearch")
	public String userAllTrainingListSearch() {
		return "education/userAllTrainingListSearch";
	}
	
	/* 사용자 : 교육상세페이지 페이지 */
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/userTrainingDetail/{edcNo}")
	public String userTrainingDetail(@PathVariable("edcNo") int edcNo, Model model) {
	    log.info("교육 상세 페이지 요청 - 교육번호: {}", edcNo);

	    // 교육 상세 정보 가져오기
	    EducationVO education = eduService.getEducationDetail(edcNo);
	    // 교육 관련 커리큘럼 리스트 가져오기
	    List<CurriculumVO> curriculumList = eduService.getCurriculumByEdcNo(edcNo);
	    // 교육 관련 도서 리스트 가져오기
	    List<BookVO> bookList = eduService.getBooksByEdcNo(edcNo);

	    // JSP로 데이터 전달
	    model.addAttribute("education", education);
	    model.addAttribute("curriculumList", curriculumList);
	    model.addAttribute("bookList", bookList);

	    return "education/userTrainingDetail";
	}
	
	/* 사용자 : 수강중인교육 페이지 */
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/userMyTrainingLecture/{edcNo}")
	public String userMyTrainingLecture(@PathVariable("edcNo") int edcNo, Model model) {
	    log.info("교육 상세 페이지 요청 - 교육번호: {}", edcNo);

	    // 교육 상세 정보 가져오기
	    EducationVO education = eduService.getEducationMyLectureDetail(edcNo);
	    // 교육 관련 커리큘럼 리스트 가져오기
	    List<CurriculumVO> curriculumList = eduService.getCurriculumMyLectureByEdcNo(edcNo);
	    // 교육 관련 도서 리스트 가져오기
	    List<BookVO> bookList = eduService.getBooksMyLectureByEdcNo(edcNo);

	    // JSP로 데이터 전달
	    model.addAttribute("education", education);
	    model.addAttribute("curriculumList", curriculumList);
	    model.addAttribute("bookList", bookList);

	    return "education/userMyTrainingLecture";
	}

	/* 사용자 : 수강중인교육 페이지 */
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/userMyTraining")
	public String userMyTraining() {
		return "education/userMyTraining";
	}
	
	/* 사용자 : 수강중인교육 - 상태바1 */
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@PostMapping("/updateProgress")
	@ResponseBody
	public ResponseEntity<?> updateProgress(@RequestParam("edcNo") int edcNo, 
											@RequestParam("curOrder") int curOrder, 
	                                       @AuthenticationPrincipal UserDetails userDetails) {
	    String emplNo = userDetails.getUsername();

	    // 현재 사용자의 진행률 가져오기
	    int currentProgress = eduService.getEducationProgress(edcNo, emplNo);

	    // 해당 교육의 전체 커리큘럼 개수 가져오기
	    int totalLectures = eduService.getTotalCurriculumCount(edcNo);

	    if (totalLectures > 0) {
	        int increment = 100 / totalLectures; // 1강의당 증가 퍼센트
	        int newProgress = Math.min(currentProgress + increment, 100); // 100% 초과 방지

	        // 진행률 업데이트
	        int result = eduService.updateEducationProgress(edcNo, emplNo, newProgress);
	        
	        if (result > 0) {
	            return ResponseEntity.ok("진행률 업데이트 완료: " + newProgress + "%");
	        } else {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("업데이트 실패");
	        }
	    } else {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("해당 교육에 등록된 커리큘럼이 없습니다.");
	    }
	}

	/* 사용자 : 수강중인교육 - 상태바2 */
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/getProgress")
	@ResponseBody
	public int getUpdatedProgress(@RequestParam("edcNo") int edcNo, @AuthenticationPrincipal UserDetails userDetails) {
	    String emplNo = userDetails.getUsername();
	    return eduService.getEducationProgress(edcNo, emplNo);
	}


}


	