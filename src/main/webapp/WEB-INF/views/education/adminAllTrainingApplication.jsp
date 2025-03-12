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
	<title>교육수강신청 관리</title>
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
.btn-group {
    display: flex;
    gap: 8px;
    justify-content: center; 
}

.accept-btn {
    background-color: #FFC107 !important;
    color: black !important;
    border: none;
    padding: 6px 12px;
    border-radius: 5px;
}

.fail-btn {
    background-color: #DC3545 !important; 
    color: white !important;
    border: none;
    padding: 6px 12px;
    border-radius: 5px;
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
		
		<div class="page-wrapper">
			<div class="content">
				<!-- Breadcrumb -->
				<div class="d-md-flex d-block align-items-center justify-content-between page-breadcrumb mb-3">
					<div class="my-auto mb-2">
						<h2 class="mb-1">교육수강신청 관리</h2>
					</div>
				</div>
				<!-- /Breadcrumb -->
				<!-- Leads List -->
				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>수강신청자 목록</h5>
						<div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="text" class="form-control" placeholder="신청자명" style="width: 100px;">
								</div>
							</div>
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="text" class="form-control" placeholder="강의제목" style="width: 100px;" id="edcTitle">
								</div>
							</div>
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="text" class="form-control" placeholder="교육해당부서" style="width: 160px;" id="edcTarget">
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
										<th style="text-align: center;">신청자명</th>
										<th style="text-align: center;">강의제목</th>
										<th style="text-align: center;">교육담당</th>
										<th style="text-align: center;">교육해당부서</th>
										<th style="text-align: center;">교육대상직급</th>
										<th style="text-align: center;">수강신청일자</th>
										<th style="text-align: center;">수강기간</th>
										<th style="text-align: center;">승인/반려</th>
									</tr>
								</thead>
								<tbody id="dataTable-tbody">
								</tbody> 
							</table>
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
						    let data = { page: page };
						    if (edcTitle != null) data.edcTitle = edcTitle;
						    if (educator != null) data.educator = educator;
						    if (edcSort != null) data.edcSort = edcSort;
						    if (edcTarget != null) data.edcTarget = edcTarget;
						    
						    console.log("전송 데이터:", data);

						    $.ajax({
						        url: "/hrms/education/admin/rest/getEduApplicationAllList",
						        type: "POST",
						        data: JSON.stringify(data),
						        contentType: "application/json;charset=utf-8",
						        success: function (res) {
						            console.log("응답 데이터:", res);

						            let tr = "";

						            if (res.eduAllList && res.eduAllList.length > 0) {
						            	res.eduAllList.forEach(function(edu) {
						            	    let edcPeriod = `${edu.edcSdateFormatted} ~ ${edu.edcEdateFormatted}`;
											
						            	    tr += `
												<tr>
						            	    		<td style="text-align: center;">\${edu.emplNm}(\${edu.edcAplc})</td>
						            	    		<td style="text-align: center;">
								            	        <p class="fs-14 text-dark fw-medium">
								            	            <a href="/hrms/education/user/userTrainingDetail/\${edu.edcNo}">
								            	                \${edu.edcTitle}
								            	            </a>
								            	        </p>
								            	    </td>
								            	    <td style="text-align: center;">
								            	        <p class="fs-14 text-dark fw-medium">
								            	            <a href="/hrms/education/user/userTrainingDetail/\${edu.edcNo}">
								            	                \${edu.educator}
								            	            </a>
								            	        </p>
								            	    </td>
								            	    <td style="text-align: center;">\${edu.edcTarget}</td>
								            	    <td style="text-align: center;">\${edu.edcGrade}</td>
								            	    <td style="text-align: center;">\${formatPreviousDateTime(edu.erDate)}</td>
						                            <td style="text-align: center;">
						                                <span class="text-nowrap">\${edu.edcSdateFormatted} ~ \${edu.edcEdateFormatted}</span>
						                            </td>
						                            <td style="text-align: center;">
							                            <div class="mb-2">
															<button class="btn btn-primary accept-btn" >승인</a>
															<button class="btn btn-primary cancel-btn">반려</a>
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
		<script>
		function formatPreviousDateTime(dateString) {
		    if (!dateString) return "";

		    let date = new Date(dateString);
		    let year = date.getFullYear();
		    let month = String(date.getMonth() + 1).padStart(2, "0");
		    let day = String(date.getDate()).padStart(2, "0");
		    let hours = String(date.getHours()).padStart(2, "0");
		    let minutes = String(date.getMinutes()).padStart(2, "0");

		    return `\${year}-\${month}-\${day} \${hours}:\${minutes}`;
		}
		</script>
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
		<script>
		$(document).ready(function () {
		    $(document).on("click", ".accept-btn", function () {
		        let row = $(this).closest("tr");

		        let requestData = {
		            edcAplc: row.find("td:first").text().match(/\((.*?)\)/)[1],
		            edcNo: row.find("a").attr("href").split("/").pop(), 
		            edcTitle: row.find("td:nth-child(2) a").text(), 
		            educator: row.find("td:nth-child(3) a").text(),
		            edcPeriod: row.find("td:nth-child(4)").text().trim(), 
		            edcSort: row.find("td:nth-child(5)").text().trim(), 
		            edcTarget: row.find("td:nth-child(6)").text().trim(),
		            erDate: row.find("td:nth-child(7)").text().trim(), 
		            erStatus: "Y" 
		        };
		        console.log("보낼 데이터:", requestData);
		        updateRequestStatus(requestData);
		    }); 

		    // 반려 버튼 클릭 이벤트
		    $(document).on("click", ".cancel-btn", function () {
		        let row = $(this).closest("tr");
		        let requestData = {
		            edcAplc: row.find("td:first").text().match(/\((.*?)\)/)[1],
		            edcNo: row.find("a").attr("href").split("/").pop(),
		            erStatus: "N" // 반려 상태
		        };
		        console.log("보낼 데이터:", requestData);
		        updateRequestStatus(requestData);
		    });
		    
		    /*
		    responseData
		    
		    {edcAplc: "202501002", edcNo: "115",…}
		    edcAplc
		    :  "202501002"
		    edcNo
		    : "115"
		    edcPeriod
		    : "2025-02-19 ~ 2025-02-19"
		    edcSort
		    : "경영"
		    edcTarget
		    : "전체"
		    edcTitle
		    : "\n\t\t\t\t\t\t\t\t            \t                테스트수업\n\t\t\t\t\t\t\t\t            \t            "
		    educator
		    : "\n\t\t\t\t\t\t\t\t            \t                sdsd\n\t\t\t\t\t\t\t\t            \t            "
		    erDate
		    : "2025-02-27T00:00:00.000+00:00"
		    erStatus
		    : "Y"
		    
		    */
		    function updateRequestStatus(requestData) {
		        $.ajax({
		            url: "/hrms/education/admin/rest/updateEdcRequestStatus",
		            type: "POST",
		            contentType: "application/json",
		            data: JSON.stringify(requestData),
		            success: function (response) {
		                alert(requestData.erStatus === "Y" ? "승인 완료!" : "반려 완료!");
		                location.reload();
		            },
		            error: function (xhr, status, error) {
		                console.error("처리 실패:", xhr.responseText);
		                alert("처리 중 오류가 발생했습니다.");
		            }
		        });
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