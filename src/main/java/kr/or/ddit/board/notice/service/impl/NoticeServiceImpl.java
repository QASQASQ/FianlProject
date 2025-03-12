package kr.or.ddit.board.notice.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.board.ServiceResult;
import kr.or.ddit.board.notice.mapper.INoticeMapper;
import kr.or.ddit.board.notice.vo.NoticeVO;
import kr.or.ddit.cmm.vo.DocFileVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;

@Service
public class NoticeServiceImpl implements INoticeService{
	
	private String uploadPath = "C:/upload";
	

	@Autowired
	private INoticeMapper noticeMapper;

	//등록기능
	  @Override 
	  public int noticeInsert(NoticeVO notice) {
		  return noticeMapper.noticeInsert(notice); 
	  }
	 

	  //목록가져오기
	@Override
	public List<NoticeVO> noticeList(PaginationInfoVO<NoticeVO>pagingVO) {
		return noticeMapper.noticeList(pagingVO);
	}

	//파일 가져올때 시퀀스 
	@Override
	public String selectSeq() {
		return noticeMapper.selectSeq();
	}


	//게시글 상세보기
	@Override
	public NoticeVO selectNotice(String noticeNo) {
		noticeMapper.incrementHit(noticeNo); //게시글 조회수 증가
		return noticeMapper.selectNotice(noticeNo);
	}


	//총 게시물 개수
	@Override
	public int selectCount(String searchWord) {
		return noticeMapper.selectCount(searchWord);
	}


	//게시글 수정
	@Override
	public int noticeUpdate(NoticeVO noticeVO) {
//		int status = noticeMapper.noticeUpdate(noticeVO);
//		
//		if(status > 0) {
//			
//		}
		return noticeMapper.noticeUpdate(noticeVO);
	}


	@Override
	public int noticeDelete(String noticeNo) {
		
		NoticeVO noticeVO = noticeMapper.selectNotice(noticeNo);
		return noticeMapper.noticeDelete(noticeNo);
	}


	@Override
	public int deleteFileList(String fileIdentify) {
		return noticeMapper.deleteFileList(fileIdentify);
	}


	


	
	

}
