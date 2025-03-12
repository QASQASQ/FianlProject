package kr.or.ddit.calendar.vo;


import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class CalendarVO {

	private int schNo;
	private String emplNo;
	private String groupId;
	private String schTitle;
	private String schSDate;
	private String schEDate;
	private String schColor;
	private String schTextColor;
	private boolean schAllDay; //하루종일 여부

	
	
}
