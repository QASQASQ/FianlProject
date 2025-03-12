package kr.or.ddit.board.board.service;

import java.util.List;

import kr.or.ddit.board.board.vo.BoardVO;
import kr.or.ddit.board.board.vo.CommentVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;

public interface IBoardService {

	public String selectSeq();

	public int boardInsert(BoardVO boardVO);

	public BoardVO selectBoard(String boardNo);

	public int selectCount(PaginationInfoVO<BoardVO> pagingVO);

	public List<BoardVO> boardList(PaginationInfoVO<BoardVO> pagingVO);

	public int boardUpdate(BoardVO boardVO);

	public int deleteFileList(String fileIdentify);

	public int boardDelete(String boardNo);

	//댓글등록
	public int commentInsert(CommentVO cmtVO);

	//댓글 목록
	public List<CommentVO> commentList(String boardNo);

	//대댓글 등록
	public int replyCommentInsert(CommentVO cmtVO);

	//댓글삭제 
	public int commentDelete(String commentNo, String commentNos);

	public CommentVO commentSelect(String commentNo,String commentNos);

	public int commentUpdate(CommentVO cmtVO);

	public int subCmtDelete(String commentNo, String commentNos);

}
