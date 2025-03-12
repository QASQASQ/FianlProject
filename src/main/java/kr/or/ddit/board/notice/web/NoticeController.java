package kr.or.ddit.board.notice.web;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import jakarta.servlet.http.HttpSession;
import kr.or.ddit.board.notice.service.impl.INoticeService;
import kr.or.ddit.board.notice.vo.NoticeVO;
import kr.or.ddit.cmm.service.IFileService;
import kr.or.ddit.cmm.utils.FileUploadUtils;
import kr.or.ddit.cmm.vo.DocFileVO;
import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.employee.vo.EmpAuthVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hrms/notice")
public class NoticeController {

	@Autowired
	private INoticeService noticeService;
	
	@Autowired
	private IFileService fileService;
	
	//목록
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@RequestMapping("/noticeList")
	public String noticeList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchWord,
			Model model) {
		//paginationInfoVO를 활용한 페이징 및 검색
		PaginationInfoVO<NoticeVO> pagingVO = new PaginationInfoVO<>();
		
		//검색 기능
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			
			//검색 후 목록페이지로 이동할 때 검색된 내용을 적용시키기 위한 데이터 전달
			model.addAttribute("searchWord", searchWord);
		}
		
		//현재 페이지 전달 후 start/endRow. start/endPage 설정
		pagingVO.setCurrentPage(currentPage);
		//모든 게시글 수 가져오기
		int totalRecord = noticeService.selectCount(searchWord);
		//총 게시글 수 저장, 총 페이지 수 설정
		pagingVO.setTotalRecord(totalRecord);
		
		
		
		List<NoticeVO> noticeList = noticeService.noticeList(pagingVO);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("paging", pagingVO);
		return "board/noticeList";
	}
	
	//등록화면 요청
	@PreAuthorize("hasAnyAuthority('ROLE_ADMIN')") //계정권한
	@GetMapping("/noticeForm")
	public String noticeForm() {
		return "board/noticeForm";
	}
	
	
	//등록기능
	@PreAuthorize("hasAnyAuthority('ROLE_ADMIN')") //계정권한
	@PostMapping("/noticeInsert")
	public String noticeInsert(NoticeVO noticeVO, Model model)  {
		String goPage = "";
		if(noticeVO.getFiles() != null && noticeVO.getFiles().size() > 0) {
			String seq = noticeService.selectSeq(); // 파일시퀀스 가져오기
			for(MultipartFile file : noticeVO.getFiles()) {
				try {
					String filePath = FileUploadUtils.uploadFile(file);
					fileService.insertFile(file, filePath, seq);
				} catch (Exception e) {
					e.printStackTrace();
				}
				noticeVO.setFileIdentify(seq);
			}
		}
		int result = noticeService.noticeInsert(noticeVO);
		if(result > 0) {
			goPage = "redirect:/hrms/notice/noticeDetail?noticeNo=" + noticeVO.getNoticeNo();
		}else {
			goPage = "hrms/notice/noticeForm";
		}
		return goPage;
		
	}
	
	//게시판 상세보기
	@PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/noticeDetail")
	public String noticeDetail(String noticeNo ,EmpAuthVO auth,HttpSession session, Model model) {
		NoticeVO noticeVO = noticeService.selectNotice(noticeNo);
		if(noticeVO.getFileIdentify() != null && noticeVO.getFileIdentify() != "") {
			List<DocFileVO> fileList = fileService.selectFileList(noticeVO.getFileIdentify());
			model.addAttribute("fileList", fileList);
		}
		model.addAttribute("notice", noticeVO);
		session.setAttribute("userAuth", auth.getAuthCode());
		return "board/noticeDetail";
	}
	
	//수정 페이지
	@PreAuthorize("hasAnyAuthority('ROLE_ADMIN')") //계정권한
	@GetMapping("/noticeUpdateForm")
	public String noticeUpdateForm(String noticeNo, Model model) {
		NoticeVO noticeVO = noticeService.selectNotice(noticeNo);
		if(noticeVO.getFileIdentify() != null && noticeVO.getFileIdentify() != "") {
			List<DocFileVO> fileList = fileService.selectFileList(noticeVO.getFileIdentify());
			model.addAttribute("fileList", fileList);
		}
		model.addAttribute("notice", noticeVO);
		model.addAttribute("status", "u");
		return "board/noticeForm";
	}
	
	//수정기능
	@PreAuthorize("hasAnyAuthority('ROLE_ADMIN')") //계정권한
	@PostMapping("/noticeUpdate")
	public String noticeUpdate(NoticeVO noticeVO) {
		String goPage = "";
		
		
		int result = noticeService.noticeUpdate(noticeVO);
		if(result > 0) {
			goPage = "redirect:/hrms/notice/noticeDetail?noticeNo=" + noticeVO.getNoticeNo();
		}else {
			goPage = "hrms/notice/noticeUpdateForm";
		}
		return goPage;
	}
	
	//삭제기능
	@PreAuthorize("hasAnyAuthority('ROLE_ADMIN')") //계정권한
	@PostMapping("/noticeDelete")
	public String noticeDelete(String noticeNo) {
		String goPage = "";
		NoticeVO noticeVO = noticeService.selectNotice(noticeNo); // 게시글 번호에 해당하는 게시글 정보 가져오기
		
		if(noticeVO.getFileIdentify() != null && noticeVO.getFileIdentify() != "") { //파일이 존재하면 파일도 삭제
			int fileList = noticeService.deleteFileList(noticeVO.getFileIdentify());
		}
		int result = noticeService.noticeDelete(noticeNo);
		if(result > 0) {
			goPage = "redirect:/hrms/notice/noticeList";
		}else {
			goPage = "redirect:/hrms/notice/noticeDetail?noticeNo=" + noticeNo;
		}
		return goPage;
	}
	
	//유튜브 보이게 하는 업로드
//	@RequestMapping("/imgUpload")
//	public String imgUpload() {
//		JsonObject json = new JsonObject();		// JSON 객체를 만들기 위한 준비
//		PrintWriter printWriter = null;			// 외부 응답으로 내보낼 때 사용할 객체
//		OutputStream out = null;				// 본문내용에 추가한 이미지를 파일로 생성할 객체
//		long limitSize = 1024*1024*2;			// 업로드 파일 최대 크기 (2MB)
//	}


}
