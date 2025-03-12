package kr.or.ddit.cmm.utils;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;


// 파일을 업로드하는 컨트롤러에서 폴더에 파일을 넣는과정을 모둘화
@Slf4j
public class FileUploadUtils {

	private static final String UPLOADPATH = "C:/uploadHRMS";
	
	/**
	 * 
	 * @param file : MultipartFile 타입의 파일객체
	 * @return uploadedFileName : 업로드한 파일의 이름. EX) 2025/02/06/파일명.jpg
	 * @throws Exception
	 */
	public static String uploadFile(MultipartFile file) throws Exception {
		String originalFileName = file.getOriginalFilename();
		byte[] fileData = file.getBytes();
		// UUID_원본파일명을 만든다.
		UUID uuid = UUID.randomUUID();
		String savedName = uuid.toString() + "_" + originalFileName;
		
		// 2024/12/19 라는 폴더를 만들고, '2024/12/19'(오늘날짜) 폴더 경로를 리턴한다.
		String savedPath = calPath();
		
		// 배포된 서버 업로드 경로 + /2024/12/19/ + UUID_원본파일명으로 File target을 하나 만들어준다.
		File target = new File(UPLOADPATH + savedPath, savedName); // File객체안에 담아서 전달해주기위해 File객체를 생성(재사용을목적으로)
		FileCopyUtils.copy(fileData, target); // 파일복사 (fileData를 target에 복사한다.)
		
		// \2024\12\19 경로를 / 경로로 변경후 원본 파일명을 붙인다.
		String uploadedFileName = savedPath.replace(File.separatorChar, '/') + "/" + savedName;
		log.info("업로디드" + UPLOADPATH + uploadedFileName);
		
		return UPLOADPATH + uploadedFileName;
	}
	
	/**
	 * 
	 * @return datePath : 날짜형식으로 작성된 폴더경로
	 */
	// 현재 날짜를 기준으로 폴더를 생성하는 메소드
	private static String calPath() { // 날짜만들고 폴더만들기(makeDir()메소드로)
		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator + cal.get(Calendar.YEAR); // 2024
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1); // 2024/12
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE)); // 2024/12/19
		
		makeDir(UPLOADPATH, yearPath, monthPath, datePath);
		return datePath;
	}
	
	/**
	 * 
	 * @param paths : 여러개의 변수를 받기. 여기서는 C:/upload, 2025, 02, 06 이런식
	 */
	// 가변인자
	// [사용방법] 타입...변수명 형태로 사용
	// 순서대로 year,month,datePath변수가 배열로들어감
	private static void makeDir(String...paths) { //폴더만들기
		// 2024/12/19 폴더구조가 존재한다면  return
		// 만들려던 폴더구조가 이미 만들어져있는 형태니까 굳이 아래에서 만들필요가 없다
		if(new File(paths[paths.length - 1]).exists()) {
			return;
		}
		
		for(String path : paths) {
			File dirPath = new File(UPLOADPATH + path);
			
			// 2024/12/19와 같은 경로에 각 폴더가 없으면 각각 만들어준다.
			if(!dirPath.exists()) {
				dirPath.mkdirs();
			}
		}
	}
	



}
