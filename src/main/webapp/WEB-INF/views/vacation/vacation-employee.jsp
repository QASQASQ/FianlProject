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
						<h2 class="mb-1">나의 휴가기록</h2>
					</div>
				</div>
				<!-- /Breadcrumb -->
				
				<!-- Leaves Info -->
				 <div class="row">
					<div class="col-xl-3 col-md-6">
						<div class="card bg-black-le">
							<div class="card-body">
								<div class="d-flex align-items-center justify-content-between">									
                                    <div class="text-start">
                                        <p class="mb-1">총 연차</p>
                                        <h4>05</h4>                                        
                                    </div>         
                                    <div class="d-flex">
                                        <div class="flex-shrink-0 me-2">
                                            <span class="avatar avatar-md d-flex">
                                                <i class="ti ti-calendar-event fs-32"></i>
                                            </span>
                                        </div>
                                    </div>                          
								</div>
                                <br>
							</div>
						</div>
					</div>
                    <div class="col-xl-3 col-md-6">
						<div class="card bg-purple-le">
							<div class="card-body">
								<div class="d-flex align-items-center justify-content-between">									
                                    <div class="text-start">
                                        <p class="mb-1">남은 연차</p>
                                        <h4>02</h4>                                        
                                    </div>         
                                    <div class="d-flex">
                                        <div class="flex-shrink-0 me-2">
                                            <span class="avatar avatar-md d-flex">
                                                <i class="ti ti-hexagon-letter-c fs-32"></i>
                                            </span>
                                        </div>
                                    </div>                          
								</div>
                                <br>                                
							</div>
						</div>
					</div>	
					<div class="col-xl-3 col-md-6">
						<div class="card bg-pink-le">
							<div class="card-body">
								<div class="d-flex align-items-center justify-content-between">									
                                    <div class="text-start">
                                        <p class="mb-1">사용한 연차</p>
                                        <h4>07</h4>                                        
                                    </div>         
                                    <div class="d-flex">
                                        <div class="flex-shrink-0 me-2">
                                            <span class="avatar avatar-md d-flex">
                                                <i class="ti ti-hexagonal-prism-plus fs-32"></i>
                                            </span>
                                        </div>
                                    </div>                          
								</div>
                                <br>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-md-6">
						<div class="card bg-blue-le">
							<div class="card-body">
								<div class="d-flex align-items-center justify-content-between">									
                                    <div class="text-start">
                                        <p class="mb-1">사용한 병가</p>
                                        <h4>11</h4>                                        
                                    </div>         
                                    <div class="d-flex">
                                        <div class="flex-shrink-0 me-2">
                                            <span class="avatar avatar-md d-flex">
                                                <i class="ti ti-vaccine fs-32"></i>
                                            </span>
                                        </div>
                                    </div>                          
								</div>
								<br>
							</div>
						</div>
					</div>
												
                    							
				 </div>
				 <!-- /Leaves Info -->
				 
				<!-- Leads List -->
				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>휴가기록</h5>
						<div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="date" class="form-control" id="dateStart">
								</div>
							</div>
							~
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="date" class="form-control" id="dateEnd">
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
							<table class="table datatable">
								<thead class="thead-light">
									<tr>
										<th class="text-center">휴가 출발일</th>
										<th class="text-center">휴가 복귀일</th>
										<th class="text-center">사용한 휴가 일수</th>
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
				<!-- /Leads List -->

			</div>

			<div class="footer d-sm-flex align-items-center justify-content-between border-top bg-white p-3">
				<p class="mb-0">2014 - 2025 &copy; SmartHR.</p>
				<p>Designed &amp; Developed By <a href="javascript:void(0);" class="text-primary">Dreams</a></p>
			</div>

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
const userId = sessionStorage.getItem("userId");
let dataTableTbody = $("#dataTable-tbody");
let pagingArea = $("#pagingArea");
let dateStart = $("#dateStart");
let dateEnd = $("#dateEnd");
let searchBtn = $("#searchBtn");

$(function(){
	getMyVacation(1);
	searchBtn.on("click", function(){
		let dateStart = $("#dateStart").val();
		let dateEnd = $("#dateEnd").val();
		getMyVacation(1, dateStart, dateEnd);
	});
	
	pagingArea.on("click", "a", function(){
		event.preventDefault();
		let page = $(this).data("page");
		let dateStart = $("#dateStart").val();
		let dateEnd = $("#dateEnd").val();
		getMyVacation(page, dateStart, dateEnd);
	});
});

// 휴가 기록 가져오기
function getMyVacation(page, dateStart, dateEnd){
	let data = {currentPage:page, emplNo:userId};
	if(dateStart != null)data.dateStart = dateStart;
	if(dateEnd != null)data.dateEnd = dateEnd;
	$.ajax({
		url : "/vacation/getMyVacation",
		data : JSON.stringify(data),
		type : "POST",
		contentType : "application/json;charset=utf-8",
		success : function(res){
			let tr = "";
			for(let i=0; i<res.vacationList.length; i++){
				let vacationDay = getDateDifference(res.vacationList[i].hisEdate.substr(0,11), res.vacationList[i].hisSdate.substr(0,11))
				tr += `
					<tr>
						<td class="text-center">\${res.vacationList[i].hisSdate.substr(0,11)}</td>
						<td class="text-center">\${res.vacationList[i].hisEdate.substr(0,11)}</td>
						<td class="text-center">\${vacationDay}일</td>
					<tr>
				`;
			}
			dataTableTbody.html(tr);
			pagingArea.html(res.pageVO.pagingHTML);
		},
		error : function(){}
	});
}

function getDateDifference(date1, date2) {
    const d1 = new Date(date1);
    const d2 = new Date(date2);

    const diffMs = Math.abs(d2 - d1);

    return Math.floor(diffMs / (1000 * 60 * 60 * 24));
}
</script>
</html>