package kr.or.ddit.recruit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.recruit.vo.ApplierVO;
import kr.or.ddit.recruit.vo.RecSortVO;
import kr.or.ddit.recruit.vo.RecruitVO;

@Mapper
public interface IRecruitMapper {

  public List<ApplierVO> getRecruitList(String recNo, String searchWord, int startRow, int endRow);

  public void updateAppAt(String recNo, String appNm);

  public int getRecruitListCount(String recNo, String searchWord);

  public RecruitVO selectRecruit(String recNo);

  public void insertRecSort(RecSortVO sort);

  public List<RecSortVO> selectRecSortList(String recNo);

  public void insertRecruit(RecruitVO recruit);

  public int getJobPostListCount(String searchWord);

  public List<RecruitVO> getJobPostList(String searchWord, String status, int startRow, int endRow);

  public ApplierVO getApplier(String appNo);

  public int getConfirmedApplicantCount(String recNo);

  public void updateRecruitUsageToN(String recNo);

  public void updateApplierEvaluation(Map<String,Object> evaluationData);

}
