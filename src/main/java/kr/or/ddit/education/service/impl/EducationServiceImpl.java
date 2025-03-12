package kr.or.ddit.education.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.education.mapper.IEducationMapper;
import kr.or.ddit.education.service.IEducationService;
import kr.or.ddit.education.vo.BookVO;
import kr.or.ddit.education.vo.CurriculumVO;
import kr.or.ddit.education.vo.EdcRequestVO;
import kr.or.ddit.education.vo.EducationVO;
import kr.or.ddit.education.vo.EmpEdcVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EducationServiceImpl implements IEducationService {

	@Autowired
	private IEducationMapper eduMapper;

	@Override
    public int insertBook(BookVO bookVO) {
        return eduMapper.insertBook(bookVO);
	}

	/* 유저 - 나의 교육 조회*/
	@Override
	public int selectEducationListCount(EducationVO educationVO) {
		return eduMapper.selectEducationListCount(educationVO);
	}
	@Override
	public List<EducationVO> selectEducationList(PaginationInfoVO<EducationVO> pageVO, EducationVO educationVO) {
		return eduMapper.selectEducationList(pageVO, educationVO);
	}
	


	/* 교육 Detail 조회 */
	@Override
	public EducationVO getEducationDetail(int edcNo) {
		return eduMapper.getEducationDetail(edcNo);
	}
	@Override
	public List<CurriculumVO> getCurriculumByEdcNo(int edcNo) {
		return eduMapper.getCurriculumByEdcNo(edcNo);
	} 
	@Override
	public List<BookVO> getBooksByEdcNo(int edcNo) {
		return eduMapper.getBooksByEdcNo(edcNo);
	}

	/* 관리자 교육 Detail 조회 */
	@Override
	public EducationVO getEducationAdminDetail(int edcNo) {
		return eduMapper.getEducationAdminDetail(edcNo);
	}
	@Override
	public List<CurriculumVO> getCurriculumAdminByEdcNo(int edcNo) {
		return eduMapper.getCurriculumAdminByEdcNo(edcNo);
	}
	@Override
	public List<BookVO> getBooksAdminByEdcNo(int edcNo) {
		return eduMapper.getBooksAdminByEdcNo(edcNo);
	}
	
	/* 나의 교육 조회 */
	@Override
	public EducationVO getEducationMyLectureDetail(int edcNo) {
		return eduMapper.getEducationMyLectureDetail(edcNo);
	}
	@Override
	public List<CurriculumVO> getCurriculumMyLectureByEdcNo(int edcNo) {
		return eduMapper.getCurriculumMyLectureByEdcNo(edcNo);
	}
	@Override
	public List<BookVO> getBooksMyLectureByEdcNo(int edcNo) {
		return eduMapper.getBooksMyLectureByEdcNo(edcNo);
	}
	
	
	
	/* -------------------------------------------------------------------- */
	/* 유저 - 나의 진행중인 교육 목록*/
	@Override
	public int selectEducationMyListCount(EducationVO educationVO) {
		return eduMapper.selectEducationMyListCount(educationVO);
	}

	@Override
	public List<EducationVO> selectEducationMyList(PaginationInfoVO<EducationVO> pageVO, EducationVO educationVO) {
		log.info("Service - selectEducationMyList: emplNo = {}", educationVO.getEmplNo(),"-----------------------------------------------------------------");
	    return eduMapper.selectEducationMyList(pageVO, educationVO, educationVO.getEmplNo());
	}

	
	/* 유저 - 나의 교육전체기록 조회*/
	@Override
	public int selectEducationMyHistoryListCount(EducationVO educationVO) {
		return eduMapper.selectEducationMyHistoryListCount(educationVO);
	}

	@Override
	public List<EducationVO> selectEducationMyHistoryList(PaginationInfoVO<EducationVO> pageVO, EducationVO educationVO) {
		log.info("Service - selectEducationMyHistoryList: emplNo = {}", educationVO.getEmplNo(),"-----------------------------------------------------------------");
	    return eduMapper.selectEducationMyHistoryList(pageVO, educationVO, educationVO.getEmplNo());
	}
	
	
	@Override
	public int selectEduApplicationListCount(EducationVO educationVO) {
		return eduMapper.selectEduApplicationListCount(educationVO);
	}

	@Override
	public List<EducationVO> selectEduApplicationList(String emplNo, PaginationInfoVO<EducationVO> pageVO, EducationVO educationVO) {
	    log.info("Service - selectEduApplicationList: emplNo = {}", emplNo);
	    educationVO.setEmplNo(emplNo); // ✅ emplNo를 EducationVO에 직접 세팅!
	    return eduMapper.selectEduApplicationList(emplNo, pageVO, educationVO);
	}

	/* ADMIN - 신규 교육 생성*/
	@Override
	public List<BookVO> getAllBooks() {
		return eduMapper.selectAllBooks();
	}

	@Override
	public List<EducationVO> getAllSort() {
		return eduMapper.selectAllSort();
	}

	@Override
	public List<EducationVO> getAllTarget() {
		return eduMapper.selectAllTarget();
	}

	@Override
	public List<EducationVO> getAllGrade() {
		return eduMapper.selectAllGrade();
	}
	
	@Override
	public List<CurriculumVO> getCurList() {
		return eduMapper.selectAllCur();
	}

	@Override
	public int insertEdcReqeust(EdcRequestVO edcRequestVO) {
	    if (edcRequestVO.getEdcAplc() == null || edcRequestVO.getEdcAplc().isEmpty()) {
	        throw new IllegalArgumentException("수강 신청자는 필수 입력값입니다.");
	    }
	    return eduMapper.insertEdcReqeust(edcRequestVO);
	}

	/* 관리자 - 교육신청 수락, 반려 버튼 */
	@Override
	public int updateEdcRequestStatus(EdcRequestVO edcRequestVO) {
		return eduMapper.updateEdcRequestStatus(edcRequestVO);
	}
	
	/* 관리자 - 교육신청 수락, 반려 버튼 */
	@Override
	public EdcRequestVO getEdcRequestByAplcAndEdcNo(String edcAplc, int edcNo) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("edcAplc", edcAplc);
	    params.put("edcNo", edcNo);
	    return eduMapper.getEdcRequestByAplcAndEdcNo(params);
	}
	/* 관리자 - 교육신청 수락, 반려 버튼 */
	@Override
	public int insertEmpEdc(EmpEdcVO empEdcVO) {
		return eduMapper.insertEmpEdc(empEdcVO);
	}


	/* 관리자 - 교육 삭제 버튼 */
	@Override
	public int deactivateEducation(int edcNo) {
		return eduMapper.deactivateEducation(edcNo);
	}

	/* 관리자 - 커리큘럼 추가 버튼 */
	@Override
	public int insertCurriculum(List<CurriculumVO> curriculumList) {
	    int insertedCount = 0;
	    int curNo = eduMapper.selectCurNo();
	    for (CurriculumVO curVO : curriculumList) {
	    	curVO.setCurNo(curNo);
	        insertedCount += eduMapper.insertCurriculum(curVO);
	    }
	    return insertedCount;
	}

	@Override
	public int insertEducationWithCurriculum(EducationVO educationVO) {
		return eduMapper.insertEducationWithCurriculum(educationVO);
	}

	/* 관리자 상세 페이지 수정하기 */ 
    /* 관리자 - 교육상세정보 수정 */
	@Override
	public int updateEducation(EducationVO educationVO) {
	    return eduMapper.updateEducation(educationVO);
	}
	
	/* 관리자 - 교육 내용 수정 */
	@Override
	public int updateContent(EducationVO educationVO) {
		return eduMapper.updateContent(educationVO);
	}
	
	/* 관리자 - 교육 책 수정 */
	@Override
	public int updateBook(EducationVO educationVO) {
		// TODO Auto-generated method stub
		return eduMapper.updateBook(educationVO);
	}
	
	/* 관리자 - 교육 커리큘럼 수정 */
	@Override
	public int updateCurriculum(List<CurriculumVO> curriculumList) {
		int updatedCount = 0;

	    for (CurriculumVO curVO : curriculumList) {
	        if (curVO.getCurNo() == 0) {
	            eduMapper.insertCurriculum(curVO);
	        } else {
	            updatedCount += eduMapper.updateCurriculum(curVO);
	        }
	    }
	    return updatedCount;
	}

	/* 유저 - 교육 상태바 */
    @Override
    public int updateEducationProgress(int edcNo, String emplNo, int progress) {
        return eduMapper.updateEducationProgress(edcNo, emplNo, progress);
    }

    @Override
    public int getEducationProgress(int edcNo, String emplNo) {
        return eduMapper.getEducationProgress(edcNo, emplNo);
    }

    @Override
    public int getTotalCurriculumCount(int edcNo) {
        return eduMapper.getTotalCurriculumCount(edcNo);
    }

	@Override
	public int selectEducationListenerCount(int edcNo, EducationVO educationVO) {
		return eduMapper.selectEducationListenerCount(edcNo, educationVO);
	}

	@Override
	public List<EducationVO> selectEducationListenerList(int edcNo, PaginationInfoVO<EducationVO> pageVO, EducationVO educationVO) {
		return eduMapper.selectEducationListenerList(edcNo, pageVO, educationVO, educationVO.getEmplNo());
	}







}
