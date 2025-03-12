package kr.or.ddit.cmm.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.cmm.vo.DocFileVO;

public interface IFileService {

	public int insertFile(MultipartFile file, String filePath, String seq); // 파일 DB에 insert

	public String selectFileSeq(); // 파일 시퀀스 가져오기

//	public List<FileVO> selectFileList();

	public DocFileVO selectFileOne(DocFileVO fileVO); // 파일 정보 가져오기

	public List<DocFileVO> selectFileList(String fileIdentify);


}
