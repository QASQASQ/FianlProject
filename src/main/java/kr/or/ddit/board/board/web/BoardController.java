package kr.or.ddit.board.board.web;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import kr.or.ddit.board.board.service.IBoardService;
import kr.or.ddit.board.board.vo.BoardVO;
import kr.or.ddit.board.board.vo.CommentVO;
import kr.or.ddit.cmm.service.IFileService;
import kr.or.ddit.cmm.utils.FileUploadUtils;
import kr.or.ddit.cmm.vo.DocFileVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hrms/board")
public class BoardController {
	
	@Autowired
	private IFileService fileService;
	
	@Autowired
	private IBoardService boardService;
	
	//목록
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@RequestMapping("/boardList")
	public String boardList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model) {
		
		//PaginationInfoVO를 활용한 페이징 및 검색
		PaginationInfoVO<BoardVO> pagingVO = new PaginationInfoVO<>();
		
		//검색진행
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			
			//검색 후 목록페이지로 이동할 때 검색된 내용을 적용시키기 위한 데이터 전달
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		//현재페이지 전달 후 start/endRow, start/endPage 설정
		pagingVO.setCurrentPage(currentPage);
		//board 테이블에 존재하는 모든 게시글 수를 가져온다.(totalRecord)
		int totalRecord = boardService.selectCount(pagingVO);
		//총 게시글 수 저장 및 총 페이지 수 설정
		pagingVO.setTotalRecord(totalRecord);
		List<BoardVO> boardList = boardService.boardList(pagingVO);
		model.addAttribute("boardList", boardList);
		model.addAttribute("paging", pagingVO);
		return "board/boardList";
		
	}

	//등록화면 요청
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/boardForm")
	public String boardForm() {
		return "board/boardForm";
	}
	
	//등록기능
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@PostMapping("/boardInsert")
	public String boardInsert(BoardVO boardVO, Model model) {
		String goPage = "";
		//익명여부 확인
		if(boardVO.getBoardAnon().equals("Y")) {
			boardVO.setBoardAnon("Y");
		}else {
			boardVO.setBoardAnon("N");
		}
		if(boardVO.getFiles() != null && boardVO.getFiles().size() > 0) {
			String seq = boardService.selectSeq();
			for(MultipartFile file : boardVO.getFiles()) {
				try {
					String filePath = FileUploadUtils.uploadFile(file);
					fileService.insertFile(file, filePath, seq);
				} catch (Exception e) {
					e.printStackTrace();
				}
				boardVO.setFileIdentify(seq);
			}
		}
		int result = boardService.boardInsert(boardVO);
		if(result > 0) {
			 goPage = "redirect:/hrms/board/boardDetail?boardNo=" + boardVO.getBoardNo();
		}else {
			goPage = "hrms/board/boardForm";
		}
		return goPage;
	}
	
	//게시판 상세보기, 댓글목록
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/boardDetail")
	public String boardDetail(String boardNo, Model model) {
		BoardVO boardVO = boardService.selectBoard(boardNo);
		if(boardVO.getFileIdentify() != null && boardVO.getFileIdentify() != "") {
			List<DocFileVO> fileList = fileService.selectFileList(boardVO.getFileIdentify());
			model.addAttribute("fileList", fileList);
		}
		model.addAttribute("board", boardVO);
		
		//댓글목록 가져오기
		List<CommentVO> commentList = boardService.commentList(boardNo);
		model.addAttribute("commentList", commentList);
		return "board/boardDetail";
	}
	
	//수정페이지
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/boardUpdateForm")
	public String boardUpdateForm(String boardNo, Model model) {
		BoardVO boardVO = boardService.selectBoard(boardNo);
		if(boardVO.getFileIdentify() != null && boardVO.getFileIdentify() != "") {
			List<DocFileVO> fileList = fileService.selectFileList(boardVO.getFileIdentify());
			model.addAttribute("fileList", fileList);
		}
		model.addAttribute("board", boardVO);
		model.addAttribute("status", "u");
		return "board/boardForm";
	}
	
	//수정기능
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@PostMapping("boardUpdate")
	public String boardUpdate(BoardVO boardVO, Model model) {
		String goPage = "";
		
		int result = boardService.boardUpdate(boardVO);
		if(result > 0) {
			goPage = "redirect:/hrms/board/boardDetail?boardNo=" + boardVO.getBoardNo();
		}else {
			goPage = "/hrms/board/boardUpdateForm";
		}
		return goPage;
	}
	
	//삭제기능
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@PostMapping("/boardDelete")
	public String boardDelete(String boardNo, Model model) {
		String goPage = "";
		BoardVO boardVO = boardService.selectBoard(boardNo);
		
		if(boardVO.getFileIdentify() != null && boardVO.getFileIdentify() != "") {
			int fileList = boardService.deleteFileList(boardVO.getFileIdentify());
		}
		int result = boardService.boardDelete(boardNo);
		if(result > 0) {
			goPage = "redirect:/hrms/board/boardList";
		}else {
			goPage = "hrms/board/boardDetail?boardNo=" + boardVO.getBoardNo();
		}
		return goPage;
	}
	
	////////////////////////////////////////////////////////댓글영역
	
	//댓글등록
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@PostMapping("/commentInsert")
	public String commentInsert(CommentVO cmtVO, RedirectAttributes ra) {
		
		if(cmtVO.getCommentAnon().equals("Y")) {
			cmtVO.setCommentAnon("Y");
		}else {
			cmtVO.setCommentAnon("N");
		}
		
			int result = boardService.commentInsert(cmtVO);
		
		if(result > 0) {
			ra.addFlashAttribute("msg", "댓글이 등록되었습니다.");
		}else {
			ra.addFlashAttribute("msg", "댓글 등록 실패");
		}
		return "redirect:/hrms/board/boardDetail?boardNo=" + cmtVO.getBoardNo();
	}
	
	//대댓글 등록
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@PostMapping("/replyCommentInsert")
	public String replyCommentInsert(CommentVO cmtVO, RedirectAttributes ra) {
		
		if(cmtVO.getCommentAnon().equals("Y")) {
			cmtVO.setCommentAnon("Y");
		}else {
			cmtVO.setCommentAnon("N");
		}
		
		int result = boardService.replyCommentInsert(cmtVO);
		
		if(result > 0) {
			ra.addFlashAttribute("msg", "댓글이 등록되었습니다.");
		}else {
			ra.addFlashAttribute("msg", "댓글 등록 실패");
		}
		return "redirect:/hrms/board/boardDetail?boardNo=" + cmtVO.getBoardNo();
		
	}
	
	//댓글 삭제
	@PostMapping("/commentDelete")
	public String commentDelete(String commentNo,String commentNos, Model model) {
		String goPage = "";
		CommentVO cmtVO = boardService.commentSelect(commentNo,commentNos);
		
			int result = 0;
		
		if(cmtVO.getCommentNos() != "1") {
			result = boardService.subCmtDelete(commentNo,commentNos);
		}else {
			result = boardService.commentDelete(commentNo,commentNos);
		}
		
		
		if(result > 0 ) {
			goPage = "redirect:/hrms/board/boardDetail?boardNo=" + cmtVO.getBoardNo();
		}else {
			goPage = "hrms/board/boardDetail?boardNo=" + cmtVO.getBoardNo();
		}
		return goPage;
	}
	//댓글 수정
	@PostMapping("/commentUpdate")
	public String commentUpdate(@RequestBody CommentVO cmtVO ){
		String goPage = "";
		
		int result = boardService.commentUpdate(cmtVO);
		
		if(result > 0) {
			goPage = "redirect:/hrms/board/boardDetail?boardNo=" + cmtVO.getBoardNo();
		}else {
			goPage = "hrms/board/boardDetail?boardNo=" + cmtVO.getBoardNo();
		}
		return goPage;
	}
	
	
}
