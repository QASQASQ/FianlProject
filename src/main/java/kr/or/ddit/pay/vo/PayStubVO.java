package kr.or.ddit.pay.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class PayStubVO {
  private int psNo;
  private String emplNo;
  private int totalPayment;
  private int totalDeduction;
  private int actualSalary;
  private int basicSalary;
  private int overtimePay;
  private int psBonus;
  private int mealPay;
  private int incomeTax;
  private int localTax;
  private int employmentInsurance;
  private int healthInsurance;
  private int nursingInsurance;
  private int nationalPension;
  private Date payDate;
}
