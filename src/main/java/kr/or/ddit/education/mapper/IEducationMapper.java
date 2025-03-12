package kr.or.ddit.education.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.education.vo.BookVO;
import kr.or.ddit.education.vo.CurriculumVO;
import kr.or.ddit.education.vo.EdcRequestVO;
import kr.or.ddit.education.vo.EducationVO;
import kr.or.ddit.education.vo.EmpEdcVO;

@Mapper
public interface IEducationMapper {

	public int insertBook(BookVO book);

	/* 유저 - 나의 교육 조회*/
	public int selectEducationListCount(EducationVO educationVO);
	public List<EducationVO> selectEducationList(@Param("page") PaginationInfoVO<EducationVO> paginationInfoVO, @Param("education") EducationVO educationVO );



	
	/* 교육 Detail 조회 */
	public EducationVO getEducationDetail(@Param("edcNo") int edcNo);
	public List<CurriculumVO> getCurriculumByEdcNo(@Param("edcNo") int edcNo);
	public List<BookVO> getBooksByEdcNo(@Param("edcNo") int edcNo);

	/* 관리자 - 교육 Detail 조회 */
	public EducationVO getEducationAdminDetail(@Param("edcNo") int edcNo);
	public List<CurriculumVO> getCurriculumAdminByEdcNo(@Param("edcNo") int edcNo);
	public List<BookVO> getBooksAdminByEdcNo(@Param("edcNo") int edcNo);
	
	/* 나의 교육 내용 조회 */
	public EducationVO getEducationMyLectureDetail(int edcNo);
	public List<CurriculumVO> getCurriculumMyLectureByEdcNo(int edcNo);
	public List<BookVO> getBooksMyLectureByEdcNo(int edcNo);

	/* 유저 - 나의 진행중인 교육 목록*/
	public int selectEducationMyListCount(EducationVO educationVO);
	public List<EducationVO> selectEducationMyList(@Param("page")PaginationInfoVO<EducationVO> pageVO, @Param("education") EducationVO educationVO, String emplNo);

	/* 유저 - 나의 교육전체기록 조회*/
	public int selectEducationMyHistoryListCount(EducationVO educationVO);
	public List<EducationVO> selectEducationMyHistoryList(@Param("page")PaginationInfoVO<EducationVO> pageVO, @Param("education")EducationVO educationVO, String emplNo);

	
	
	/* ADMIN - 교육신청자 조회 */
	public int selectEduApplicationListCount(EducationVO educationVO);
	public List<EducationVO> selectEduApplicationList(@Param("emplNo")String emplNo, @Param("page")PaginationInfoVO<EducationVO> pageVO, @Param("education") EducationVO educationVO);

	/* ADMIN - 신규 교육 생성*/
	public List<BookVO> selectAllBooks();
	public List<EducationVO> selectAllSort();
	public List<EducationVO> selectAllTarget();
	public List<EducationVO> selectAllGrade();
	public List<CurriculumVO> selectAllCur();

	public int insertEdcReqeust(EdcRequestVO edcRequestVO);

	/* 관리자 - 교육신청 수락, 반려 버튼 */
	public int updateEdcRequestStatus(EdcRequestVO edcRequestVO);
	public EdcRequestVO getEdcRequestByAplcAndEdcNo(Map<String, Object> params);
	public int insertEmpEdc(EmpEdcVO empEdcVO);
	
	/* 관리자 - 교육 삭제 버튼 */
	public int deactivateEducation(int edcNo);

	/* 관리자 - 커리큘럼 추가 버튼 */
	public int insertCurriculum(CurriculumVO curVO);

	public int insertEducationWithCurriculum(EducationVO educationVO);

	public int selectCurNo();

	/* 관리자 - 교육상세정보 수정 */
	public int updateEducation(EducationVO educationVO);
	/* 관리자 - 교육 내용 수정 */
	public int updateContent(EducationVO educationVO);
	/* 관리자 - 교육 책 수정 */
	public int updateBook(EducationVO educationVO);
	/* 관리자 - 교육 커리큘럼 수정 */
	public int updateCurriculum(CurriculumVO curVO);

	/* 유저 - 교육 상태바 */
	public int updateEducationProgress(@Param("edcNo") int edcNo, @Param("emplNo") String emplNo, @Param("progress") int progress);

	public int getEducationProgress(@Param("edcNo")int edcNo,  @Param("emplNo")String emplNo);

	public int getTotalCurriculumCount(@Param("edcNo")int edcNo);

	public int selectEducationListenerCount(@Param("edcNo")int edcNo, EducationVO educationVO);

	public List<EducationVO> selectEducationListenerList(@Param("edcNo")int edcNo, @Param("page")PaginationInfoVO<EducationVO> pageVO, @Param("education")EducationVO educationVO,
			String emplNo);





	




}
