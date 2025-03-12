package kr.or.ddit.recruit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.recruit.mapper.IRecruitMapper;
import kr.or.ddit.recruit.mapper.IRecruitWebMapper;
import kr.or.ddit.recruit.service.IRecruitService;
import kr.or.ddit.recruit.service.IRecruitWebService;
import kr.or.ddit.recruit.vo.ApplierVO;
import kr.or.ddit.recruit.vo.RecSortVO;
import kr.or.ddit.recruit.vo.RecruitVO;

@Service
public class RecruitWebService implements IRecruitWebService {

    @Autowired
    private IRecruitWebMapper mapper;

    /* react <-> spring */
	@Override
	public List<RecruitVO> getJobs() {
		return mapper.getJobPostList();
	}
	
	@Override
	public RecruitVO getJobById(String recNo) {
		return mapper.getJobById(recNo);
	}

	@Override
	public List<RecSortVO> getResumeQuestion(String recNo) {
	    return mapper.getResumeQuestion(recNo);
	}

	
	@Override
	public int insertApplication(ApplierVO applier) {
	    return mapper.insertApplication(applier);
	}


}
