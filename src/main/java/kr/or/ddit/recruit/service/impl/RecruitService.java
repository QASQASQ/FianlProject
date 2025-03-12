package kr.or.ddit.recruit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.recruit.mapper.IRecruitMapper;
import kr.or.ddit.recruit.service.IRecruitService;
import kr.or.ddit.recruit.vo.ApplierVO;
import kr.or.ddit.recruit.vo.RecSortVO;
import kr.or.ddit.recruit.vo.RecruitVO;

@Service
public class RecruitService implements IRecruitService {

    @Autowired
    private IRecruitMapper mapper;

    @Override
    public void updateAppAt(String recNo, String appNm) {
        // 1. 지원자의 채용 상태 업데이트
        mapper.updateAppAt(recNo, appNm);

        // 2. 채용 인원 수 조회
        int confirmedCount = mapper.getConfirmedApplicantCount(recNo);

        // 3. 해당 채용 공고의 모집 정원 조회
        RecruitVO recruit = mapper.selectRecruit(recNo);
        // recTarget은 "3명"과 같이 문자 포함 문자열인 경우 숫자만 추출
        int target = Integer.parseInt(recruit.getRecTarget().replaceAll("[^0-9]", ""));

        // 4. 모집 정원에 도달했다면 채용 공고 상태를 'N'(완료)으로 업데이트 (mapper에 updateRecruitUsageToN 메서드 추가)
        if (confirmedCount >= target) {
            mapper.updateRecruitUsageToN(recNo);
        }
    }

    @Override
    public List<ApplierVO> getRecruitList(String recNo, String searchWord, int startRow, int endRow) {
        return mapper.getRecruitList(recNo, searchWord, startRow, endRow);
    }

    @Override
    public int getRecruitListCount(String recNo, String searchWord) {
        return mapper.getRecruitListCount(recNo, searchWord);
    }

    @Override
    public void insertJobPost(RecruitVO jobData) {
        mapper.insertRecruit(jobData);

        List<RecSortVO> sortList = jobData.getSortList();
        if (sortList != null && !sortList.isEmpty()) {
            for (RecSortVO sort : sortList) {
                // REC_NO 세팅 (부모 공고번호)
                sort.setRecNo(jobData.getRecNo());
                mapper.insertRecSort(sort);
            }
        }
    }

    @Override
    public RecruitVO selectRecruit(String recNo) {
        // 공고 메인 정보 조회
        RecruitVO recruit = mapper.selectRecruit(recNo);
        if (recruit != null) {
            // 기술항목 목록 조회
            List<RecSortVO> sortList = mapper.selectRecSortList(recNo);
            recruit.setSortList(sortList);
        }
        return recruit;
    }

    @Override
    public int getJobPostListCount(String searchWord) {
        return mapper.getJobPostListCount(searchWord);
    }

    @Override
    public List<RecruitVO> getJobPostList(String searchWord, String status, int startRow, int endRow) {
        return mapper.getJobPostList(searchWord, status, startRow, endRow);
    }

    @Override
    public ApplierVO getApplier(String appNo) {
        return mapper.getApplier(appNo);
    }

    @Override
    public void updateApplierEvaluation(Map<String, Object> evaluationData) {
        mapper.updateApplierEvaluation(evaluationData);
    }
    
}
