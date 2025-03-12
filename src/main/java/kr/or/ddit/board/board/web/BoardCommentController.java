package kr.or.ddit.board.board.web;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import kr.or.ddit.board.board.vo.CommentVO;

@Controller
@RequestMapping("/hrms/board")
public class BoardCommentController {

//	@PostMapping("/cmtInsert")
//	public ResponseEntity<String> commentInsert(
//			@RequestBody CommentVO commentVO, HttpSession session){
//		
//	}
}
