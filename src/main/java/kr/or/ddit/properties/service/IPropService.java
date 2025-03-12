package kr.or.ddit.properties.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.properties.vo.EmpPropVO;
import kr.or.ddit.properties.vo.PropertiesSortVO;
import kr.or.ddit.properties.vo.PropertiesVO;
import kr.or.ddit.properties.vo.PropertyRequestVO;

public interface IPropService {
	
	// 대여가능한 물품조회 페이지 - 물건 대여신청
	public boolean rentItem(EmpPropVO rentalRequest);
		
	// 대여가능한 물품조회 페이지 - 대여 상태 조회
	public boolean isPropertyRented(String emplNo, int propNo);
		
	// 개인 대여 물품확인 페이지
	public List<Map<String, Object>> userRentalAll(String emplNo);
		
	// 개인 대여 물품확인 페이지 - 반납기능
	public boolean updateReturnDate(int propNo);	
	public void increaseProp(int propNo);
	
	// 사원들에게 제공하는 물품리스트 관리 페이지
	public List<PropertiesVO> findAll();
	
	// 사원들에게 제공하는 물품리스트 관리 페이지 - 물품 저장기능
	public void saveProp(PropertyRequestVO request);

	// 사원들에게 제공하는 물품리스트 관리 페이지 - 물품코드 저장기능
	public void savePropCode(PropertyRequestVO request);

	// 사원들에게 제공하는 물품리스트 관리 페이지 -  물품 분류코드 리스트 가져오기
	public List<PropertiesSortVO> getPropertyCodes();

	// 사원들에게 제공하는 물품리스트 관리 페이지 -  개별 물품 데이터 가져오기 (수정용)
	public PropertiesVO getPropertyById(int propNo);
	
	// 사원들에게 제공하는 물품리스트 관리 페이지 -  개별 물품 삭제하기
	public boolean deleteProperty(int propNo);

	/* 사원들에게 제공하는 물품리스트 관리 페이지 - 개별 물품 데이터 수정 후 저장 */
	public boolean updateProperty(PropertiesVO updatedProp);

	/* getPropAllList */
	public List<PropertiesVO> selectPropList(PaginationInfoVO<PropertiesVO> pageVO, PropertiesVO propVO);

	/* getPropAllList */
	public int selectPropListCount(PropertiesVO propVO);



	


}
