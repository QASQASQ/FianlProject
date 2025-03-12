package kr.or.ddit.cmm.vo;

import java.util.List;

import lombok.Data;

@Data
public class PaginationInfoVO<T> {
	private String emplNo;
	private int totalRecord; // 총 게시글수
	private int totalPage;	 // 총 페이지수
	private int currentPage; // 현재 페이지
	private int screenSize = 10;  // 페이지당 게시글 수
	private int blockSize = 3;   // 페이지 블록 수
	private int startRow;    // 시작 row
	private int endRow;		 // 끝 row
	private int startPage;	 // 시작 페이지
	private int endPage;	 // 끝 페이지
	private List<T> dataList;// 결과를 넣을 데이터 리스트
	private String searchType;// 검색 타입
	private String searchWord;// 검색 단어
	private String dateStart; // 날짜검색시 "~부터"
	private String dateEnd; // 날짜검색시 "~까지"
	
	public PaginationInfoVO() {}
	public PaginationInfoVO(int screenSize, int blockSize) {
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}

	public void setTotalRecord(int totalRecord) { // @Data어노테이션으로 이미있는 세터를 재정의
		// 총 게시글 수를 저장하고, 총 게시글 수를 페이지당 나타낼 게시글 수로 나눠 총페이지수를 구한다
		this.totalRecord = totalRecord;
		totalPage = (int)Math.ceil(totalRecord / (double)screenSize);
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage; // 현재페이지
		// 끝 row = 현재페이지 * 한 페이지당 게시글 수
		endRow = currentPage * screenSize;
		// 시작 row = 끝 row - (한 페이지당 게시글수 - 1)
		startRow = endRow - (screenSize - 1);
		// 마지막 페이지 = (현재페이지 + (페이지블록 사이즈 - 1)) / 블록 사이즈 * 블록 사이즈
		endPage = (currentPage + (blockSize - 1)) / blockSize * blockSize;
		//'/blockSize * blockSize'는 1,2,3,4... 페이지마다 실수계산이 아닌 정수계산을 이용해 endPage를 구한다.
		startPage = endPage - (blockSize - 1);
	}
	
	public String getPagingHTML() {
		StringBuffer html = new StringBuffer(); // 내가 원하는 데이터를 한개씩 append()로 누적할수있음
		html.append("<ul class='pagination pagination-sm m-0 float-right'>");
		
		if(startPage > 1) {
			html.append("<li class='page-item'><a href='' class='page-link' data-page='" + 
					(startPage - blockSize) + "'>Prev</a></li>");
		}
		for(int i=startPage; i<=(endPage < totalPage ? endPage : totalPage); i++) {
			if(i == currentPage) {
				html.append("<li class='page-item active'><span class='page-link'>" + 
						i + "</span></li>");
			}else {
				html.append("<li class='page-item'><a href='' class='page-link' data-page='" + 
						i + "'>" + i + "</a></li>");
			}
			
		}
		if(endPage < totalPage) {
			html.append("<li class='page-item'><a href='' class='page-link' data-page='" + (endPage + 1) + "'>Next</a></li>");
		}
		html.append("</ul>");
		return html.toString();
	}
	
	
}
