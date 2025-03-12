package kr.or.ddit.properties.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.properties.vo.EmpPropVO;
import kr.or.ddit.properties.vo.PropertiesSortVO;
import kr.or.ddit.properties.vo.PropertiesVO;
import kr.or.ddit.properties.vo.PropertyRequestVO;

@Mapper
public interface IPropMapper {

	// 대여가능한 물품조회 페이지 - 물건 대여신청
	public int insertRental(EmpPropVO rentalRequest); 
	public int decreasePropQty(Integer propNo);    
	
	// 대여가능한 물품조회 페이지 - 대여 상태 조회
	public Integer checkRentalStatus(@Param("emplNo")String emplNo, @Param("propNo") int propNo);
	
	// 개인 대여 물품확인 페이지
	public List<Map<String, Object>> userRentalAll(String emplNo);
	
	// 개인 대여 물품확인 페이지 - 반납기능
	public int updateReturnDate(int propNo);
	public int updateRentalReturnDate(int propNo);
	
	// 사원들에게 제공하는 물품리스트 관리 페이지
	public List<PropertiesVO> findAllWithSort();
	
	// 사원들에게 제공하는 물품리스트 관리 페이지 - 물품 저장기능
	public void insertProperty(PropertiesVO property);
	
	// 사원들에게 제공하는 물품리스트 관리 페이지 - 물품코드 저장기능
	public void insertPropertySort(PropertiesSortVO property);
	
	/* 사원들에게 제공하는 물품리스트 관리 페이지 - 물품 분류코드 리스트 가져오기 */
	public List<PropertiesSortVO> getPropertyCodes();
	
	/* 사원들에게 제공하는 물품리스트 관리 페이지 - 개별 물품 데이터 수정 후 저장 */
	public PropertiesVO getPropertyById(int propNo);

	/* 사원들에게 제공하는 물품리스트 관리 페이지 - 개별 물품 삭제하기 */
	public int deleteProperty(int propNo);
	
	/* 사원들에게 제공하는 물품리스트 관리 페이지 - 개별 물품 데이터 수정 후 저장 */
	public int updateProperty(PropertiesVO updatedProp);	
	
	// getPropAllList
	public int selectPropListCount(PropertiesVO propVO);
	
	// getPropAllList
	public List<PropertiesVO> selectPropList(@Param("page") PaginationInfoVO<PropertiesVO> pageVO, @Param("prop") PropertiesVO propVO);



}
