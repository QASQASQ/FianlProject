package kr.or.ddit.board.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.board.board.mapper.IBoardMapper;
import kr.or.ddit.board.board.mapper.ICommentMapper;
import kr.or.ddit.board.board.service.IBoardService;
import kr.or.ddit.board.board.vo.BoardVO;
import kr.or.ddit.board.board.vo.CommentVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;

@Service
public class BoardServiceImpl implements IBoardService{

	@Autowired
	private IBoardMapper boardMapper;
	
	@Autowired
	private ICommentMapper cmtMapper;
	
	//파일 가져올때 시퀀스 
	@Override
	public String selectSeq() {
		return boardMapper.selectSeq();
	}

	//등록기능
	@Override
	public int boardInsert(BoardVO boardVO) {
		return boardMapper.boardInsert(boardVO);
	}

	//게시글 상세
	@Override
	public BoardVO selectBoard(String boardNo) {
		boardMapper.incrementHit(boardNo); //조회수 증가
		return boardMapper.selectBoard(boardNo);
	}

	//총 게시글 수 가져오기
	@Override
	public int selectCount(PaginationInfoVO<BoardVO> pagingVO) {
		return boardMapper.selectCount(pagingVO);
	}

	//목록 
	@Override
	public List<BoardVO> boardList(PaginationInfoVO<BoardVO> pagingVO) {
		return boardMapper.boardList(pagingVO);
	}

	//수정
	@Override
	public int boardUpdate(BoardVO boardVO) {
		return boardMapper.boardUpdate(boardVO);
	}

	@Override
	public int deleteFileList(String fileIdentify) {
		return boardMapper.deleteFileList(fileIdentify);
	}

	@Override
	public int boardDelete(String boardNo) {
		return boardMapper.boardDelete(boardNo);
	}

	@Override
	public int commentInsert(CommentVO cmtVO) {
		return cmtMapper.commentInsert(cmtVO);
	}

	//댓글목록
	@Override
	public List<CommentVO> commentList(String boardNo) {
		return cmtMapper.commentList(boardNo);
	}

	@Override
	public int replyCommentInsert(CommentVO cmtVO) {
		return cmtMapper.replyCommentInsert(cmtVO);
	}

	@Override
	public int commentDelete(String commentNo, String commentNos) {
		return cmtMapper.commentDelete(commentNo,commentNos);
	}

	@Override
	public CommentVO commentSelect(String commentNo,String commentNos) {
		return cmtMapper.commentSelect(commentNo,commentNos);
	}

	@Override
	public int commentUpdate(CommentVO cmtVO) {
		return cmtMapper.commentUpdate(cmtVO);
	}

	@Override
	public int subCmtDelete(String commentNo, String commentNos) {
		return cmtMapper.subCmtDelete(commentNo, commentNos);
	}

}
