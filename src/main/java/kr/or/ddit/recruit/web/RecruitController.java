package kr.or.ddit.recruit.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.recruit.service.IRecruitService;
import kr.or.ddit.recruit.service.MailService;
import kr.or.ddit.recruit.service.dto.HireData;
import kr.or.ddit.recruit.service.dto.SearchRequest;
import kr.or.ddit.recruit.vo.ApplierVO;
import kr.or.ddit.recruit.vo.RecruitVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/hrms")
@RestController
public class RecruitController {

    @Autowired
    private IRecruitService service;

    @Autowired
    private MailService mailService;

    @GetMapping("/recruit/list")
    public ResponseEntity<PaginationInfoVO<ApplierVO>> getRecruitList(
            @RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
            @RequestParam(required = false) String searchWord,
            @RequestParam String recNo) {

        // 전체 개수 조회 (페이징을 위해 필요)
        int totalRecord = service.getRecruitListCount(recNo, searchWord);
        PaginationInfoVO<ApplierVO> pagingVO = new PaginationInfoVO<>(10, 5); // 한 페이지에 10개씩, 페이지 블록 5개
        pagingVO.setTotalRecord(totalRecord);
        pagingVO.setCurrentPage(currentPage);
        pagingVO.setSearchWord(searchWord);

        // 페이징된 채용 리스트 조회
        List<ApplierVO> recruitList = service.getRecruitList(recNo, searchWord, pagingVO.getStartRow(), pagingVO.getEndRow());
        pagingVO.setDataList(recruitList);

        return ResponseEntity.ok(pagingVO);
    }

    @PostMapping("/recruit/hire")
    public ResponseEntity<String> hireEmployee(@RequestBody HireData hireData) {
        try {
            log.info("📩 채용 데이터: {}", hireData.toString());

            // 1️⃣ 채용 상태 업데이트
            service.updateAppAt(hireData.getRecNo(), hireData.getAppNm());

            // 2️⃣ 합격 메일 전송
            mailService.sendAcceptanceMail(hireData.getAppEmail(), hireData.getAppNm(), hireData.getEmplNo());
            log.info("✅ {} 님에게 합격 메일 전송 완료.", hireData.getAppNm());

            return ResponseEntity.ok("🎉 채용 요청과 합격 메일 전송이 성공적으로 완료되었습니다.");
        } catch (Exception e) {
            log.error("❌ 채용 처리 중 오류 발생: ", e);
            return ResponseEntity.status(500).body("❌ 채용 요청 처리 중 오류가 발생했습니다.");
        }
    }

    @PostMapping("/recruit/jobPost")
    public ResponseEntity<String> jobPost(@RequestBody RecruitVO jobData) {
        // 1) 채용공고 + 기술항목 등록
        service.insertJobPost(jobData);
        // 2) 성공 메시지 반환
        return ResponseEntity.ok("채용공고가 등록되었습니다.");
    }

    @PostMapping("/recruit/jobPost/list")
    public ResponseEntity<PaginationInfoVO<RecruitVO>> getjobPostList(
        @RequestBody(required = false) SearchRequest searchRequest) {
        
        String searchWord = searchRequest != null ? searchRequest.getSearchWord() : null;
        int currentPage = searchRequest != null ? searchRequest.getPage() : 1;
        String status = (searchRequest != null && searchRequest.getStatus() != null) ? searchRequest.getStatus() : "N"; 
        log.info("📡 검색어: {}, 페이지: {}", searchWord, currentPage);
        

        // 1. 전체 레코드 수를 조회 (검색어가 있을 경우 해당 조건에 맞는 개수)
        int totalRecord = service.getJobPostListCount(searchWord);
        
        // 2. PaginationInfoVO 생성 (예: 한 페이지에 10개씩, 페이지 블록 5개)
        PaginationInfoVO<RecruitVO> pagingVO = new PaginationInfoVO<>(10, 5);
        pagingVO.setTotalRecord(totalRecord);
        pagingVO.setCurrentPage(currentPage);
        pagingVO.setSearchWord(searchWord);
        
        // 3. 조회할 시작행과 끝행 계산 후, 목록 조회
        int startRow = pagingVO.getStartRow();
        int endRow = pagingVO.getEndRow();
        List<RecruitVO> jobPostList = service.getJobPostList(searchWord, status, startRow, endRow);
        pagingVO.setDataList(jobPostList);
        
        // 4. 결과 반환
        return ResponseEntity.ok(pagingVO);
    }

    @GetMapping("/recruit/getApplierDoc")
    @ResponseBody
    public ApplierVO getApplierDoc(@RequestParam("appNo") String appNo) {
        // 1) appNo로 DB 조회
        ApplierVO applier = service.getApplier(appNo); 

        return applier; 
    }
    
    @PostMapping("/recruit/evaluate")
    @ResponseBody
    public ResponseEntity<String> evaluateApplier(@RequestBody Map<String, Object> evaluationData) {
        try {
            service.updateApplierEvaluation(evaluationData);
            return ResponseEntity.ok("평가가 성공적으로 저장되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("평가 저장 중 오류 발생");
        }
    }

}
