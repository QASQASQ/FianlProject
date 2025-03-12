package kr.or.ddit.recruit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.recruit.vo.ApplierVO;
import kr.or.ddit.recruit.vo.RecSortVO;
import kr.or.ddit.recruit.vo.RecruitVO;

@Mapper
public interface IRecruitWebMapper {

   /* react <-> spring */
  public List<RecruitVO> getJobPostList();
  
  RecruitVO getJobById(@Param("recNo") String recNo);

  public List<RecSortVO> getResumeQuestion(String recNo);

  public int getResumeQuestion(ApplierVO applier);
  
  int insertApplication(ApplierVO applier);


}
