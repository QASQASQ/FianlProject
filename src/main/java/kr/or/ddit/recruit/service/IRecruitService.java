package kr.or.ddit.recruit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.recruit.vo.ApplierVO;
import kr.or.ddit.recruit.vo.RecruitVO;

public interface IRecruitService {

    public List<ApplierVO> getRecruitList(String recNo, String searchWord, int startRow, int endRow);

    public void updateAppAt(String recNo, String appNm);

    public int getRecruitListCount(String recNo, String searchWord);

    public void insertJobPost(RecruitVO jobData);

    public RecruitVO selectRecruit(String recNo);

    public int getJobPostListCount(String searchWord);

    public List<RecruitVO> getJobPostList(String searchWord, String status, int startRow, int endRow);

    public ApplierVO getApplier(String appNo);

    public void updateApplierEvaluation(Map<String, Object> evaluationData);


}
