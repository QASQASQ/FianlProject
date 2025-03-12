package kr.or.ddit.education.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.education.service.IEducationService;
import kr.or.ddit.education.vo.BookVO;
import kr.or.ddit.education.vo.CurriculumVO;
import kr.or.ddit.education.vo.EdcRequestVO;
import kr.or.ddit.education.vo.EducationVO;
import kr.or.ddit.education.vo.EmpEdcVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/hrms/education/admin/rest")
public class AdminEducationRestController {

    @Autowired
    private IEducationService eduService;
    
	/* 관리자 : 전체교육목록관리 데이터 */
    @PostMapping("/getEducationAllList")
    public ResponseEntity<Map<String, Object>> getEducationAllList(@RequestBody Map<String, String> paramMap) {
        ResponseEntity<Map<String, Object>> entity;
        Map<String, Object> resultMap = new HashMap<>();

        // 뷰에서 전달받은 데이터 가져오기
        String edcTarget = paramMap.get("edcTarget");
        String educator = paramMap.get("educator");
        String edcTitle = paramMap.get("edcTitle");
        String edcSort = paramMap.get("edcSort");
        int currentPage = Integer.parseInt(paramMap.get("page"));
        log.info("edcTarget, educator, edcTitle, edcSort, currentPage " + currentPage + edcTarget + educator + edcTitle + edcSort);

        EducationVO educationVO = new EducationVO();
        educationVO.setEdcTarget(edcTarget);
        educationVO.setEducator(educator);
        educationVO.setEdcTitle(edcTitle);
        educationVO.setEdcSort(edcSort);

        // 페이지와 검색어를 위한 데이터 세팅
        PaginationInfoVO<EducationVO> pageVO = new PaginationInfoVO<>();
        pageVO.setCurrentPage(currentPage);
        int totalRecord = eduService.selectEducationListCount(educationVO);
        pageVO.setTotalRecord(totalRecord);
        List<EducationVO> eduAllList = eduService.selectEducationList(pageVO, educationVO);

        // 날짜 변환 적용
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for (EducationVO edu : eduAllList) {
            if (edu.getRecruitSdate() != null) {
                edu.setRecruitSdateFormatted(sdf.format(edu.getRecruitSdate())); 
            }
            if (edu.getRecruitEdate() != null) {
                edu.setRecruitEdateFormatted(sdf.format(edu.getRecruitEdate())); 
            }
            if (edu.getEdcSdate() != null) {
                edu.setEdcSdateFormatted(sdf.format(edu.getEdcSdate())); 
            }
            if (edu.getEdcEdate() != null) {
                edu.setEdcEdateFormatted(sdf.format(edu.getEdcEdate())); 
            }
        }
        if (!eduAllList.isEmpty()) {
            resultMap.put("eduAllList", eduAllList);
        }
        resultMap.put("pageVO", pageVO);
        entity = new ResponseEntity<>(resultMap, HttpStatus.OK);
        return entity;
    }
    
    /* 관리자 : 전체교육목록관리 - 책 등록하기 */
    @PostMapping(value = "/insertBook")
    public ResponseEntity<String> insertBook(@RequestBody BookVO bookVO) {
        log.info("받은 도서 정보: {}", bookVO); 
        int result = eduService.insertBook(bookVO);
        if (result > 0) {
            return ResponseEntity.ok("책 등록 성공");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("책 등록 실패");
        }
    }
    
    /* 관리자 : 전체교육목록관리 - 커리큘럼 등록하기 */
    @PostMapping("/insertCurriculum")
    @ResponseBody
    public ResponseEntity<String> insertCurriculum(@RequestBody List<CurriculumVO> curriculumList) {
        log.info("받은 커리큘럼 등록 정보 : {}", curriculumList);

        int result = eduService.insertCurriculum(curriculumList);
        
        if (result > 0) {
            return ResponseEntity.ok("커리큘럼 등록 성공");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("커리큘럼 등록 실패");
        }
    }
    
    /* 관리자 : 전체교육목록관리 - 교육 등록하기 */
    @PostMapping("/insertEducationWithCurriculum")
    @ResponseBody
    public ResponseEntity<String> insertEducationWithCurriculum(@RequestBody EducationVO educationVO){
    	log.info("받은 education 등록 정보 : {}", educationVO);
    	
    	int result = eduService.insertEducationWithCurriculum(educationVO);
    	if (result > 0) {
            return ResponseEntity.ok("교육 등록 성공");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("교육 등록 실패");
        }
    }
    
    /* 관리자 : 전체교육목록관리 - 교육 비활성화 하기 */
    @PostMapping("/updateEdcActive")
    @ResponseBody
    public ResponseEntity<String> updateEdcActive(@RequestBody Map<String, Integer> requestData) {
        int edcNo = requestData.get("edcNo");
        
        int result = eduService.deactivateEducation(edcNo);
        
        if (result > 0) {
            return ResponseEntity.ok("강의가 비활성화되었습니다.");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("비활성화 실패");
        }
    }
    
    /* 관리자 : 전체교육목록-DETAIL 데이터 */
    @PostMapping("/getEduApplicationAllList")
    public ResponseEntity<Map<String, Object>> getEduApplicationAllList(@AuthenticationPrincipal UserDetails userDetails, @RequestBody Map<String, String> paramMap) {
        ResponseEntity<Map<String, Object>> entity;
        Map<String, Object> resultMap = new HashMap<>();

        // 뷰에서 전달받은 데이터 가져오기
        String edcTarget = paramMap.get("edcTarget");
        String educator = paramMap.get("educator");
        String edcTitle = paramMap.get("edcTitle");
        String edcSort = paramMap.get("edcSort");
        int currentPage = Integer.parseInt(paramMap.get("page"));
        log.info("edcTarget, educator, edcTitle, edcSort, currentPage " + currentPage + edcTarget + educator + edcTitle + edcSort);

        EducationVO educationVO = new EducationVO();
        educationVO.setEdcTarget(edcTarget);
        educationVO.setEducator(educator);
        educationVO.setEdcTitle(edcTitle);
        educationVO.setEdcSort(edcSort);
        String emplNo = userDetails.getUsername();

        PaginationInfoVO<EducationVO> pageVO = new PaginationInfoVO<>();
        pageVO.setCurrentPage(currentPage);
        int totalRecord = eduService.selectEduApplicationListCount(educationVO);
        pageVO.setTotalRecord(totalRecord);
        
        List<EducationVO> eduAllList = eduService.selectEduApplicationList(emplNo, pageVO, educationVO);
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for (EducationVO edu : eduAllList) {
            if (edu.getRecruitSdate() != null) {
                edu.setRecruitSdateFormatted(sdf.format(edu.getRecruitSdate())); 
            }
            if (edu.getRecruitEdate() != null) {
                edu.setRecruitEdateFormatted(sdf.format(edu.getRecruitEdate())); 
            }
            if (edu.getEdcSdate() != null) {
                edu.setEdcSdateFormatted(sdf.format(edu.getEdcSdate())); 
            }
            if (edu.getEdcEdate() != null) {
                edu.setEdcEdateFormatted(sdf.format(edu.getEdcEdate())); 
            }
        }
        if (!eduAllList.isEmpty()) {
            resultMap.put("eduAllList", eduAllList);
        }
        resultMap.put("pageVO", pageVO);
        entity = new ResponseEntity<>(resultMap, HttpStatus.OK);
        return entity;
    }

    /* 관리자 : 교육 상세보기 데이터들 가져오기 */
    /* 관리자 : 전체교육목록-DETAIL 책 제목 조회 */
    @GetMapping("/getBookList")
    @ResponseBody
    public List<BookVO> getBookList() {
        return eduService.getAllBooks();
    }
    
    /* 관리자 : 전체교육목록-DETAIL 교육분류 조회 */
    @GetMapping("/getSortList")
    @ResponseBody
    public List<EducationVO> getSortList() {
        return eduService.getAllSort();
    }
    
    /* 관리자 : 전체교육목록-DETAIL 교육대상자 조회 */
    @GetMapping("/getTargetList")
    @ResponseBody
    public List<EducationVO> getTargetList() {
        return eduService.getAllTarget();
    }
    
    /* 관리자 : 전체교육목록-DETAIL 교육대상자 직급 조회 */
    @GetMapping("/getGradeList")
    @ResponseBody
    public List<EducationVO> getGradeList() {
        return eduService.getAllGrade();
    }
    
    /* 관리자 : 전체교육목록-DETAIL 책 제목 조회 */
    @GetMapping("/getCurList")
    @ResponseBody
    public List<CurriculumVO> getCurList() {
        return eduService.getCurList();
    }
    
    /* 관리자 : 전체교육목록-DETAIL 교육정보 수정 */
    @PostMapping("/updateEducation")
    public ResponseEntity<String> updateEducation(@RequestBody EducationVO educationVO) {
        int result = eduService.updateEducation(educationVO);
        if (result > 0) {
            return ResponseEntity.ok("교육 정보 수정 완료");
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("교육 정보 수정 실패");
    } 

    /* 관리자 : 전체교육목록-DETAIL 교육내용 수정 */
    @PostMapping("/updateContent")
    public ResponseEntity<String> updateContent(@RequestBody EducationVO educationVO) {
        int result = eduService.updateContent(educationVO);
        if (result > 0) {
            return ResponseEntity.ok("교육 내용 수정 완료");
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("교육 내용 수정 실패");
    } 

    /* 관리자 : 전체교육목록-DETAIL 교육교재 수정 */
    @PostMapping("/updateBook")
    public ResponseEntity<String> updateBook(@RequestBody EducationVO educationVO) {
        int result = eduService.updateBook(educationVO);
        if (result > 0) {
            return ResponseEntity.ok("교재 수정 완료");
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("교재 수정 실패");
    }

    /* 관리자 : 전체교육목록-DETAIL 교육커리큘럼 수정 */ 
    @PostMapping("/updateCurriculum")
    @ResponseBody
    public ResponseEntity<String> updateCurriculum(@RequestBody List<CurriculumVO> curriculumList) {
        log.info("받은 커리큘럼 수정 정보 : {}", curriculumList);
        log.info("CUR_URL 데이터: {}", curriculumList.get(0).getCurUrl());

        int result = eduService.updateCurriculum(curriculumList);
        
        if (result > 0) {
            return ResponseEntity.ok("커리큘럼 수정 성공");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("커리큘럼 수정 실패");
        }
    }
    
    /* 관리자 : 교육수강신청관리 - 승인반려 */
    @PostMapping("/updateEdcRequestStatus")
    @ResponseBody
    public ResponseEntity<String> updateEdcRequestStatus(@RequestBody EdcRequestVO edcRequestVO) {
        log.info("교육 신청 상태 변경 요청: {}", edcRequestVO);

     // ✅ 날짜 변환 (String → Date)
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date parsedDate = null;
        try {
            String[] dateRange = edcRequestVO.getErDate().split(" ~ "); // "2025-02-23 ~ 2025-08-30" → ["2025-02-23", "2025-08-30"]
            parsedDate = sdf.parse(dateRange[0]); // 시작 날짜만 사용
        } catch (ParseException e) {
            log.error("날짜 변환 실패: {}", edcRequestVO.getErDate(), e);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("잘못된 날짜 형식입니다.");
        }

        // ✅ 변환된 Date 저장
        edcRequestVO.setErDate(sdf.format(parsedDate));
        
        
        int result = eduService.updateEdcRequestStatus(edcRequestVO);

        if ("Y".equals(edcRequestVO.getErStatus())) {
            EdcRequestVO requestInfo = eduService.getEdcRequestByAplcAndEdcNo(edcRequestVO.getEdcAplc(), edcRequestVO.getEdcNo());

            if (requestInfo != null) {
                EmpEdcVO empEdcVO = new EmpEdcVO();
                empEdcVO.setEdcNo(requestInfo.getEdcNo());   
                empEdcVO.setEmplNo(requestInfo.getEdcAplc()); 
                empEdcVO.setEeStatus("진행 중");               
                empEdcVO.setEeProgress(0);                  

                int insertResult = eduService.insertEmpEdc(empEdcVO);
                if (insertResult > 0) {
                    log.info("EMP_EDC 테이블에 데이터 삽입 성공: {}", empEdcVO);
                    return ResponseEntity.ok("요청이 성공적으로 처리되었습니다.");
                } else {
                    log.error("EMP_EDC 테이블 삽입 실패");
                    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("EMP_EDC 삽입 실패");
                }
            } else {
                log.error("해당 신청 정보를 찾을 수 없음: {}", edcRequestVO);
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("신청 정보를 찾을 수 없습니다.");
            }
        }
        if (result > 0) {
            return ResponseEntity.ok("요청이 성공적으로 처리되었습니다.");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("요청 처리 실패");
        }
    }
    
    
    /* 관리자 : 해당 교육 수강자 조회 */
    @PostMapping("/getListenerList")
    public ResponseEntity<Map<String, Object>> getListenerList(@RequestBody Map<String, String> paramMap) {
        
    	ResponseEntity<Map<String, Object>> entity;
        Map<String, Object> resultMap = new HashMap<>();

        int edcNo = paramMap.get("edcNo") != null ? Integer.parseInt(paramMap.get("edcNo")) : 0;
        
        String emplNo = paramMap.get("emplNo");
        String emplNm = paramMap.get("emplNm");
        String eeStatus = paramMap.get("eeStatus");
        int eeProgress = paramMap.get("eeProgress") != null ? Integer.parseInt(paramMap.get("eeProgress")) : 0;
        paramMap.put("eeProgress", String.valueOf(eeProgress));
        int currentPage = Integer.parseInt(paramMap.get("page"));
        log.info("emplNo, emplNm, eeStatus, eeProgress, currentPage " + currentPage + emplNo + emplNm + eeStatus + eeProgress);

        EducationVO educationVO = new EducationVO();
        educationVO.setEmplNo(emplNo);
        educationVO.setEmplNm(emplNm);
        educationVO.setEeStatus(eeStatus);
        educationVO.setEeProgress(eeProgress);
        educationVO.setEdcNo(edcNo);

        PaginationInfoVO<EducationVO> pageVO = new PaginationInfoVO<>();
        pageVO.setCurrentPage(currentPage);
        int totalRecord = eduService.selectEducationListenerCount(edcNo, educationVO);
        pageVO.setTotalRecord(totalRecord);
        List<EducationVO> eduAllList = eduService.selectEducationListenerList(edcNo, pageVO, educationVO);
        
        if (!eduAllList.isEmpty()) {
            resultMap.put("eduAllList", eduAllList);
        }
        resultMap.put("pageVO", pageVO);
        entity = new ResponseEntity<>(resultMap, HttpStatus.OK);
        return entity;
    } 
}

    

