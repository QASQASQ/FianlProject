package kr.or.ddit.board.notice.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.notice.vo.NoticeVO;
import kr.or.ddit.cmm.vo.DocFileVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;

@Mapper
public interface INoticeMapper {

	public int noticeInsert(NoticeVO notice);

	public List<NoticeVO> noticeList(PaginationInfoVO<NoticeVO>pagingVO);

	public String selectSeq(); // 파일시퀀스 가져오기

	public void incrementHit(String noticeNo);

	public NoticeVO selectNotice(String noticeNo);

	public int selectCount(String searchWord);

	public int noticeUpdate(NoticeVO noticeVO);

	public int noticeDelete(String noticeNo);

	public int deleteFileList(String fileIdentify);


}
