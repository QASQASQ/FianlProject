package kr.or.ddit.properties.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EmpPropVO {
	private int epNo;
	private String emplNo;
	private int propNo;
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date epSdate;
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date epEdate;
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date epRdate;
	
    private PropertiesVO properties;
}
