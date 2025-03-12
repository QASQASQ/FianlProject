package kr.or.ddit.cmm.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.cmm.service.IFileService;
import kr.or.ddit.cmm.utils.FileDownladUtils;
import kr.or.ddit.cmm.vo.DocFileVO;

@Controller
public class FileDownloadController {
	
	@Autowired
	private IFileService fileService;

	@ResponseBody
	@GetMapping("/downloadFile")
	public ResponseEntity<byte[]> fileDownload(String fileIdentify, String fileNo){
		DocFileVO fileVO = new DocFileVO();
		int iFileNo = Integer.parseInt(fileNo);
		fileVO.setFileIdentify(fileIdentify);
		fileVO.setFileNo(iFileNo);
		fileVO = fileService.selectFileOne(fileVO);
		ResponseEntity<byte[]> entity = FileDownladUtils.downloadFile(fileVO);
		return entity;
	}
}
