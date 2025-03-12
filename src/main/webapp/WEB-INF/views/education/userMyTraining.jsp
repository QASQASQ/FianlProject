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
	<title>나의 교육목록</title>
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<div id="global-loader">
		<div class="page-loader"></div>
	</div>
	<div class="main-wrapper">
		<%@ include file="/WEB-INF/views/theme/header.jsp" %>
		<%@ include file="/WEB-INF/views/theme/sidebar.jsp" %>
		
		<div class="page-wrapper">
			<div class="content"> <!-- 큰 틀 -->
				<div class="d-md-flex d-block align-items-center justify-content-between page-breadcrumb mb-3"> <!-- Breadcrumb -->
					<div class="my-auto mb-2">
						<h2 class="mb-1">나의 교육조회</h2>
					</div>
				</div>                                                                                          <!-- /Breadcrumb -->
				
				<!-- 첫 번째 카드 -->
				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>수강중인 교육목록</h5>
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
							<input type="button" class="btn btn-primary d-flex align-items-center" value="검색" id="searchBtn">
						</div>
					</div>
					<div class="card-body p-0"> <!-- CARD CARD CARDCARDCARDCARDCARDCARDCARDCARDCARDCARDCARDCARD -->
						<div class="custom-datatable-filter table-responsive">
							<table class="table datatable">
								<thead class="thead-light">
									<tr style="text-align: center;">
										<th>강의제목</th>
										<th>교육담당</th>
										<th>교육해당부서</th>
										<th>교육대상직급</th>
										<th>수강상태</th>
										<th>수강기간</th>
										<th>수강신청일</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="dataTable-tbody">
								</tbody> 
							</table>
						</div>
					</div>
					<div id="pagingArea" style="display: flex; justify-content: center; align-items: center; padding:15px;"></div>
					<script>
						let searchBtn = $("#searchBtn");
						let pagingArea = $("#pagingArea");
						
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
						        url: "/hrms/education/user/rest/getEducationMyList",
						        type: "POST",
						        data: JSON.stringify(data),
						        contentType: "application/json;charset=utf-8",
						        success: function (res) {
						            console.log("첫 번째 카드 응답 데이터:", res);

						            let tr = "";
						            let today = new Date();

						            if (res.eduAllList && res.eduAllList.length > 0) {
						            	res.eduAllList.forEach(function(edu) {
						            	    let recruitPeriod = `${edu.recruitSdateFormatted} ~ ${edu.recruitEdateFormatted}`;
						            	    let edcPeriod = `${edu.edcSdateFormatted} ~ ${edu.edcEdateFormatted}`;
						            	    let eeCdate = `${edu.edcEeCdateFormatted}`;
						            	    let edcEndDate = new Date(edu.edcEdateFormatted);
						            	    if (edcEndDate > today) {
						            	    tr += `
												<tr>
							            	    	<td style="text-align: center;">\${edu.edcTitle}</td>
						                            <td style="text-align: center;">\${edu.educator}</td>
						                            
						                            <td style="text-align: center;">\${edu.edcTarget}</td>
						                            <td style="text-align: center;">\${edu.edcGrade}</td>
						                            <td style="text-align: center;">\${edu.eeStatus}</td>
						                            
						                            <td style="text-align: center;">
						                                <span class="text-nowrap">\${edu.edcSdateFormatted} ~ \${edu.edcEdateFormatted}</span>
						                            </td>
						                            <td style="text-align: center;">\${edu.eeCdate}</td>
						                            <td style="text-align: center;">
							                            <div class="mb-2">
															<a href=/hrms/education/user/userMyTrainingLecture/\${edu.edcNo}  class="btn btn-primary">자세히보기</a>
														</div>
						                            </td>
						            	        </tr>	
						            	    `;
						            	    }
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
				<!-- / 첫 번째 카드 -->
				
				
				
				<!-- 두 번째 카드 -->
				<div class="card">
				    <div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
				        <h5>지난 수강기록 전체조회</h5>
				        <div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
				            <div class="me-3">
				                <div class="input-icon-end position-relative">
				                    <input type="text" class="form-control" placeholder="강의제목" style="width: 100px;" id="edcTitleAll">
				                </div>
				            </div>
				            <div class="me-3">
				                <div class="input-icon-end position-relative">
				                    <input type="text" class="form-control" placeholder="교육담당" style="width: 100px;" id="educatorAll">
				                </div>
				            </div>
				            <input type="button" class="btn btn-primary d-flex align-items-center" value="검색" id="searchBtnAll">
				        </div>
				    </div>
				    <div class="card-body p-0">
				        <div class="custom-datatable-filter table-responsive">
				            <table class="table datatable">
				                <thead class="thead-light">
				                    <tr style="text-align: center;">
				                        <th>강의제목</th>
				                        <th>교육담당</th>
				                        <th>교육해당부서</th>
				                        <th>교육대상직급</th>
				                        <th>수강상태</th>
				                        <th>수강기간</th>
				                        <th>수강신청일</th>
				                        <th></th>
				                    </tr>
				                </thead>
				                <tbody id="dataTable-History-tbody">
				                </tbody>
				            </table>
				        </div>
				    </div> <!-- /div class="card-body p-0" -->
				    <div id="pagingAreaAll" style="display: flex; justify-content: center; align-items: center; padding:15px;"></div>
				</div>
				
				<script>
				    let searchBtnAll = $("#searchBtnAll");
				    let pagingAreaAll = $("#pagingAreaAll");
				
				    $(function () {
				        // 검색 버튼 클릭 이벤트
				        searchBtnAll.on("click", function () {
				            let edcTitle = $("#edcTitleAll").val();
				            let educator = $("#educatorAll").val();
				            let edcSort = $("#edcSortAll").val();
				            let edcTarget = $("#edcTargetAll").val();
				
				            console.log("검색어들 : ", edcTitle, educator, edcSort, edcTarget);
				            getAllHistoryList(1, edcTitle, educator, edcSort, edcTarget);
				        });
				
				        // 페이징 처리 이벤트
				        pagingAreaAll.on("click", "a", function (event) {
				            event.preventDefault();
				            let page = $(this).data("page");
				            let edcTitle = $("#edcTitleAll").val();
				            let educator = $("#educatorAll").val();
				            let edcSort = $("#edcSortAll").val();
				            let edcTarget = $("#edcTargetAll").val();
				
				            getAllHistoryList(page, edcTitle, educator, edcSort, edcTarget);
				        });
				    });
				
				    function getAllHistoryList(page, edcTitle, educator, edcSort, edcTarget) {
				        let pagingArea = $("#pagingAreaAll");
				        let dataTable_History_tbody = $("#dataTable-History-tbody");
				        let data = { page: page };
				
				        if (edcTitle) data.edcTitle = edcTitle;
				        if (educator) data.educator = educator;
				        if (edcSort) data.edcSort = edcSort;
				        if (edcTarget) data.edcTarget = edcTarget;
				
				        console.log("전송 데이터:", data);
				
				        $.ajax({
				            url: "/hrms/education/user/rest/getEducationHistoryList", // AJAX URL 변경 가능
				            type: "POST",
				            data: JSON.stringify(data),
				            contentType: "application/json;charset=utf-8",
				            success: function (res) {
				                console.log("두 번째 카드 응답 데이터:", res);
								console.log(res.eduAllList);
				                let tr = "";
				                let today = new Date();
				                
				                if (res.eduAllList && res.eduAllList.length > 0) {
				                    res.eduAllList.forEach(function (edu) {
				                    	let edcEndDate = new Date(edu.edcEdateFormatted); // 수강 종료일
				                    	let edcPeriod = `\${edu.edcSdateFormatted} ~ \${edu.edcEdateFormatted}`;
				                        let eeCdate = `\${edu.edcEeCdateFormatted}`;
				                        if (edcEndDate < today) {
				                        tr += `
				                            <tr>
				                                <td style="text-align: center;">\${edu.edcTitle}</td>
				                                <td style="text-align: center;">\${edu.educator}</td>
				                                <td style="text-align: center;">\${edu.edcTarget}</td>
				                                <td style="text-align: center;">\${edu.edcGrade}</td>
				                                <td style="text-align: center;">\${edu.eeStatus}</td>
				                                <td style="text-align: center;">
				                                    <span class="text-nowrap">\${edcPeriod}</span>
				                                </td>
				                                <td style="text-align: center;">\${edu.eeCdate}</td>
				                                <td style="text-align: center;">
				                                    <div class="mb-2">
				                                        <a href="/hrms/education/user/userMyTrainingLecture/\${edu.edcNo}" class="btn btn-primary">자세히보기</a>
				                                    </div>
				                                </td>
				                            </tr>
				                        `;
				                        }
				                    });
				                    dataTable_History_tbody.html(tr);
				                } else {
				                	dataTable_History_tbody.html(`<tr><td colspan="8" class="text-center">데이터가 없습니다.</td></tr>`);
				                }
				                pagingArea.html(res.pageVO.pagingHTML);
				            },
				            error: function (error) {
				                console.log("AJAX 요청 실패", error);
				            },
				        });
				    }
				</script>
				<script>
				    $(document).ready(function() {
				        getList(1);  // 첫 번째 카드 AJAX 실행
				        getAllHistoryList(1);  // 두 번째 카드 AJAX 실행
				    });
				</script>
				<!-- / 두 번째 카드 -->

				<!-- / 두 번째 카드 -->
				
			</div> <!-- 큰 틀 -->
			<div class="footer d-sm-flex align-items-center justify-content-between border-top bg-white p-3">
				<p class="mb-0">2001 - 2025 &copy; HRMS.</p>
				<p>Designed &amp; Developed By <a href="javascript:void(0);" class="text-primary">HERMES</a></p>
			</div>
		</div>
		<!-- /Page Wrapper -->
		
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