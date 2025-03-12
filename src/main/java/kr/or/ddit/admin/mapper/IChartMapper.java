package kr.or.ddit.admin.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IChartMapper {

	public Map<String, Object> getLateData();

	public Map<String, Object> getEmplCountData();

	public Map<String, Object> getDeptSalary();

	public Map<String, Object> getRecruitCount();
	
	public Map<String, Object> getAppCount();

	public Map<String, Object> getVacationData();

	public Map<String, Object> getYearsOfService();

	public Map<String, Object> getVaction();

}
