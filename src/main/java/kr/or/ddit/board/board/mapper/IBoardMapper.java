package kr.or.ddit.board.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.board.vo.BoardVO;
import kr.or.ddit.board.board.vo.CommentVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;

@Mapper
public interface IBoardMapper {

	public String selectSeq();

	public int boardInsert(BoardVO boardVO);

	public void incrementHit(String boardNo);

	public BoardVO selectBoard(String boardNo);

	public int selectCount(PaginationInfoVO<BoardVO> pagingVO);

	public List<BoardVO> boardList(PaginationInfoVO<BoardVO> pagingVO);

	public int boardUpdate(BoardVO boardVO);

	public int deleteFileList(String fileIdentify);

	public int boardDelete(String boardNo);

	public int commentInsert(CommentVO cmtVO);

}
