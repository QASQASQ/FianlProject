package kr.or.ddit.properties.vo;

import lombok.Data;

@Data
public class PropertyRequestVO {
    
	private int propNo;
    private String psCode;
    private String propName;
    private String propContent;
    private int propQty;
    private String fileIdentify;


    private String psLarge;
    private String psSmall;

    // Getters and Setters
    public int getPropNo() { return propNo; }
    public void setPropNo(int propNo) { this.propNo = propNo; }

    public String getPsCode() { return psCode; }
    public void setPsCode(String psCode) { this.psCode = psCode; }

    public String getPropName() { return propName; }
    public void setPropName(String propName) { this.propName = propName; }

    public String getPropContent() { return propContent; }
    public void setPropContent(String propContent) { this.propContent = propContent; }

    public int getPropQty() { return propQty; }
    public void setPropQty(int propQty) { this.propQty = propQty; }

    public String getFileIdentify() { return fileIdentify; }
    public void setFileIdentify(String fileIdentify) { this.fileIdentify = fileIdentify; }

    public String getPsLarge() { return psLarge; }
    public void setPsLarge(String psLarge) { this.psLarge = psLarge; }

    public String getPsSmall() { return psSmall; }
    public void setPsSmall(String psSmall) { this.psSmall = psSmall; }
}
