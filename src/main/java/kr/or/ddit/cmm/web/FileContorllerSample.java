/*
package kr.or.ddit.cmm.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다.
이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 
이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 이 파일은 예시파일입니다. 

@Slf4j
@Controller
public class FileContorllerSample {

	@GetMapping("/fileM")
	public String goPage(Model model) {
		List<FileVO> fileList = service.selectFileList();
		model.addAttribute("fileList", fileList);
		return "practice/fileUpDown";
	}
	
	@Autowired
	IFileService service;
	
	@PostMapping("/register")
	public ResponseEntity<String> register(@RequestParam("files") List<MultipartFile> files){
		ResponseEntity<String> entity = null;
		String seq = service.selectFileSeq(); // 파일식별번호를위한 시퀀스 가져오기. 이건 반복문X
		for (MultipartFile file : files) {
	        try {
				String filePath = FileUploadUtils.uploadFile(file); // 파일 c드라이브에 저장하기
				int result = service.insertFile(file, filePath, seq); // 파일 DB에 인서트하기
				if(result > 0) {
					entity = new ResponseEntity<String>("파일업로드 성공", HttpStatus.OK);
				}else {
					entity = new ResponseEntity<String>("파일업로드 실패", HttpStatus.BAD_REQUEST);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return entity;
	}
	
	@ResponseBody
	@GetMapping("/downloadFile")
	public ResponseEntity<byte[]> fileDownload(String fileIdentify, String fileNo){
		FileVO fileVO = new FileVO();
		fileVO.setFileIdentify(fileIdentify);
		fileVO.setFileNo(fileNo); // 파일식별번호와 파일순번을 vo에 담는다
		fileVO = service.selectFileOne(fileVO); // 위에서 데이터를 담은 vo를 이용해서 파일의모든 정보를 가져온다.
		ResponseEntity<byte[]> entity = FileDownladUtils.downloadFile(fileVO); // 다운로드실행.
		return entity;
	}
	
}
*/
package kr.or.ddit.cmm.web;

