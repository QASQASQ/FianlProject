package kr.or.ddit.recruit.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.recruit.service.IRecruitWebService;
import kr.or.ddit.recruit.vo.ApplierVO;
import kr.or.ddit.recruit.vo.RecSortVO;
import kr.or.ddit.recruit.vo.RecruitVO;

@RestController
@RequestMapping("/hrms/react")
public class JobController {

	@Autowired
    private IRecruitWebService service;
	
    @GetMapping("/jobs")  //전체 공고 불러오기
    public ResponseEntity<List<RecruitVO>> getJobs() {
    	List<RecruitVO>jobs = service.getJobs();
    	return ResponseEntity.ok(jobs);
    }
    
    @GetMapping("/jobs/{id}")
    public ResponseEntity<RecruitVO> getJobDetail(@PathVariable("id") String recNo) {
        RecruitVO job = service.getJobById(recNo);
        if (job == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(job);
    }
    
    // 해당 직무의 질문지 여러개 가져오기
    @GetMapping("/jobs/{id}/sort")
    public ResponseEntity<List<RecSortVO>> getResumeQuestion(@PathVariable("id") String recNo) {
        List<RecSortVO> questions = service.getResumeQuestion(recNo);
        if (questions == null || questions.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(questions);
    }

    @PostMapping("/apply")
    public ResponseEntity<String> submitApplication(@RequestBody ApplierVO applier) {
        try {
            int result = service.insertApplication(applier);
            
            if (result > 0) {
                return ResponseEntity.ok("Application submitted successfully");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body("Failed to insert application. No rows affected.");
            }
        } catch (Exception e) {
            e.printStackTrace(); // 콘솔에서 에러 확인
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error while inserting application: " + e.getMessage());
        }
    }


    
    
}
