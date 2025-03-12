package kr.or.ddit.cmm.service.impl;

import java.util.List;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.cmm.mapper.IFileMapper;
import kr.or.ddit.cmm.service.IFileService;
import kr.or.ddit.cmm.vo.DocFileVO;

@Service
public class FileServiceImpl implements IFileService{

	@Autowired
	IFileMapper mapper;
	
	/**
	 * 시퀀스를 가져오는 메소드
	 */
	@Override
	public String selectFileSeq() {
		return mapper.selectFileSeq();
	}
	
	/**
	 * 파일을 DB에 넣는 메소드
	 */
	@Override
	public int insertFile(MultipartFile file, String filePath, String seq) {
		DocFileVO fileVO = new DocFileVO();
		fileVO.setFileIdentify(seq);
		fileVO.setFileFancysize(FileUtils.byteCountToDisplaySize(file.getSize())); // 파일크기
		fileVO.setFileMime(file.getContentType()); // 파일마임타입
		fileVO.setFileName(file.getOriginalFilename()); // 파일이름
		fileVO.setFilePath(filePath); // 파일경로
		fileVO.setFileSize(file.getSize()); // 파일원본크기
		int result = mapper.insertFile(fileVO);
		return result;
	}

	/**
	 * 파일의 정보를 가져오는 메소드
	 * 파일식별번호와 파일순번을 기준으로 해당파일의 이름과같은 정보를 가져오기 위함
	 */
	@Override
	public DocFileVO selectFileOne(DocFileVO fileVO) {
		return mapper.selectFileOne(fileVO);
	}

	/**
	 * 파일의 식별번호를 기준으로 파일리스트 가져오는 메소드
	 */
	@Override
	public List<DocFileVO> selectFileList(String fileIdentify) {
		return mapper.selectFileList(fileIdentify);
	}


}
