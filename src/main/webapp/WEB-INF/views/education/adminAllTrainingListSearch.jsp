<%@page import="kr.or.ddit.education.vo.BookVO"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib uri="jakarta.tags.core" prefix="c"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
	<meta name="description" content="Smarthr - Bootstrap Admin Template">
	<meta name="keywords" content="admin, estimates, bootstrap, business, html5, responsive, Projects">
	<meta name="author" content="Dreams technologies - Bootstrap Admin Template">
	<meta name="robots" content="noindex, nofollow">
	<title>전체교육 목록관리</title>
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	
	<style>
    .book-item {
        display: inline-block;
        position: relative;
        margin: 10px;
        text-align: center;
        cursor: pointer;
    }
    .book-item img {
        width: 120px;
        height: auto;
        transition: transform 0.3s ease;
    }
    .book-item:hover img {
        transform: scale(1.1);
    }
    .book-item p {
        display: none;
        position: absolute;
        top: 100%;
        left: 50%;
        width: 180px;
        transform: translateX(-50%);
        background: rgba(0, 0, 0, 0.8);
        color: #fff;
        padding: 5px;
        border-radius: 5px;
        text-align: center;
        font-size: 12px;
        z-index: 100;
    }

    .book-item:hover p {
        display: none;
    }
    .search-container {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
	}
	
	#searchInput {
	    width: 300px; /* 너비 조정 */
	    height: 43px; /* 높이 증가 */
	    font-size: 16px; /* 글씨 크기 증가 */
	    padding: 10px;
	    border: 2px solid #808080; /* 파란색 테두리 */
	    border-radius: 8px; /* 모서리 둥글게 */
	    outline: none;
	    transition: all 0.3s ease;
	}
	
	#searchInput:focus {
	    border-color: #808080; /* 포커스 시 더 진한 파란색 */
	    box-shadow: 0 0 8px rgba(0, 91, 187, 0.5);
	}
</style>
</head>
<body>

	<div id="global-loader">
		<div class="page-loader"></div>
	</div>
	
	<div class="main-wrapper">
		<%@ include file="/WEB-INF/views/theme/header.jsp" %>
		<%@ include file="/WEB-INF/views/theme/sidebar.jsp" %>
		<%@ include file="/WEB-INF/views/theme/modal.jsp" %>
		
		
		<div class="page-wrapper">
			<div class="content">

				<!-- Breadcrumb -->
				<div class="d-md-flex d-block align-items-center justify-content-between page-breadcrumb mb-3">
					<div class="my-auto mb-2">
						<h2 class="mb-1">전체교육 목록관리</h2>
					</div>
					<div class="d-flex my-xl-auto right-content align-items-center flex-wrap ">
						<div class="me-2 mb-2">
							<div class="dropdown">
								<ul class="dropdown-menu  dropdown-menu-end p-3">
									<li>
										<a href="javascript:void(0);" class="dropdown-item rounded-1"><i class="ti ti-file-type-pdf me-1"></i>Export as PDF</a>
									</li>
									<li>
										<a href="javascript:void(0);" class="dropdown-item rounded-1"><i class="ti ti-file-type-xls me-1"></i>Export as Excel </a>
									</li>
								</ul>
							</div>
						</div>
						<div class="mb-2">
							<a href="#" data-bs-toggle="modal" data-bs-target="#add_book" class="btn btn-primary d-flex align-items-center"><i class="ti ti-circle-plus me-2"></i>교재등록</a>
						</div>&nbsp;
						<div class="mb-2">
							<a href="#" data-bs-toggle="modal" data-bs-target="#add_curriculum" class="btn btn-primary d-flex align-items-center"><i class="ti ti-circle-plus me-2"></i>커리큘럼등록</a>
						</div>&nbsp;
						<div class="mb-2">
							<a href="#" data-bs-toggle="modal" data-bs-target="#add_project" class="btn btn-primary d-flex align-items-center"><i class="ti ti-circle-plus me-2"></i>강의등록</a>
						</div>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<!-- Leads List -->
				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>전체교육 목록조회</h5>
						<div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="text" class="form-control" placeholder="강의제목" style="width: 100px;" id="edcTitle">
								</div>
							</div>
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="text" class="form-control" placeholder="교육담당" style="width: 100px;" id="educator">
								</div>
							</div>
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="text" class="form-control" placeholder="교육대상부서" style="width: 160px;" id="edcTarget">
								</div>
							</div>
							<input type="button" class="btn btn-primary d-flex align-items-center" value="검색" id="searchBtn">
						</div>
					</div>
					<div class="card-body p-0"> <!-- CARD CARD CARDCARDCARDCARDCARDCARDCARDCARDCARDCARDCARDCARD -->
						<div class="custom-datatable-filter table-responsive">
							<table class="table datatable">
								<thead class="thead-light">
									<tr>
										<th style="text-align: center;">강의제목 (자세히보기)</th>
										<th style="text-align: center;">교육유형</th>
										<th style="text-align: center;">교육담당</th>
										<th style="text-align: center;">교육대상부서</th>
										<th style="text-align: center;">수강정원</th>
										<th style="text-align: center;">모집기간</th>
										<th style="text-align: center;">수강기간</th>
										<th style="text-align: center;">수정/비활성화</th>
									</tr>
								</thead>
								<tbody id="dataTable-tbody">
								
								</tbody> 
							</table> <!-- /테이블 -->
						</div>
					</div>
					<div id="pagingArea" style="display: flex; justify-content: center; align-items: center; padding:15px;">
					</div>
					<script>
						let searchBtn = $("#searchBtn");
						let pagingArea = $("#pagingArea");
						getList(1);
					$(function(){
							searchBtn.on("click", function(){
								let edcTitle = $("#edcTitle");
								let educator = $("#educator");
								let edcSort = $("#edcSort");
								let edcTarget = $("#edcTarget");
								
								console.log("검색어들 : ", edcTitle.val(), educator.val(), edcSort.val(), edcTarget.val());
								getList(1, edcTitle.val(), educator.val(), edcSort.val(), edcTarget.val());
							});
							
							pagingArea.on("click", "a", function(){
								event.preventDefault();
								let page = $(this).data("page");
								let edcTitle = $("#edcTitle");
								let educator = $("#educator");
								let edcPsncpa = $("#edcPsncpa");
								let edcSdate = $("#edcSdate");
								let edcEdate = $("#edcEdate");
								let recruitSdate = $("#recruitSdate");
								let recruitEdate = $("#recruitEdate");
								let edcTarget = $("#edcTarget");
								let edcSort = $("#edcSort");
								getList(page, edcTitle.val(), educator.val(), edcSort.val(), edcTarget.val());
							})
							
							
						});
						
						function getList(page, edcTitle, educator, edcSort, edcTarget) {
						    let pagingArea = $("#pagingArea");
						    let dataTable_tbody = $("#dataTable-tbody");

						    // 기본 데이터 설정
						    let data = { page: page };

						    if (edcTitle != null) data.edcTitle = edcTitle;
						    if (educator != null) data.educator = educator;
						    if (edcSort != null) data.edcSort = edcSort;
						    if (edcTarget != null) data.edcTarget = edcTarget;
						    
						    console.log("전송 데이터:", data);

						    $.ajax({
						        url: "/hrms/education/admin/rest/getEducationAllList",
						        type: "POST",
						        data: JSON.stringify(data),
						        contentType: "application/json;charset=utf-8",
						        success: function (res) {
						            console.log("응답 데이터:", res);

						            let tr = "";

						            if (res.eduAllList && res.eduAllList.length > 0) {
						            	res.eduAllList.forEach(function(edu) {
						            	    let recruitPeriod = `${edu.recruitSdateFormatted} ~ ${edu.recruitEdateFormatted}`;
						            	    let edcPeriod = `${edu.edcSdateFormatted} ~ ${edu.edcEdateFormatted}`;

						            	    tr += `
												<tr>
								            	    <td>
								            	        <p class="fs-14 text-dark fw-medium">
								            	            <a href="/hrms/education/admin/adminTrainingDetail/\${edu.edcNo}">
								            	                \${edu.edcTitle}
								            	            </a>
								            	        </p>
								            	    </td>
								            	    <td style="text-align: center;">\${edu.edcSort}</td>
						                            <td style="text-align: center;">\${edu.educator}</td>
						                            <td style="text-align: center;">\${edu.edcTarget}</td>
						                            <td style="text-align: center;">\${edu.edcPsncpa}</td>
						                            <td style="text-align: center;">
						                                <span class="text-nowrap">\${edu.recruitSdateFormatted} ~ \${edu.recruitEdateFormatted}</span>
						                            </td>
						                            <td style="text-align: center;">
						                                <span class="text-nowrap">\${edu.edcSdateFormatted} ~ \${edu.edcEdateFormatted}</span>
						                            </td>
						                            <td style="text-align: center;">
						                                <div class="action-icon d-inline-flex">
						                                	<a href="/hrms/education/admin/adminTrainingDetail/\${edu.edcNo}"><i class="ti ti-edit"></i></a>
						                                    <a href="javascript:void(0);" class="deleteLecture-btn" data-edc-no="\${edu.edcNo}">
							                                    <i class="ti ti-trash"></i>
							                                </a>
						                                </div>
						                            </td>
						            	        </tr>	
						            	    `;
						            	});
						                dataTable_tbody.html(tr);
						            } else {
						                dataTable_tbody.html(`<tr><td colspan="8" class="text-center">데이터가 없습니다.</td></tr>`);
						            }
						            pagingArea.html(res.pageVO.pagingHTML);
						        },
						        error: function (error) {
						            console.log("AJAX 요청 실패", error);
						        },
						    });
						}

						/* 교육 삭제 시 상태 변경 */
						$(document).ready(function () {
						    // 삭제(비활성화) 버튼 클릭 이벤트
						    $(document).on("click", ".deleteLecture-btn", function () {
						        let edcNo = $(this).data("edc-no"); // 강의 번호 가져오기
						
						        if (!confirm("정말로 해당 강의를 비활성화하시겠습니까?")) {
						            return;
						        }
						
						        let requestData = { edcNo: edcNo };
						
						        console.log("보낼 데이터:", requestData);
						
						        $.ajax({
						            url: "/hrms/education/admin/rest/updateEdcActive",
						            type: "POST",
						            contentType: "application/json",
						            data: JSON.stringify(requestData),
						            success: function (response) {
						            	showToastMessage("✅ 강의가 비활성화되었습니다. ", "success");
						            	setTimeout(() => location.reload(), 1000);
						            },
						            error: function (xhr, status, error) {
						                console.error("삭제 실패:", xhr.responseText);
						                alert("삭제 중 오류가 발생했습니다.");
						            }
						        });
						    });
						});
					</script>
				</div>
				<!-- /Leads List -->
			</div>
			<div class="footer d-sm-flex align-items-center justify-content-between border-top bg-white p-3">
				<p class="mb-0">2001 - 2025 &copy; HRMS.</p>
				<p>Designed &amp; Developed By <a href="javascript:void(0);" class="text-primary">HERMES</a></p>
			</div>
		</div>
		<!-- /Page Wrapper -->
		
		<!-- Add Project -->
		<div class="modal fade" id="add_project" role="dialog">
			<div class="modal-dialog modal-dialog-centered modal-lg">
				<div class="modal-content">
					<div class="modal-header header-border align-items-center justify-content-between">
						<div class="d-flex align-items-center">
							<h5 class="modal-title me-2">새로운 강의 등록</h5>
						</div>
						<button type="button" class="btn-close custom-btn-close" data-bs-dismiss="modal" aria-label="Close">
							<i class="ti ti-x"></i>
						</button>
					</div>
					<div class="add-info-fieldset ">
							<div class="tab-content" id="myTabContent">
								<div class="tab-pane fade show active" id="basic-info" role="tabpanel" aria-labelledby="basic-tab" tabindex="0">
							<form>
								<div class="modal-body">
									<div class="row">
										<div class="col-md-12">
											<div class="mb-3">
												<label class="form-label">교육명</label>
												<input type="text" class="form-control" id="edcTitle2"  required placeholder="교육명을 입력하세요.">
											</div>
										</div>
										<div class="col-md-6">
										    <div class="mb-3">
										        <label class="form-label">교육교재</label>
										        <select class="select" id="bookNo">
										            <option>선택</option>
										        </select>
										    </div>
										</div>
										
										<script>
										    $(document).ready(function() {
										        $.ajax({
										            url: "/hrms/education/admin/rest/getBookList",
										            type: "GET",
										            dataType: "json",
										            success: function(books) {
										                let bookNo = $("#bookNo");
										                console.log(bookNo,"책넘버--------------------------------------------------------");
										                books.forEach(function(book) {
										                    let option = `<option value="\${book.bookNo}">\${book.bookName}</option>`;
										                    bookNo.append(option);
										                });
										            },
										            error: function(xhr, status, error) {
										                console.error("책 데이터를 불러오는 중 오류 발생:", error);
										            }
										        });
										    });
										</script>
										<div class="col-md-6">
											<div class="mb-3">
												<label class="form-label">교육분류</label>
												<select class="select" id="edcSort2">
													<option>경영</option>
													<option>기술</option>
													<option>마케팅</option>
													<option>어학</option>
													<option>기타</option>
												</select>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="mb-3">
												<label class="form-label">교육대상부서</label>
												<select class="select" id="edcTarget2">
													<option>전체</option>
													<option>01_경영인사</option>
													<option>02_마케팅</option>
													<option>03_연구개발</option>
													<option>04_운영</option>
													<option>05_재무회계</option>
												</select>
											</div>
										</div>
										
										
										<div class="col-md-4">
											<div class="mb-3">
												<label class="form-label">교육대상직급</label>
												<select class="select" id="edcGrade2">
													<option>전체</option>
													<option>사원</option>
													<option>대리</option>
													<option>과장</option>
													<option>차장</option>
													<option>부장</option>
												</select>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="mb-3">
										        <label class="form-label">교육커리큘럼</label>
										        <select class="select" id="curNo">
										            <option>선택</option>
										        </select>
										    </div>
										</div>
										
										<script>
										    $(document).ready(function() {
										        $.ajax({
										            url: "/hrms/education/admin/rest/getCurList",
										            type: "GET",
										            dataType: "json",
										            success: function(curs) {
										                let curNo = $("#curNo");
										                curs.forEach(function(cur) {
										                    let option = `<option value=\${cur.curNo}>\${cur.curTitle}</option>`;
										                    curNo.append(option);
										                });
										            },
										            error: function(xhr, status, error) {
										                console.error("커리큘럼 데이터를 불러오는 중 오류 발생:", error);
										            }
										        });
										    });
										</script>
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-3">
													<div class="mb-3">
														<label class="form-label">모집시작일자</label>
														<input type="date" class="form-control" id="recruitSdate" placeholder="yyyy/mm/dd">
														<span class="input-icon-addon">
															<i class="ti ti-calendar text-gray-7"></i>
														</span>
													</div>
												</div>
												<div class="col-md-3">
													<div class="mb-3">
														<label class="form-label">모집종료일자</label>
														<input type="date" class="form-control" id="recruitEdate" placeholder="yyyy/mm/dd">
														<span class="input-icon-addon">
															<i class="ti ti-calendar text-gray-7"></i>
														</span>
													</div>
												</div>
												<div class="col-md-3">
													<div class="mb-3">
														<label class="form-label">교육시작일자</label>
														<input type="date" class="form-control" id="edcSdate" placeholder="yyyy/mm/dd">
														<span class="input-icon-addon">
															<i class="ti ti-calendar text-gray-7"></i>
														</span>
													</div>
												</div>
												<div class="col-md-3">
													<div class="mb-3">
														<label class="form-label">교육종료일자</label>
														<input type="date" class="form-control" id="edcEdate" placeholder="yyyy/mm/dd">
														<span class="input-icon-addon">
															<i class="ti ti-calendar text-gray-7"></i>
														</span>
													</div>
												</div>
												
												<div class="col-md-4">
													<div class="mb-3">
														<label class="form-label">교육방식</label>
														<select class="select" id="edcWay">
															<option>온라인</option>
															<option>오프라인</option>
														</select>
													</div>
												</div>
												<div class="col-md-4">
													<div class="mb-3">
														<label class="form-label">강사명</label>
														<input type="text" class="form-control" id="educator2" value="">
													</div>
												</div>
												<div class="col-md-4">
													<div class="mb-3">
														<label class="form-label">수강인원제한</label>
														<input type="text" class="form-control" id="edcPsncpa" value="">
													</div>
												</div>
											</div>
										</div>
										<div class="col-md-12">
											<div class="mb-3">
												<label class="form-label">교육설명</label>
												<input type="text" class="form-control" id="edcContent">
											</div>
										</div>
									</div>								
								</div>
								<div class="modal-footer">
									<div class="d-flex align-items-center justify-content-end">
										<button class="btn btn-success me-2" type="button" id="exampleButton2">예시</button>
										<button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">취소</button>
										<button class="btn btn-primary" type="button" id="saveProjectBtn">저장</button>
									</div>
								</div>
							</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /Add Project -->
		
		<!-- Add Book -->
		<div class="modal fade" id="add_book" role="dialog">
		    <div class="modal-dialog modal-dialog-centered modal-lg">
		        <div class="modal-content">
		            <div class="modal-header header-border align-items-center justify-content-between">
		                <div class="d-flex align-items-center">
		                    <h5 class="modal-title me-2">강의 도서추가</h5>
		                </div>
		                <button type="button" class="btn-close custom-btn-close" data-bs-dismiss="modal" aria-label="Close">
		                    <i class="ti ti-x"></i>
		                </button>
		            </div>
		            <div class="add-info-fieldset ">
		                <div class="tab-content" id="myTabContent">
		                    <div class="tab-pane fade show active" id="basic-info" role="tabpanel" aria-labelledby="basic-tab" tabindex="0">
		                        <form id="bookForm">
		                            <div class="modal-body">
		                                <div class="row">
		                                    <div class="col-md-12">
		                                        <div class="d-flex align-items-center flex-wrap row-gap-3 bg-light w-100 rounded p-3 mb-4">
		                                            <div class="profile-upload">
		                                                <div class="mb-2">
		                                                    <h6 class="mb-1">도서 검색</h6>
		                                                    <div class="search-container">
		                                                        <input type="text" id="searchInput" placeholder="도서명을 입력하세요">
		                                                        <button type="button" class="btn btn-primary" onclick="searchBooks()">검색</button>
		                                                    </div>
		                                                    <div id="searchResults" style="display: none;"></div>
		                                                </div>
		                                            </div>
		                                        </div>
		                                    </div>
		                                    <div class="col-md-12 text-center">
		                                        <img id="bookThumbnail" src="" alt="Book Thumbnail" style="max-width: 150px; display: none;">
		                                    </div>
		                                    <div class="col-md-12">
		                                        <div class="mb-3">
		                                            <label class="form-label">도서명</label>
		                                            <input type="text" id="bookTitle" class="form-control" readonly>
		                                        </div>
		                                    </div>
		                                    <div class="col-md-12">
		                                        <div class="mb-3">
		                                            <label class="form-label">도서 가격</label>
		                                            <input type="text" id="bookPrice" class="form-control" readonly>
		                                        </div>
		                                    </div>
		                                    <div class="col-md-12">
		                                        <div class="mb-3">
		                                            <label class="form-label">도서 출판사</label>
		                                            <input type="text" id="bookPublisher" class="form-control" readonly>
		                                        </div>
		                                    </div>
		                                    <div class="col-md-12">
		                                        <div class="mb-3">
		                                            <label class="form-label">도서 고유번호(ISBN)</label>
		                                            <input type="text" id="bookIsbn" class="form-control" readonly>
		                                        </div>
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="modal-footer">
		                                <div class="d-flex align-items-center justify-content-end">
		                                    <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">취소</button>
		                                    <button type="button" onclick="saveBookBtn()" class="btn btn-primary">저장</button>
		                                </div>
		                            </div>
		                        </form>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
		<!-- /Add Book -->
		
		<!-- Add Curriculum -->
		<div class="modal fade" id="add_curriculum" role="dialog">
		    <div class="modal-dialog modal-dialog-centered modal-lg">
		        <div class="modal-content">
		            <div class="modal-header header-border align-items-center justify-content-between">
		                <div class="d-flex align-items-center">
		                    <h5 class="modal-title me-2">강의 커리큘럼</h5>
		                </div>
		                <button type="button" class="btn-close custom-btn-close" data-bs-dismiss="modal" aria-label="Close">
		                    <i class="ti ti-x"></i>
		                </button>
		            </div>
		            <div class="add-info-fieldset ">
		                <div class="tab-content" id="myTabContent">
		                    <div class="tab-pane fade show active" id="basic-info1" role="tabpanel" aria-labelledby="basic-tab" tabindex="0">
		                        <form id="curForm">
		                            <div class="modal-body">
		                                <div class="row">
		                                    <div class="col-md-12">
											    <div class="mb-3">
											        <label class="form-label">커리큘럼 주제</label>
											        <input type="text" id="curTitle" class="form-control" >
											    </div>
											</div>
											<div id="curriculumContainer"></div>
											<button type="button" class="btn btn-primary mt-2" id="addCurriculum">+ 추가</button>
		                                </div>
		                            </div>
		                            <div class="modal-footer">
		                                <div class="d-flex align-items-center justify-content-end">
											<button type="button" id="exampleButton" class="btn btn-success me-2">예시</button>
		                                    <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">취소</button>
		                                    <button type="button" onclick="saveCurriculumBtn()" class="btn btn-primary">저장</button>
		                                </div>
		                            </div>
		                        </form>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
		<!-- /Add Curriculum -->
		 <script>
		 $(document).ready(function() {
			    $("#exampleButton").click(function() {
			        let curriculumContainer = $("#curriculumContainer");
			        $("#curTitle").val("2025 정보처리기사 필기 과정");

			        // 기존 입력값 초기화
			        curriculumContainer.empty();

			        let exampleData = [
								{
										content: "정보처리기사 1과목",
										url: `<iframe width="560" height="315" src="https://www.youtube.com/embed/V6xZmoIyTR8?si=9LjBIOvsR66zIrRc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>`,
										description: "정보처리기사 1과목 요약정리"
								},
								{
										content: "정보처리기사 2과목",
										url: `<iframe width="560" height="315" src="https://www.youtube.com/embed/kHAlXdI3cZ4?si=qY0yYmn4BGaweb0t" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>`,
										description: "정보처리기사 2과목 요약정리"
								},
								{
									content: "정보처리기사 3과목",
									url: `<iframe width="560" height="315" src="https://www.youtube.com/embed/JxuLMGJONfE?si=aCxdwkDb52gYD5VZ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>`,
									description: "정보처리기사 3과목 요약정리"
								},
								{
									content: "정보처리기사 4과목",
									url: `<iframe width="560" height="315" src="https://www.youtube.com/embed/W5UyQK1UoiE?si=oCDH8WJRkoaJwG2t" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>`,
									description: "정보처리기사 4과목 요약정리"
								},
								{
									content: "정보처리기사 5과목",
									url: `<iframe width="560" height="315" src="https://www.youtube.com/embed/CZaHIHj1uTs?si=PdcFzIiw5x71PNfL" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>`,
									description: "정보처리기사 5과목 요약정리"
								}
						];

			        $.each(exampleData, function(index, data) {
			            let row = `
			                <div class="curriculum-item input-group mb-2">
			                    <input type="text" class="form-control curName" value="\${data.content}" readonly>
			                    <textarea class="form-control curUrl">\${data.url}</textarea>
			                    <input type="text" class="form-control curExplain" value="\${data.description}" readonly>
			                    <button type="button" class="btn btn-danger removeCurriculum">삭제</button>
			                </div>
			            `;
			            curriculumContainer.append(row);
			        });
			    });

			    $("#curriculumContainer").on("click", ".removeCurriculum", function () {
			        $(this).closest(".curriculum-item").remove();
			    });
			});
		
		 </script>
		<script>
		$(document).ready(function () {
		    $("#addCurriculum").click(function () {
		        let curriculumHtml = `
		            <div class="input-group mb-2 curriculum-item">
		                <input type="text" class="form-control" placeholder="커리큘럼 내용" name="curName">
		                <input type="text" class="form-control" placeholder="커리큘럼 URL" name="curUrl">
		                <input type="text" class="form-control" placeholder="커리큘럼 설명" name="curExplain">
		                <button type="button" class="btn btn-danger removeCurriculum">삭제</button>
		            </div>
		        `;
		        $("#curriculumContainer").append(curriculumHtml);
		    });

		    // 삭제 버튼 클릭 시 해당 입력 필드 제거
		    $("#curriculumContainer").on("click", ".removeCurriculum", function () {
		        $(this).closest(".curriculum-item").remove();
		    });
		});

		</script>
		<script>
		function saveCurriculumBtn() {
		    let curTitle = $("#curTitle").val();
		    let curriculumList = [];

		    $(".curriculum-item").each(function () {
		        let curName = $(this).find(".curName").val();
		        let curUrl = $(this).find(".curUrl").val();
		        let curExplain = $(this).find(".curExplain").val();

		        if (curName && curUrl && curExplain) {
		            curriculumList.push({
		                curTitle: curTitle, 
		                curName: curName,
		                curUrl: curUrl,
		                curExplain: curExplain
		            });
		        }
		    });

		    console.log("보낼 데이터:", curriculumList);

		    $.ajax({
		        url: "/hrms/education/admin/rest/insertCurriculum",
		        method: "POST",
		        contentType: "application/json",
		        data: JSON.stringify(curriculumList),
		        success: function (response) {
		            alert("커리큘럼 저장 완료!");
		            location.reload();
		        },
		        error: function (xhr, status, error) {
		            console.error("커리큘럼 저장 실패:", error);
		        }
		    });
		}

		</script>
		<script>
		function formatDateTime(dateString) {
		    if (!dateString) return "";
		    
		    let date = new Date(dateString);
		    let year = date.getFullYear();
		    let month = String(date.getMonth() + 1).padStart(2, "0");
		    let day = String(date.getDate()).padStart(2, "0");
		    let hours = String(date.getHours()).padStart(2, "0");
		    let minutes = String(date.getMinutes()).padStart(2, "0");
		    
		    return `${year}-${month}-${day} ${hours}:${minutes}`;
		}

		
		function searchBooks() {
		    var searchInput = $('#searchInput').val();
		    $.ajax({
		        method: 'GET',
		        url: 'https://dapi.kakao.com/v3/search/book',
		        data: { query: searchInput },
		        headers: { Authorization: "KakaoAK 50d753224767b8df6c6cc952f53afdf8" }
		    })
		    .done(function (response) {
		        var books = response.documents;
		        var searchResults = $('#searchResults');
		        searchResults.empty().show();
		        books.forEach(function (book) {
		            var resultHtml = '<div class="book-item" onclick="fillBookForm(' + JSON.stringify(book).replace(/"/g, '&quot;') + ')">' +
		                '<img src="' + book.thumbnail + '" style="cursor:pointer; width:100px;">' +
		                '<p>' + book.title + '</p>' + '<p>' + book.sale_price + '</p>' + '<p>' + book.publisher + '</p>' +
		                '<p>' + book.isbn + '</p>' + '<p>' + book.thumbnail + '</p>'  +
		                '</div>';
		            searchResults.append(resultHtml);
		        });
		    })
		    .fail(function (error) {
		        console.error('책 검색에 실패했습니다:', error);
		    });
		}
		
		function fillBookForm(book) {
		    $('#bookTitle').val(book.title);
		    $('#bookPrice').val(book.sale_price);
		    $('#bookPublisher').val(book.publisher);
		    $('#bookIsbn').val(book.isbn);
		    $('#bookThumbnail').attr('src', book.thumbnail).show();
		}
		
		function saveBookBtn() {
		
	        console.log("saveBookBtn 클릭"); 

	        let bookData = {
	            bookNo: $('#bookIsbn').val(),           				
	            bookName: $('#bookTitle').val(),       					
	            bookPrice: $('#bookPrice').val(),      					
	            bookCompany: $('#bookPublisher').val() 					
	        };

	        console.log("보낼 데이터:", bookData); 						

	        $.ajax({
	            url: '/hrms/education/admin/rest/insertBook',
	            method: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify(bookData),
	            success: function (response) {
	                console.log("성공 응답:", response); 			
	                alert('도서가 성공적으로 등록되었습니다!');
	                location.reload();
	            },
	            error: function (xhr, status, error) {
	                console.error("도서 등록 실패:", xhr.responseText); 
	                alert('도서 등록 중 오류가 발생했습니다.');
	            }
	        });
		}

	</script>
		<script>
		$("#saveProjectBtn").click(function () {
		    let edcTitle2Value = $("#edcTitle2").val();
		    if (edcTitle2Value == null || edcTitle2Value == "") {
		        alert("교육명을 입력해주세요."); 
		        return;  
		    }
		    
		    let educationData = {
		        edcSort: $("#edcSort2").val(),
		        edcWay: $("#edcWay").val(),
		        educator: $("#educator2").val(),
		        edcTarget: $("#edcTarget2").val(),
		        edcGrade: $("#edcGrade2").val(),
		        edcPsncpa: $("#edcPsncpa").val(),
		        edcTitle: edcTitle2Value, 
		        edcContent: $("#edcContent").val(),
		        recruitSdate: $("#recruitSdate").val(),
		        recruitEdate: $("#recruitEdate").val(),
		        edcSdate: $("#edcSdate").val(),
		        edcEdate: $("#edcEdate").val(),
		        edcActive: "Y",
		        bookNo: $("#bookNo").val(),
		        curNo: $("#curNo").val()
		    };

		    console.log("보낼 데이터:", educationData);

		    $.ajax({
		        url: "/hrms/education/admin/rest/insertEducationWithCurriculum",
		        type: "POST",
		        contentType: "application/json",
		        data: JSON.stringify(educationData),
		        success: function (response) {
		            alert("강의 등록 완료!");
		            location.reload();
		        },
		        error: function (xhr, status, error) {
		            console.error("등록 실패:", error);
		        }
		    });
		}); 
		
		function showToastMessage(message, type = "primary") {
			let toast = $("#toastMessage");
			toast.removeClass("bg-primary bg-success bg-danger bg-warning");
			toast.addClass(`bg-\${type}`);
			$("#toastBody").text(message);
			let toastInstance = new bootstrap.Toast(toast[0]);
			toastInstance.show();
		}
		</script>
		<script>
		$("#exampleButton2").click(function () {
		    $("#edcTitle2").val("2025년도 1분기 정보처리기사 필기 과정");

		    $("#edcSort2").val("기술").trigger("change");
		    $("#edcTarget2").val("전체").trigger("change");
		    $("#edcGrade2").val("전체").trigger("change");

		    $("#recruitSdate").val("2025-03-01");
		    $("#recruitEdate").val("2025-03-31");
		    $("#edcSdate").val("2025-03-01");
		    $("#edcEdate").val("2025-04-30");

		    $("#select2-edcWay-container").val("온라인").trigger("change");

		    $("#educator2").val("양문자");
		    $("#edcPsncpa").val(100);
		    $("#edcContent").val("2025년도 정보처리기사 필기 대비");

		    let targetBookNo = "1165217317 9791165217310";
		    let foundBookNo = $("#bookNo option").filter(function () {
		        return $(this).val() === targetBookNo;
		    }).val();

		    if (foundBookNo) {
		        $("#bookNo").val(foundBookNo).trigger("change");
		    }

		    let targetCurTitle = "2025 정보처리기사 필기 과정";
		    let foundCurNo = $("#curNo option").filter(function () {
		        return $(this).text().includes(targetCurTitle);
		    }).val();

		    if (foundCurNo) {
		        $("#curNo").val(foundCurNo).trigger("change");
		    }
		});

		$(document).ready(function () {
		    $.ajax({
		        url: "/hrms/education/admin/rest/getBookList",
		        type: "GET",
		        dataType: "json",
		        success: function (books) {
		            let bookNo = $("#bookNo");
		            bookNo.empty().append('<option value="">선택</option>');

		            books.forEach(function (book) {
		                let option = `<option value="\${book.bookNo}">\${book.bookName}</option>`;
		                bookNo.append(option);
		            });

		            let targetBookNo = "1165217317 9791165217310";
		            let foundBookNo = $("#bookNo option").filter(function () {
		                return $(this).val() === targetBookNo;
		            }).val();

		            if (foundBookNo) {
		                $("#bookNo").val(foundBookNo).trigger("change");
		            }
		        },
		        error: function (xhr, status, error) {
		            console.error("책 데이터를 불러오는 중 오류 발생:", error);
		        }
		    });

		    $.ajax({
		        url: "/hrms/education/admin/rest/getCurList",
		        type: "GET",
		        dataType: "json",
		        success: function (curs) {
		            let curNo = $("#curNo");
		            curNo.empty().append('<option value="">선택</option>');

		            curs.forEach(function (cur) {
		                let option = `<option value="\${cur.curNo}">\${cur.curTitle}</option>`;
		                curNo.append(option);
		            });

		            let targetCurTitle = "2025 정보처리기사 필기 과정";
		            let foundCurNo = $("#curNo option").filter(function () {
		                return $(this).text().includes(targetCurTitle);
		            }).val();

		            if (foundCurNo) {
		                $("#curNo").val(foundCurNo).trigger("change");
		            }
		        },
		        error: function (xhr, status, error) {
		            console.error("커리큘럼 데이터를 불러오는 중 오류 발생:", error);
		        }
		    });
		});
		</script>
	</div>
	<!-- /Main Wrapper -->

<!-- jQuery -->
<script src="${pageContext.request.contextPath }/assets/js/jquery-3.7.1.min.js"></script>

<!-- Bootstrap Core JS -->
<script src="${pageContext.request.contextPath }/assets/js/bootstrap.bundle.min.js"></script>

<!-- Feather Icon JS -->
<script src="${pageContext.request.contextPath }/assets/js/feather.min.js"></script>

<!-- Slimscroll JS -->
<script src="${pageContext.request.contextPath }/assets/js/jquery.slimscroll.min.js"></script>

<!-- Color Picker JS -->
<script src="${pageContext.request.contextPath }/assets/plugins/@simonwep/pickr/pickr.es5.min.js"></script>

<!-- Datatable JS -->
<script src="${pageContext.request.contextPath }/assets/js/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/dataTables.bootstrap5.min.js"></script>	

<!-- Daterangepikcer JS -->
<script src="${pageContext.request.contextPath }/assets/js/moment.js"></script>
<script src="${pageContext.request.contextPath }/assets/plugins/daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/bootstrap-datetimepicker.min.js"></script>

<!-- Select2 JS -->
<script src="${pageContext.request.contextPath }/assets/plugins/select2/js/select2.min.js"></script>

<!-- Chart JS -->
<script src="${pageContext.request.contextPath }/assets/plugins/apexchart/apexcharts.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/plugins/apexchart/chart-data.js"></script>

<!-- Custom JS -->
<script src="${pageContext.request.contextPath }/assets/js/circle-progress.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/theme-colorpicker.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/script.js"></script>
	
</body>
</html>