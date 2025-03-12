package kr.or.ddit.dclz.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.sanction.vo.HistoryVO;

@Mapper
public interface IDclzMapper {

	List<HistoryVO> getOvertimeList(PaginationInfoVO<HistoryVO> pageVO);

	int getOverTimeTotalRecord(PaginationInfoVO<HistoryVO> pageVO);

}
