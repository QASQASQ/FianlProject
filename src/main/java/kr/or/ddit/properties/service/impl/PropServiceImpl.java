package kr.or.ddit.properties.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.cmm.vo.PaginationInfoVO;
import kr.or.ddit.education.vo.EducationVO;
import kr.or.ddit.properties.mapper.IPropMapper;
import kr.or.ddit.properties.service.IPropService;
import kr.or.ddit.properties.vo.EmpPropVO;
import kr.or.ddit.properties.vo.PropertiesSortVO;
import kr.or.ddit.properties.vo.PropertiesVO;
import kr.or.ddit.properties.vo.PropertyRequestVO;

@Service
public class PropServiceImpl implements IPropService {

	@Autowired
	private IPropMapper propMapper;
	
	// 대여가능한 물품조회 페이지 - 물건 대여신청
	@Override
	public boolean rentItem(EmpPropVO rentalRequest) {
	    int result = propMapper.insertRental(rentalRequest);
	    if (result > 0) {
	        int updateResult = propMapper.decreasePropQty(rentalRequest.getPropNo());
	        return updateResult > 0;
	    }
	    return false;
	}
	
	// 대여가능한 물품조회 페이지 - 대여 상태 조회
	@Override
	public boolean isPropertyRented(String emplNo, int propNo) {
		Integer count = propMapper.checkRentalStatus(emplNo, propNo);
	    return count != null && count > 0; 
	}
	
	// 개인 대여 물품확인 페이지
	@Override
	public List<Map<String, Object>> userRentalAll(String emplNo) {
		List<Map<String, Object>> rentalResult = propMapper.userRentalAll(emplNo);
	    return rentalResult;
	}

	// 개인 대여 물품확인 페이지 - 반납기능
	@Override
	public boolean updateReturnDate(int propNo) {
		int updatedRows = propMapper.updateReturnDate(propNo);
        return updatedRows > 0; 
	}
	
	@Override
	public void increaseProp(int propNo) {
		 int updatedRows = propMapper.updateRentalReturnDate(propNo);
	     return;
	}
	
	// 사원들에게 제공하는 물품리스트 관리 페이지
	@Override
	public List<PropertiesVO> findAll() {
	    List<PropertiesVO> result = propMapper.findAllWithSort();
	    for (PropertiesVO prop : result) {
	        if (prop.getPropertiesSort() == null) {
	            prop.setPropertiesSort(new PropertiesSortVO());
	        }
	    }
	    return result;
	}
	
	// 사원들에게 제공하는 물품리스트 관리 페이지 - 물품 저장기능
	@Override
	public void saveProp(PropertyRequestVO request) {
		if (request != null) {
	        PropertiesVO property = new PropertiesVO();
	        property.setPropNo(request.getPropNo());
	        property.setPsCode(request.getPsCode());
	        property.setPropName(request.getPropName());
	        property.setPropContent(request.getPropContent());
	        property.setPropQty(request.getPropQty());
	        property.setFileIdentify(request.getFileIdentify());
	        propMapper.insertProperty(property);
		}
	}

	// 사원들에게 제공하는 물품리스트 관리 페이지 - 물품코드 저장기능
	@Override
	public void savePropCode(PropertyRequestVO request) {
		if (request != null) {
			PropertiesSortVO propertySort = new PropertiesSortVO();
			propertySort.setPsCode(request.getPsCode());
			propertySort.setPsLarge(request.getPsLarge());
			propertySort.setPsSmall(request.getPsSmall());
	        propMapper.insertPropertySort(propertySort);
		}
	}

	// 사원들에게 제공하는 물품리스트 관리 페이지 -  물품 분류코드 리스트 가져오기
	@Override
	public List<PropertiesSortVO> getPropertyCodes() {
		return propMapper.getPropertyCodes();
	}

	// 사원들에게 제공하는 물품리스트 관리 페이지 -  개별 물품 데이터 가져오기 (수정용)
	@Override
	public PropertiesVO getPropertyById(int propNo) {
	    return propMapper.getPropertyById(propNo);
	}

	// 사원들에게 제공하는 물품리스트 관리 페이지 -  개별 물품 삭제하기
	@Override
	public boolean deleteProperty(int propNo) {
	    int affectedRows = propMapper.deleteProperty(propNo);
	    return affectedRows > 0; 
	}

	// 사원들에게 제공하는 물품리스트 관리 페이지 -  개별 물품 데이터 수정 후 저장
	@Override
	public boolean updateProperty(PropertiesVO updatedProp) {
	    if (updatedProp.getPsCode() == null || updatedProp.getPsCode().isEmpty()) {
	        PropertiesVO existingProp = propMapper.getPropertyById(updatedProp.getPropNo());
	        updatedProp.setPsCode(existingProp.getPsCode()); 
	    }
	    int result = propMapper.updateProperty(updatedProp);
	    return result > 0;  
	}

	// getPropAllList
	@Override
	public int selectPropListCount(PropertiesVO propVO) {
		return propMapper.selectPropListCount(propVO);
	} 
	
	// getPropAllList
	@Override
	public List<PropertiesVO> selectPropList(PaginationInfoVO<PropertiesVO> pageVO, PropertiesVO propVO){
		return propMapper.selectPropList(pageVO, propVO);
	}


}

