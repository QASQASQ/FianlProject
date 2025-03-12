<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
	<meta name="description" content="Smarthr - Bootstrap Admin Template">
	<meta name="keywords" content="admin, estimates, bootstrap, business, html5, responsive, Projects">
	<meta name="author" content="Dreams technologies - Bootstrap Admin Template">
	<meta name="robots" content="noindex, nofollow">
	<title>Smarthr Admin Template</title>

</head>

<body>

	<div id="global-loader" style="display: none;">
		<div class="page-loader"></div>
	</div>

	<!-- Main Wrapper -->
	<div class="main-wrapper">

		
		<!-- Header -->
		 <%@ include file="/WEB-INF/views/theme/header.jsp" %>
		<!-- /Header -->

		<!-- Sidebar -->
		<%@ include file="/WEB-INF/views/theme/sidebar.jsp" %>
		<!-- /Sidebar -->

		<!-- Page Wrapper -->
		<div class="page-wrapper">
			<div class="content">

				<!-- Breadcrumb -->
				<div class="d-md-flex d-block align-items-center justify-content-between page-breadcrumb mb-3">
					<div class="my-auto mb-2">
						<h2 class="mb-1">부서원 휴가보유현황</h2>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<!-- Leads List -->
				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>휴가보유현황</h5>
						<div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="text" class="form-control" placeholder="사원명" style="width: 100px;" id="emplNm">
								</div>
							</div>
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="text" class="form-control" placeholder="사번" style="width: 100px;" id="emplNo">
								</div>
							</div>
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="button" class="btn btn-primary d-flex align-items-center" value="검색" id="searchBtn">
								</div>
							</div>
							<div class="dropdown me-3">
							</div>
							<div class="dropdown">
							</div>
						</div>
					</div>
					<div class="card-body p-0">
						<div class="custom-datatable-filter table-responsive">
							<table class="table datatable text-center">
								<thead class="thead-light">
									<tr>
										<th>사번</th>
										<th>사원명</th>
										<th>직급</th>
										<th>팀</th>
										<th>사용일수</th>
										<th>남은일수</th>
										<th>총일수</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="dataTable-tbody">
									<tr>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div id="pagingArea" style="display: flex; justify-content: center; align-items: center; padding:15px;">
						
					</div>
				</div>
				<!-- /Leads List -->

			</div>

			<!-- Footer -->
			<%@ include file="/WEB-INF/views/theme/footer.jsp" %>
			<!-- /Footer -->

		</div>
		<!-- /Page Wrapper -->

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
<script>
let deptCode = "${emp.deptCode}";
const userId = sessionStorage.getItem("userId");
let searchBtn = $("#searchBtn");
let pagingArea = $("#pagingArea");
let dataTableTbody = $("#dataTable-tbody");
	
$(function(){
	if(!sessionStorage.getItem("currentPage")){
		getList(1);
	}else{
		getList(sessionStorage.getItem("currentPage"));
	}
	
	searchBtn.on("click", function(){
		let emplNo = $("#emplNo");
		let emplNm = $("#emplNm");
		getList(1, emplNm.val(), emplNo.val());
	});
	
	pagingArea.on("click", "a", function(){
		event.preventDefault();
		let page = $(this).data("page");
		let emplNo = $("#emplNo");
		let emplNm = $("#emplNm");
		getList(page, emplNm.val(), emplNo.val());
	});
	
	$(document).on("click", "#detailButton", function() {
		let emplNo = $(this).closest("tr").find("td:first").text().trim();
		location.href = "/hrms/vacation/authorityDetailPage?emplNo=" + emplNo;
	});
	
});

// 페이지, 부터, 까지, 사번, 사원명 을 매개값으로 받는 목록가져오기 함수
// 사번을 가져갈때는 나의사번과 검색어의사번 총두개를 가져가야함
function getList(page, emplNm, emplNo){
	data = {currentPage : page, deptCode : deptCode}; // 페이지는 항상있어야하기때문에 객체에넣고 초기화
	// 매개값이 존재할때 객체에 추가
	if(emplNm != null && emplNm != "") {data.emplNm = emplNm};
	if(emplNo != null && emplNo != "") {data.emplNo = emplNo};
	console.log(data);
	$.ajax({
		url : "/vacation/getMemberVacation",
		type : "post",
		data : JSON.stringify(data),
		contentType : "application/json;charset=utf-8",
		success : function(res){
			console.log("성공", res);
			let tr = "";
			for(let i=0; i<res.emplList.length; i++){
				tr += `
					<tr>
						<td>\${res.emplList[i].emplNo}</td>
						<td>\${res.emplList[i].emplNm}</td>
						<td>\${res.emplList[i].emplPosition}</td>
						<td>\${res.emplList[i].teamCode}</td>
						<td>\${res.emplList[i].yearlyVacationVO.yrycUsage}</td>
						<td>\${res.emplList[i].yearlyVacationVO.yrycRemndr}</td>
						<td>\${res.emplList[i].yearlyVacationVO.yrycTotal}</td>
						<td><button class="btn btn-primary d-flex align-items-center" id="detailButton">자세히보기</button></td>
					<tr>
				`;
			}
			dataTableTbody.html(tr);
			pagingArea.html(res.pageVO.paginHTML);
		},
		error : function(error){
			console.log("실패");
		},
	});
}
</script>
</html>