package kr.or.ddit.education.vo;

import lombok.Data;

@Data
public class CurriculumVO {

	private int curNo;            // 커리큘럼 NO
	private int curOrder;         // 교육번호 (복합키, 즉 커리큘럼 no는 기본키라 멈추고, 이걸로 1-1, 1-2  이런식으로!)
	private String curTitle;      // 커리큘럼 주제
	private String curName;       // 커리큘럼명
	private String curUrl;        // 해당 커리큘럼의 URL
	private String curExplain;    // 해당 커리큘럼 설명
	
    public String getCurTitle() { return curTitle; }
    public void setCurTitle(String curTitle) { this.curTitle = curTitle; }

}
