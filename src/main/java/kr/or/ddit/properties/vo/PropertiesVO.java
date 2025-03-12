package kr.or.ddit.properties.vo;

import java.util.Date;

import lombok.Data;

@Data
public class PropertiesVO {
    private int propNo;
    private String propName;
    private String propContent;
    private int propQty;
    private String fileIdentify;
    private String psCode;
    
    // PropertiesSortVO 포함
    private PropertiesSortVO propertiesSort;

    // PropertiesSortVO 포함
    private EmpPropVO empProp;
    
    // Getter & Setter
    public int getPropNo() { return propNo; }
    public void setPropNo(int propNo) { this.propNo = propNo; }

    public String getPropName() { return propName; }
    public void setPropName(String propName) { this.propName = propName; }

    public String getPropContent() { return propContent; }
    public void setPropContent(String propContent) { this.propContent = propContent; }

    public int getPropQty() { return propQty; }
    public void setPropQty(int propQty) { this.propQty = propQty; }

    public String getFileIdentify() { return fileIdentify; }
    public void setFileIdentify(String fileIdentify) { this.fileIdentify = fileIdentify; }

    public PropertiesSortVO getPropertiesSort() { return propertiesSort; }
    public void setPropertiesSort(PropertiesSortVO propertiesSort) { this.propertiesSort = propertiesSort; }

    // 🚀 PsLarge와 PsSmall을 직접 접근하는 편의 메서드 추가
    public String getPsLarge() {
        return propertiesSort != null ? propertiesSort.getPsLarge() : null;
    }

    public String getPsSmall() {
        return propertiesSort != null ? propertiesSort.getPsSmall() : null;
    }
    

    // Getter and Setter for psCode
    public String getPsCode() {
        return psCode;
    }

    public void setPsCode(String psCode) {
        this.psCode = psCode;
    }
    
	private String epNo;
	private String emplNo;
	private Date epSdate;
	private Date epEdate;
	private Date epRdate;
	
	
	
}
