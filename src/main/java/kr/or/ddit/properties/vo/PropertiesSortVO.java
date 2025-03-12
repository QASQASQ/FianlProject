package kr.or.ddit.properties.vo;

import lombok.Data;

@Data
public class PropertiesSortVO {
	
	private String psCode;
	private String psLarge;
	private String psSmall;
	
	private PropertiesVO properties;
}
