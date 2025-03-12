package kr.or.ddit.board.notice.service.impl;

import java.util.List;

import kr.or.ddit.board.ServiceResult;
import kr.or.ddit.board.notice.vo.NoticeVO;
import kr.or.ddit.cmm.vo.DocFileVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;

public interface INoticeService {

	//등록
	public int noticeInsert(NoticeVO notice);

	//목록
	public List<NoticeVO> noticeList(PaginationInfoVO<NoticeVO> pagingVO);

	public String selectSeq(); // 파일시퀀스 가져오기

	public NoticeVO selectNotice(String noticeNo);

	public int selectCount(String search);

	public int noticeUpdate(NoticeVO noticeVO);

	public int noticeDelete(String noticeNo);

	public int deleteFileList(String fileIdentify);


	

}
