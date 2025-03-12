package kr.or.ddit.education.web;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.education.service.IEducationService;
import kr.or.ddit.education.vo.EdcRequestVO;
import kr.or.ddit.education.vo.EducationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/hrms/education/user/rest")
public class UserEducationRestController {

    @Autowired
    private IEducationService eduService;

    /* 사용자 : 전체 교육 목록보기 페이지 */
    @PostMapping("/getEducationAllList")
    public ResponseEntity<Map<String, Object>> getEducationAllList(@RequestBody Map<String, String> paramMap) {
        ResponseEntity<Map<String, Object>> entity;
        Map<String, Object> resultMap = new HashMap<>();

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

        PaginationInfoVO<EducationVO> pageVO = new PaginationInfoVO<>();
        pageVO.setCurrentPage(currentPage);
        int totalRecord = eduService.selectEducationListCount(educationVO);
        pageVO.setTotalRecord(totalRecord);
        List<EducationVO> eduAllList = eduService.selectEducationList(pageVO, educationVO);

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

    /* 사용자 : 전체 교육 목록보기 페이지 - 수강신청 */
    @PostMapping("/insertEdcReqeust")
    @ResponseBody
    public ResponseEntity<String> insertEdcReqeust(@AuthenticationPrincipal UserDetails userDetails, @RequestBody EdcRequestVO edcRequestVO) {
        
        if (userDetails == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }
        String emplNo = userDetails.getUsername();  
        edcRequestVO.setEdcAplc(emplNo); 
        log.info("교육 신청한 내용: {}", edcRequestVO);
        int result = eduService.insertEdcReqeust(edcRequestVO);
        if (result > 0) {
            return ResponseEntity.ok("교육 신청 성공");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("교육 신청 실패");
        }
    }
    
    /* 사용자 : 나의교육목록 페이지 */
    @PostMapping("/getEducationMyList")
    public ResponseEntity<Map<String, Object>> getEducationMyList(@AuthenticationPrincipal UserDetails userDetails, @RequestBody Map<String, String> paramMap) {
        
    	String emplNo = userDetails.getUsername();  // 로그인한 사용자의 ID
    	ResponseEntity<Map<String, Object>> entity;
        Map<String, Object> resultMap = new HashMap<>();

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
        educationVO.setEmplNo(emplNo);

        PaginationInfoVO<EducationVO> pageVO = new PaginationInfoVO<>();
        pageVO.setCurrentPage(currentPage);
        int totalRecord = eduService.selectEducationMyListCount(educationVO);
        pageVO.setTotalRecord(totalRecord);
        List<EducationVO> eduAllList = eduService.selectEducationMyList(pageVO, educationVO);

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
    
    /* 유저 - 나의 교육전체기록 조회*/
    @PostMapping("/getEducationHistoryList")
    public ResponseEntity<Map<String, Object>> getEducationHistoryList(@AuthenticationPrincipal UserDetails userDetails, @RequestBody Map<String, String> paramMap) {
        
    	String emplNo = userDetails.getUsername();  // 로그인한 사용자의 ID
    	ResponseEntity<Map<String, Object>> entity; 
        Map<String, Object> resultMap = new HashMap<>();

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
        educationVO.setEmplNo(emplNo);

        PaginationInfoVO<EducationVO> pageVO = new PaginationInfoVO<>();
        pageVO.setCurrentPage(currentPage);
        int totalRecord = eduService.selectEducationMyHistoryListCount(educationVO);
        pageVO.setTotalRecord(totalRecord);
        List<EducationVO> eduAllList = eduService.selectEducationMyHistoryList(pageVO, educationVO);

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
}
