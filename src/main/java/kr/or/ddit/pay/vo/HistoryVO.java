package kr.or.ddit.pay.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class HistoryVO {
  private int hisNo;
  private String emplNo;
  private String hisType;
  private Date hisSdate;
  private Date hisEdate;
  private Date hisStime;
  private Date hisEtime;
  private Date hisApvDate;
  
}
