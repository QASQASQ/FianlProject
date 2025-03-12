package kr.or.ddit.dclz.service;

import java.util.List;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.sanction.vo.HistoryVO;

public interface IDclzService {

	List<HistoryVO> getOvertimeList(PaginationInfoVO<HistoryVO> pageVO);

	int getOverTimeTotalRecord(PaginationInfoVO<HistoryVO> pageVO);

}
