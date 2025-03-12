package kr.or.ddit.recruit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class RecruitVO {
    private String recNo;         // 채용공고번호
    private String deptCode;      // 모집부서코드
    private String recTitle;      // 채용공고제목
    private String recPosition;   // 모집직급코드
    private String recContent;        // 업무내용
    private String recReq;        // 요구기술
    private String recIdeal;      // 요구인재상
    private Date recSdate;        // 모집시작일
    private Date recEdate;        // 모집종료일
    private String recExp;        // 경험
    private String recTreatment;  // 우대사항
    private String recEssential;  // 자격요건
    private String recUsage;      // 공고 활성여부 (Y/N)
    private String recTarget;      // 모집인원

    private String deptName;      // 부서명
    private String positionName;  // 직위명
    private String usageStatus;   // 공고활성여부(진행중/완료)
    
    // 연관된 기술항목 목록 (1:N 관계)
    private List<RecSortVO> sortList;
    
    private List<ApplierVO> applierList; // 지원자 목록 (1:N 관계)
    
 // 일부러 추가함
    public List<RecSortVO> getSortList() {
        return sortList;
    }

    public void setSortList(List<RecSortVO> sortList) {
        this.sortList = sortList;
    }
    
    public List<ApplierVO> getApplierList() {
        return applierList;
    }

    public void setApplierList(List<ApplierVO> applierList) {
        this.applierList = applierList;
    }
}
