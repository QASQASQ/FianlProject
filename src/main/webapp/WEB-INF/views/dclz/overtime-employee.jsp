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
						<h2 class="mb-1">나의 연장근무 기록</h2>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<!-- Leads List -->
				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>연장근무 기록</h5>
						<div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="date" class="form-control date-range bookingrange" id="dateStart">
								</div>
							</div>
							~&nbsp;&nbsp;&nbsp;
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="date" class="form-control date-range bookingrange" id="dateEnd">
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
										<th>일자</th>
										<th>시작시각</th>
										<th>종료시각</th>
										<th>근무 시간</th>
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

			<%@ include file="/WEB-INF/views/theme/footer.jsp" %>

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
let searchBtn = $("#searchBtn");
let dataTableTbody = $("#dataTable-tbody");
let pagingArea = $("#pagingArea");

$(function(){
	getList(1);
	
	searchBtn.on("click", function(){
		let dateStart = $("#dateStart");
		let dateEnd = $("#dateEnd");
		console.log("검색어들 : ", dateStart.val(), dateEnd.val())
		getList(1, dateStart.val(), dateEnd.val());
	});
	
	pagingArea.on("click", "a", function(){
		event.preventDefault();
		let page = $(this).data("page");
		let dateStart = $("#dateStart");
		let dateEnd = $("#dateEnd");
		getList(page, dateStart.val(), dateEnd.val());
	})
});

function getList(page, dateStart, dateEnd){
	data = {currentPage : page, emplNo : userId,};
	if(dateStart != null && dateStart != '') data.dateStart = dateStart;
	if(dateEnd != null && dateEnd != '') data.dateEnd = dateEnd;
	$.ajax({
		url : "/dclz/getOvertimeList",
		type : "post",
		data : JSON.stringify(data),
		contentType : "application/json;charset=utf-8",
		success : function(res){
			console.log(res);
			let tr = "";
			for(let i=0; i<res.historyList.length; i++){
				let hisSdate = res.historyList[i].hisSdate.substring(0,11);
				let hisStime = res.historyList[i].hisStime.substring(10,20);
				let hisEtime = res.historyList[i].hisEtime.substring(10,20);
				
				let diffSeconds = timeStringToSeconds(hisEtime) - timeStringToSeconds(hisStime);
				let diffHours = Math.floor(diffSeconds / 3600);
				let diffMinutes = Math.floor((diffSeconds % 3600) / 60);
				
				tr += `
					<tr>
						<td>\${hisSdate}</td>
						<td>\${hisStime}</td>
						<td>\${hisEtime}</td>
						<td>\${diffHours}시간\${diffMinutes}분</td>
					</tr>
					`;
			}
			dataTableTbody.html(tr);
			pagingArea.html(res.pageVO.pagingHTML);
		},
		error : function(){},
	});
	
}
function timeStringToSeconds(timeStr) {
	const [hours, minutes, seconds] = timeStr.split(':').map(Number);
	return hours * 3600 + minutes * 60 + seconds;
}
</script>
</html>