package kr.or.ddit.dclz.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.dclz.mapper.IDclzMapper;
import kr.or.ddit.dclz.service.IDclzService;
import kr.or.ddit.sanction.vo.HistoryVO;

@Service
public class DclzServiceImpl implements IDclzService{

	@Autowired
	IDclzMapper dclzMapper;
	
	@Override
	public List<HistoryVO> getOvertimeList(PaginationInfoVO<HistoryVO> pageVO) {
		return dclzMapper.getOvertimeList(pageVO);
	}

	@Override
	public int getOverTimeTotalRecord(PaginationInfoVO<HistoryVO> pageVO) {
		return dclzMapper.getOverTimeTotalRecord(pageVO);
	}

}
