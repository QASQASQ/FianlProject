package kr.or.ddit.cmm.utils;

import java.io.FileInputStream;
import java.io.InputStream;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import kr.or.ddit.cmm.vo.DocFileVO;

public class FileDownladUtils {

	public static ResponseEntity<byte[]> downloadFile(DocFileVO fileVO) {
		
		ResponseEntity<byte[]> entity = null;
		InputStream in = null;
		String filePath = fileVO.getFilePath();
		String fileName = filePath.substring(filePath.lastIndexOf("/") + 1);
		HttpHeaders headers = new HttpHeaders();
		try {
			in = new FileInputStream(fileVO.getFilePath());
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.add("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST); // 에러뜨면 bad_request
		} finally {
			try {
				in.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return entity;
	}
}
