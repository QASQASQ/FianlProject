package kr.or.ddit.cmm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.cmm.vo.DocFileVO;

@Mapper
public interface IFileMapper {

	public int insertFile(DocFileVO fileVO);

	public String selectFileSeq();

	public List<DocFileVO> selectFileList(String fileIdentify);

	public DocFileVO selectFileOne(DocFileVO fileVO);


}
