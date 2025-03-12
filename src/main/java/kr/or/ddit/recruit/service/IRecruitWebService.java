package kr.or.ddit.recruit.service;

import java.util.List;

import kr.or.ddit.recruit.vo.ApplierVO;
import kr.or.ddit.recruit.vo.RecSortVO;
import kr.or.ddit.recruit.vo.RecruitVO;

public interface IRecruitWebService {

	public List<RecruitVO> getJobs(); // react에서 채용공고 데이터 필요할때.

	public RecruitVO getJobById(String recNo); // react에서 채용공고 상세보기

	public List<RecSortVO> getResumeQuestion(String recNo);  // 질문지 여러개 가져오기

	public int insertApplication(ApplierVO applier);   // 질문 내용 저장



}
