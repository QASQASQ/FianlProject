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
	<title>전체교육목록</title>
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
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
						<h2 class="mb-1">전체교육목록</h2>
					</div>
				</div>
				<!-- /Breadcrumb -->
				<!-- Leads List -->
				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>전체교육목록</h5>
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
										<th style="text-align: center;">강의제목</th>
										<th style="text-align: center;">교육담당</th>
										<th style="text-align: center;">수강정원</th>
										<th style="text-align: center;">교육해당부서</th>
										<th style="text-align: center;">교육대상</th>
										<th style="text-align: center;">모집기간</th>
										<th style="text-align: center;">수강기간</th>
										<th style="text-align: center;"></th>
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
								let edcNo = $("edcNo");
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
						
						function getList(page, edcTitle, educator, edcSort, edcTarget, edcNo) {
						    let pagingArea = $("#pagingArea");
						    let dataTable_tbody = $("#dataTable-tbody");
						    let data = { page: page };

						    if (edcNo != null) data.edcNo = edcNo;
						    if (edcTitle != null) data.edcTitle = edcTitle;
						    if (educator != null) data.educator = educator;
						    if (edcSort != null) data.edcSort = edcSort;
						    if (edcTarget != null) data.edcTarget = edcTarget;
						    
						    console.log("전송 데이터:", data);

						    $.ajax({
						        url: "/hrms/education/user/rest/getEducationAllList",
						        type: "POST",
						        data: JSON.stringify(data),
						        contentType: "application/json;charset=utf-8",
						        success: function (res) {
						            let tr = "";
						            let today = new Date();   // 오늘날짜 받아오기

						            if (res.eduAllList && res.eduAllList.length > 0) {
						            	res.eduAllList.forEach(function(edu) {
						            		let recruitEdate = new Date(edu.recruitEdateFormatted); 
						            	    let recruitPeriod = `\${edu.recruitSdateFormatted} ~ \${edu.recruitEdateFormatted}`;
						            	    let edcPeriod = `\${edu.edcSdateFormatted} ~ \${edu.edcEdateFormatted}`;

						                    let enrollButton;
						                    if (recruitEdate < today) {
						                        enrollButton = `<button class="btn btn-secondary" disabled>수강마감</button>`;
						                    } else {
						                        enrollButton = `<button class="btn btn-primary enroll-btn" data-edc-no="\${edu.edcNo}">수강신청</button>`;
						                    }
						                    
						            	    tr += `
												<tr>
							            	    	<td>
								            	        <p class="fs-14 text-dark fw-medium">
								            	            <a href="/hrms/education/user/userTrainingDetail/\${edu.edcNo}">
								            	                \${edu.edcTitle}
								            	            </a>
								            	        </p>
								            	    </td>
						                            <td style="text-align: center;">\${edu.educator}</td>
						                            <td style="text-align: center;">\${edu.edcPsncpa}</td>
						                            <td>\${edu.edcTarget}</td>
						                            <td style="text-align: center;">\${edu.edcGrade}</td>
						                            <td style="text-align: center;">
						                                <span class="text-nowrap">\${edu.recruitSdateFormatted} ~ \${edu.recruitEdateFormatted}</span>
						                            </td>
						                            <td style="text-align: center;">
						                                <span class="text-nowrap">\${edu.edcSdateFormatted} ~ \${edu.edcEdateFormatted}</span>
						                            </td>
						                            <td style="text-align: center;">
								                        <div class="mb-1">\${enrollButton}</div>
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
		
		<%
		    String edcAplc = (String) session.getAttribute("edcAplc");
		%>

		<script>
		function formatDateTime(dateString) {
		    if (!dateString) return "";
		    
		    let date = new Date(dateString);
		    let year = date.getFullYear();
		    let month = String(date.getMonth() + 1).padStart(2, "0");
		    let day = String(date.getDate()).padStart(2, "0");
		    
		    return `\${year}-\${month}-\${day}`;
		}
	</script>
	<%
	    String emplNo = (String) session.getAttribute("emplNo");
	%>
	<script>
	    let edcAplc = "<%= emplNo %>";

	    $(document).ready(function () {
	    	$("#dataTable-tbody").on("click", ".enroll-btn", function () {
	            let edcNo = $(this).data("edcNo");

	            let today = new Date();
	            let year = today.getFullYear();
	            let month = String(today.getMonth() + 1).padStart(2, "0");
	            let day = String(today.getDate()).padStart(2, "0");
	            let hours = String(today.getHours()).padStart(2, "0");
	            let minutes = String(today.getMinutes()).padStart(2, "0");

	            let erDate = `\${year}-\${month}-\${day} \${hours}:\${minutes}`;  // 수정된 형식 적용

	            if (!edcAplc) {
	            	showToastMessage("로그인 정보가 없습니다. 다시 로그인해주세요.", "warning");
	                return;
	            }

	            let requestData = {
	                edcAplc: edcAplc,  // 로그인한 사용자 ID
	                edcNo: edcNo,
	                erDate: erDate,  // yyyy/MM/dd 형식
	                erStatus: ''
	            };
	            // console.log("보낼 데이터:", requestData);
	            $.ajax({
	                url: "/hrms/education/user/rest/insertEdcReqeust",
	                type: "POST",
	                contentType: "application/json",
	                data: JSON.stringify(requestData),
	                success: function (response) {
	                    showSessionToastMessage("수강 신청 완료!", "success");
	                    location.reload();
	                },
	                error: function (xhr, status, error) {
	                    console.error("수강 신청 실패:", xhr.responseText);
	                    showToastMessage("이미 수강신청한 과목입니다.", "warning");
	                }
	            });
	        });
	    	
	    	
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