package kr.or.ddit.sanction.service;

import java.util.List;

import kr.or.ddit.sanction.vo.TreeNodeVO;

public interface IOrganizationService {

	public List<TreeNodeVO> getOrganizationTree();
	
}
