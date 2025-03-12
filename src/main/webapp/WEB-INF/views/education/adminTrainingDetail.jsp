<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib uri="jakarta.tags.core" prefix="c"  %>
<%@ page import="kr.or.ddit.education.vo.BookVO"%>
<%@ page import="kr.or.ddit.education.vo.CurriculumVO"%>
<%@ page import="kr.or.ddit.education.vo.EducationVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <meta name="description" content="Smarthr - Bootstrap Admin Template">
    <meta name="keywords" content="admin, estimates, bootstrap, business, html5, responsive, Projects">
    <meta name="author" content="Dreams technologies - Bootstrap Admin Template">
    <meta name="robots" content="noindex, nofollow">
    
    <title>전체교육관리자 자세히보기</title>
</head>
<body>

    <div class="main-wrapper">
        <%@ include file="/WEB-INF/views/theme/header.jsp" %>
        <%@ include file="/WEB-INF/views/theme/sidebar.jsp" %>
        <%@ include file="/WEB-INF/views/theme/modal.jsp" %>
        
        <div class="page-wrapper">
            <div class="content">

                <div class="row align-items-center mb-4">
                    <div class="d-md-flex d-sm-block justify-content-between align-items-center flex-wrap">
                        <h6 class="fw-medium d-inline-flex align-items-center mb-3 mb-sm-0">
                            <a href="/hrms/education/admin/adminAllTrainingListSearch">
                                <i class="ti ti-arrow-left me-2"></i>목록으로 가기
                            </a>
                        </h6>
                    </div>
                </div>

                <div class="row">
                    <!-- 왼쪽 교육 상세 정보 -->
                    <div class="col-xxl-3 col-xl-4 theiaStickySidebar">
                        <div class="card">
                            <div class="card-body">
	                            <h5 class="mb-3 d-flex justify-content-between align-items-center">
								    교육상세정보
								    <a href="#" data-bs-toggle="modal" data-bs-target="#editEducationModal">
								        <div class="action-icon d-inline-flex"><i class="ti ti-edit fs-3"></i></div>
								    </a>
								</h5>
                                <div class="list-group details-list-group mb-4">
                                    <div class="list-group-item">
                                        <span>교육명</span>
                                        <p class="text-gray-9">${education.edcTitle}</p>
                                    </div>
                                    <div class="list-group-item">
                                        <span>교육 분류</span>
                                        <p class="text-gray-9">${education.edcSort}</p>
                                    </div>
                                    <div class="list-group-item">
                                        <span>교육 방식</span>
                                        <p class="text-gray-9">${education.edcWay}</p>
                                    </div>
                                    <div class="list-group-item">
                                        <span>교육 담당자</span>
                                        <p class="text-gray-9">${education.educator}</p>
                                    </div>
                                    <div class="list-group-item">
                                        <span>교육 정원</span>
                                        <p class="text-gray-9">${education.edcPsncpa}명</p>
                                    </div>
                                    <div class="list-group-item">
                                        <span>교육 대상</span>
                                        <p class="text-gray-9">${education.edcTarget}</p>
                                    </div>
                                    <div class="list-group-item">
                                        <span>모집 기간</span>
                                        <p class="text-gray-9">${education.recruitSdateFormatted} ~ ${education.recruitEdateFormatted}</p>
                                    </div>
                                    <div class="list-group-item">
                                        <span>교육 기간</span>
                                        <p class="text-gray-9">${education.edcSdateFormatted} ~ ${education.edcEdateFormatted}</p>
                                    </div>
                                </div>
                               <h5 class="mb-3 d-flex justify-content-between align-items-center">
								    교육 교재
								    <a href="#" data-bs-toggle="modal" data-bs-target="#editBookModal">
								        <i class="ti ti-edit fs-3"></i>
								    </a>
								</h5>
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>책 제목</th>
                                        </tr>
                                    </thead>
                                    <tbody>
									    <c:choose>
									        <c:when test="${not empty bookList}">
									            <c:forEach var="book" items="${bookList}">
									                <tr>
									                    <td>${book.bookName}</td>
									                </tr>
									            </c:forEach>
									        </c:when>
									        <c:otherwise>
									            <tr>
									                <td colspan="1" class="text-center text-danger">해당 강의에는 교재가 없습니다.</td>
									            </tr>
									        </c:otherwise>
									    </c:choose>
									</tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-xxl-9 col-xl-8">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="mb-3 d-flex justify-content-between align-items-center">
								    교육 설명
								    <a href="#" data-bs-toggle="modal" data-bs-target="#editContentModal">
								        <div class="action-icon d-inline-flex"><i class="ti ti-edit fs-3"></i></div>
								    </a>
								</h5>
                                <p>${education.edcContent}</p>
                                <input type="hidden" id="edcNo" value="${education.edcNo}" />
                            </div>
                        </div>
                        
                        <div class ="card">
							<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
								<h5>해당강의 수강자</h5>
							</div>
	                        <div class="card-body">
								<div class="custom-datatable-filter table-responsive">
			                    	<table class="table datatable">
										<thead class="thead-light">
											<tr>
												<th style="text-align: center;">사번</th>
												<th style="text-align: center;">수강자명</th>
												<th style="text-align: center;">수강상태</th>
												<th style="text-align: center;">진행도</th>
											</tr>
										</thead>
										<tbody id="dataTable-tbody">
										
										</tbody> 
									</table>
								</div>
                        	</div>
                        	<div id="pagingArea" style="display: flex; justify-content: center; align-items: center; padding:15px;">
                        	</div>
                        </div>
                        <script>
                        	let pagingArea = $("#pagingArea");
                        	getList(1);
                        	$(function(){
                        		pagingArea.on("click", "a", function(){
    								event.preventDefault();
    								let page = $(this).data("page");
    								let emplNo = $("emplNo");
    								let emplNm = $("#emplNm");
    								let eeStatus = $("#eeStatus");
    								let eeProgress = $("#eeProgress");
    								getList(page, emplNo.val(), emplNm.val(), eeStatus.val(), eeProgress.val());
    							})
                        	});
                        	function getList(page, emplNo, emplNm, eeStatus, eeProgress) {
    						    let pagingArea = $("#pagingArea");
    						    let dataTable_tbody = $("#dataTable-tbody");
    						    let data = { page: page };

    						    if (emplNo != null) data.emplNo = emplNo;
    						    if (emplNm != null) data.emplNm = emplNm;
    						    if (eeStatus != null) data.eeStatus = eeStatus;
    						    if (eeProgress != null) data.eeProgress = eeProgress;
    						    
    						    let edcNo = $("#edcNo").val();
    						    console.log("관리자의 강의자들 전송 데이터:", data);
    						    console.log("교육데이터 보내주기 -----------------------:", edcNo);
    						    
    						    $.ajax({
    						        url: "/hrms/education/admin/rest/getListenerList",
    						        type: "POST",
    						        data: JSON.stringify({
    						            edcNo: edcNo,
    						            page: 1 
    						        }),
    						        contentType: "application/json;charset=utf-8",
    						        success: function (res) {
    						            let tr = "";
    						            if (res.eduAllList && res.eduAllList.length > 0) {
    						            	res.eduAllList.forEach(function(edu) { 
    						            	    let recruitPeriod = `\${edu.recruitSdateFormatted} ~ \${edu.recruitEdateFormatted}`;
    						            	    let edcPeriod = `\${edu.edcSdateFormatted} ~ \${edu.edcEdateFormatted}`;

    						            	    tr += `
    												<tr>
    						            	    		<td style="text-align: center;">\${edu.emplNo}</td>
    						                            <td style="text-align: center;">\${edu.emplNm}</td>
    						                            <td style="text-align: center;">\${edu.eeStatus}</td>
    						                            <td style="text-align: center;">\${edu.eeProgress}%</td>
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
                        </script>
                        <div class="custom-accordion-items">
						    <div class="accordion accordions-items-seperate" id="accordionExample">
						        <div class="accordion-item">
						            <div class="accordion-header" id="headingTwo">
						                <div class="accordion-button">
						                    <h5>커리큘럼 미리보기</h5>
						                    <div class="ms-auto">
						                        <a href="#" class="d-flex align-items-center collapsed collapse-arrow"
						                            data-bs-toggle="collapse" data-bs-target="#primaryBorderTwo"
						                            aria-expanded="false" aria-controls="primaryBorderTwo">
						                            <i class="ti ti-chevron-down fs-18"></i>
						                        </a>
						                    </div>
						                </div>
						            </div>
						            <div id="primaryBorderTwo" class="accordion-collapse collapse show border-top"
						                aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
						                <div class="accordion-body">
						                    <div class="list-group list-group-flush">
						                        <c:choose>
						                            <c:when test="${not empty curriculumList}">
						                                <c:forEach var="cur" items="${curriculumList}">
						                                    <div class="list-group-item border rounded mb-2 p-2">
						                                        <h4 class="fs-17">${cur.curName}</h4><br/>
						                                        <p> : ${cur.curExplain}</p>
						                                    </div>
						                                </c:forEach>
						                            </c:when>
						                            <c:otherwise>
						                                <div class="text-center text-muted p-3">
						                                    <h5>등록된 커리큘럼이 없습니다.</h5>
						                                </div>
						                            </c:otherwise>
						                        </c:choose>
						                    </div>
						                </div>
						            </div>
						        </div>
						    </div>
						</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    
<!-- 교육 상세 정보 수정 모달 -->
<div class="modal fade" id="editEducationModal" tabindex="-1" aria-labelledby="editEducationModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editEducationModalLabel">교육 상세 정보 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editEducationForm">
                    <input type="hidden" id="editEdcNo" value="${education.edcNo}">
                    <div class="mb-3">
                        <label class="form-label">교육명</label>
                        <input type="text" class="form-control" id="editEdcTitle" value="${education.edcTitle}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">교육 분류</label>
                        <input type="text" class="form-control" id="editEdcSort" value="${education.edcSort}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">교육 방식</label>
                        <input type="text" class="form-control" id="editEdcWay" value="${education.edcWay}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">교육 담당자</label>
                        <input type="text" class="form-control" id="editEducator" value="${education.educator}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">교육정원</label>
                        <input type="text" class="form-control" id="editPsncpa" value="${education.edcPsncpa}">
                    </div>
                    <button type="button" class="btn btn-primary" id="saveEducationBtn">저장</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 교육 내용 수정 모달 -->
<div class="modal fade" id="editContentModal" tabindex="-1" aria-labelledby="editContentModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editContentModalLabel">교육 내용 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editContentForm">
                    <input type="hidden" id="editEdcNoContent" value="${education.edcNo}">
                    <div class="mb-3">
                        <label class="form-label">교육 설명</label>
                        <textarea class="form-control" id="editEdcContent">${education.edcContent}</textarea>
                    </div>
                    <button type="button" class="btn btn-primary" id="saveContentBtn">저장</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 교재 수정 모달 -->
<div class="modal fade" id="editBookModal" tabindex="-1" aria-labelledby="editBookModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editBookModalLabel">교재 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editBookForm">
                    <input type="hidden" id="editEdcNoBook" value="${education.edcNo}">
                    <div class="mb-3">
                        <label class="form-label">책 제목</label>
                        <select class="select" id="bookNo">
				            <option>선택</option>
				        </select>
                    </div>
                    <button type="button" class="btn btn-primary" id="saveBookBtn">저장</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 커리큘럼 수정 모달 -->
<div class="modal fade" id="editCurriculumModal" tabindex="-1" aria-labelledby="editCurriculumModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editCurriculumModalLabel">커리큘럼 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editCurriculumForm">
                    <input type="hidden" id="editEdcNoCur" value="${education.edcNo}">

                    <!-- 커리큘럼 주제 (CUR_TITLE) -->
                    <div class="mb-3">
                        <label class="form-label">커리큘럼 주제</label>
                        <input type="text" class="form-control" id="editCurTitle" value="${curriculumList[0].curTitle}">
                    </div>

					
					<!-- 커리큘럼 목록 -->
					<div id="curriculumContainer">
					    <c:forEach var="cur" items="${curriculumList}">
					        <div class="curriculum-item">
					            <input type="hidden" class="form-control curNo" value="${cur.curNo}">
					            <input type="hidden" class="form-control curOrder" value="${cur.curOrder}">
					            <input type="text" class="form-control curName" value="${cur.curName}" placeholder="커리큘럼명">
					            
					            <!-- textarea를 사용하여 iframe 태그를 포함한 URL을 올바르게 표시 -->
					            <textarea class="form-control curUrl" placeholder="커리큘럼 URL">${cur.curUrl}</textarea>
					            
					            <input type="text" class="form-control curExplain" value="${cur.curExplain}" placeholder="커리큘럼 설명">
					            <!-- <button type="button" class="btn btn-danger removeCurriculum">삭제</button>  -->
					        </div>
					    </c:forEach>
					</div>



                    <!-- 추가 버튼 -->
                    <!-- <button type="button" id="addCurriculum" class="btn btn-secondary mt-2">+ 추가</button> -->
                    
                    <!-- 저장 버튼 -->
                    <button type="button" class="btn btn-primary" id="saveCurriculumBtn">저장</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    // 커리큘럼 추가
    $("#addCurriculum").click(function() {
        let newCurOrder = $("#curriculumContainer .curriculum-item").length + 1;
        $("#curriculumContainer").append(`
            <div class="curriculum-item">
                <input type="hidden" class="form-control curNo" value="">
                <input type="hidden" class="form-control curOrder" value="${newCurOrder}">
                <input type="text" class="form-control curName" placeholder="커리큘럼명">
                <input type="text" class="form-control curUrl" placeholder="커리큘럼 URL">
                <input type="text" class="form-control curExplain" placeholder="커리큘럼 설명">
                <button type="button" class="btn btn-danger removeCurriculum">삭제</button>
            </div>
        `);
    });

    // 커리큘럼 삭제
    $("#curriculumContainer").on("click", ".removeCurriculum", function() {
        $(this).closest(".curriculum-item").remove();
    });

    // 저장 버튼 클릭 이벤트
    $("#saveCurriculumBtn").click(function() {
        let curriculumList = [];
        let curTitle = $("#editCurTitle").val();

        $(".curriculum-item").each(function() {
            curriculumList.push({
                curNo: $(this).find(".curNo").val(),
                curOrder: $(this).find(".curOrder").val(),
                curTitle: curTitle,
                curName: $(this).find(".curName").val(),
                curUrl: $(this).find(".curUrl").val(),
                curExplain: $(this).find(".curExplain").val()
            });
        });

        $.ajax({
            url: "/hrms/education/admin/rest/updateCurriculum",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(curriculumList),
            success: function(response) {
                showSessionToastMessage("커리큘럼 수정 완료!", "success");
                location.reload();
            }
        });
    });
});
</script>

<script>
$(document).ready(function() {
	
	let savedMessage = sessionStorage.getItem("toastMessage");
	let savedType = sessionStorage.getItem("toastType");

	if (savedMessage) {
		let toast = $("#toastMessage");
		toast.removeClass("bg-primary bg-success bg-danger bg-warning");
		toast.addClass(`bg-\${savedType}`);
		$("#toastBody").text(savedMessage);
		
		let toastInstance = new bootstrap.Toast(toast[0]);
		toastInstance.show();
		
		// 메시지 한 번 표시 후 제거 (새로고침 시 다시 뜨지 않도록)
		sessionStorage.removeItem("toastMessage");
		sessionStorage.removeItem("toastType");
	}
	
	
    $.ajax({
        url: "/hrms/education/admin/rest/getBookList",
        type: "GET",
        dataType: "json",
        success: function(books) {
            let bookNo = $("#bookNo");
            books.forEach(function(book) {
                let bookId = book.bookNo.match(/[0-9\s]+/g)?.join("").trim();
                let option = `<option value="\${bookId}">\${book.bookName}</option>`;
                bookNo.append(option);
            });
        },
        error: function(xhr, status, error) {
            console.error("책 데이터를 불러오는 중 오류 발생:", error);
        }
    });
});
</script>

<script>
$(document).ready(function() {
    // 교육 상세 정보 수정
    $("#saveEducationBtn").click(function() {
        let educationData = {
            edcNo: $("#editEdcNo").val(),
            edcTitle: $("#editEdcTitle").val(),
            edcSort: $("#editEdcSort").val(),
            edcWay: $("#editEdcWay").val(),
            educator: $("#editEducator").val()
        };

        $.ajax({
            url: "/hrms/education/admin/rest/updateEducation",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(educationData),
            success: function(response) {
                showSessionToastMessage("교육 정보 수정 완료!", "success");
                location.reload();
            }
        });
    });
    // 교육 내용 수정
    $("#saveContentBtn").click(function() {
        let contentData = {
            edcNo: $("#editEdcNoContent").val(),
            edcContent: $("#editEdcContent").val()
        };
        $.ajax({
            url: "/hrms/education/admin/rest/updateContent",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(contentData),
            success: function(response) {
                showSessionToastMessage("교육 내용 수정 완료!", "success");
                location.reload();
            }
        });
    });
    // 교재 수정
    $("#saveBookBtn").click(function() {
        let selectedBookNo = $("#bookNo").val();
        let edcNo = $("#editEdcNoBook").val();
        //console.log("저장될 교육 ID:", edcNo);
        //console.log("저장될 책 ID (bookNo):", selectedBookNo);
        let bookData = {
            edcNo: edcNo,
            bookNo: selectedBookNo
        };
        $.ajax({
            url: "/hrms/education/admin/rest/updateBook",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(bookData),
            success: function(response) {
                showSessionToastMessage("교재 수정 완료!", "success");
                location.reload();
            },
            error: function(xhr, status, error) {
                console.error("교재 수정 실패:", error);
            }
        });
    });
});
</script>

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

<!-- Daterangepikcer JS -->
<script src="${pageContext.request.contextPath }/assets/js/moment.js"></script>
<script src="${pageContext.request.contextPath }/assets/plugins/daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/bootstrap-datetimepicker.min.js"></script>

<!-- Select2 JS -->
<script src="${pageContext.request.contextPath }/assets/plugins/select2/js/select2.min.js"></script>

<!-- Custom JS -->
<script src="${pageContext.request.contextPath }/assets/js/circle-progress.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/theme-colorpicker.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/script.js"></script>


</body>
</html>
