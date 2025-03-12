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
		
		<!-- 모달창들 -->
		<%@ include file="/WEB-INF/views/theme/modal.jsp" %>
		<!-- /모달창들 -->

		<!-- Page Wrapper -->
		<div class="page-wrapper">
			<div class="content">

				<!-- Breadcrumb -->
				<div class="d-md-flex d-block align-items-center justify-content-between page-breadcrumb mb-3">
					<div class="my-auto mb-2">
						<h2 class="mb-1" id="commuteList">출근기록</h2>
					</div>
					<div class="d-flex my-xl-auto right-content align-items-center flex-wrap">
						<div class="mb-2">
							<button data-bs-toggle="modal" data-bs-target="#add_activity" class="btn btn-primary d-flex align-items-center" id="addBtn">등록</button>
						</div>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<!-- Leads List -->
				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>출근기록</h5>
						<div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="date" class="form-control" id="dateStart">
									<!-- <span class="input-icon-addon">
										<i class="ti ti-chevron-down"></i>
									</span> -->
								</div>
							</div>
							~&nbsp;&nbsp;&nbsp;
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
										<th>출근날짜</th>
										<th>출근시각</th>
										<th>퇴근시각</th>
										<th>근무유형</th>
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

			<div class="footer d-sm-flex align-items-center justify-content-between border-top bg-white p-3">
				<p class="mb-0">2014 - 2025 &copy; SmartHR.</p>
				<p>Designed &amp; Developed By <a href="javascript:void(0);" class="text-primary">Dreams</a></p>
			</div>

		</div>
		<!-- /Page Wrapper -->
		
	</div>
	<!-- /Main Wrapper -->
	<!-- Add Activiy -->
		<div class="modal fade" id="add_activity">
			<div class="modal-dialog modal-dialog-centered modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">출근 신규등록</h4>
						<button type="button" class="btn-close custom-btn-close" data-bs-dismiss="modal" aria-label="Close">
							<i class="ti ti-x"></i>
						</button>
					</div>
					<div class="modal-body pb-0">
						<div class="row">
							<div class="col-md-12">
								<div class="mb-3">
									<label class="form-label">출근날짜 </label>
									<input type="date" class="form-control" id="newDclzDate">
								</div>									
							</div>
							<div class="col-md-6">
								<div class="mb-3">
									<label class="form-label">출근시각 </label>
									<input type="time" class="form-control" id="newDclzStime">
								</div>
							</div>
							<div class="col-md-6">
							    <div class="mb-3">
							        <div style="display: flex; justify-content: space-between; align-items: center;">
							            <label class="form-label">퇴근시각</label>
							            <label class="form-label" style="margin-right: 10px;">
							                명일퇴근 <input type="checkbox" id="tomorrow" value="yes">
							            </label>
							        </div>
							        <input type="time" class="form-control" id="newDclzEtime">
							    </div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-light me-2" data-bs-dismiss="modal">닫기</button>
						<button class="btn btn-primary" id="saveBtn">저장</button>
					</div>
				</div>
			</div>
		</div>
	<!-- /Add Activity -->
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
// url 에서 emplNo 가져오기
const url = new URL(window.location.href);
const urlParams = url.searchParams;
let emplNo = urlParams.get('emplNo');

let commuteList = $("#commuteList");
let searchBtn = $("#searchBtn");
let pagingArea = $("#pagingArea");
let dataTableTbody = $("#dataTable-tbody");
let addBtn = $("#addBtn");
let saveBtn = $("#saveBtn");
let dclzNo = "";
let tomorrow = false;
$(function(){
	commuteList.text(emplNo + " 사원의 출근기록")
	getList(1);
	
	$("#tomorrow").change(function() {
	    if ($(this).is(":checked")) {
	        tomorrow = "on";
	    } else {
	    	tomorrow = "off";
	    }
	});
	
	saveBtn.on("click", function(){
		let newDclzDate = $("#newDclzDate").val();
		let newDclzStime = $("#newDclzStime").val();
		let newDclzEtime = $("#newDclzEtime").val();
		newDclzStime = newDclzDate + " " + newDclzStime;
		data = {emplNo:emplNo, dclzDate:newDclzDate, dclzStime:newDclzStime};
		
		if((newDclzDate == null || newDclzStime == '') && (newDclzStime == null || newDclzStime == '')){
			showToastMessage("출근날짜와 출근시각은 반드시 입력해야합니다.", "warning");
		}
		
		if(newDclzEtime != null && newDclzEtime != ''){
			if(tomorrow == "on"){
				let dateObj = new Date(newDclzDate);
				dateObj.setDate(dateObj.getDate() + 1);
				dateObj = dateObj.toISOString().split("T")[0];
				data.dclzEtime = dateObj + " " + newDclzEtime;
			}else{
				data.dclzEtime = newDclzDate + " " + newDclzEtime;
			}
		}
		
		$.ajax({
			url : "/hrms/admin/insertAttendance",
			type : "post",
			data : JSON.stringify(data),
			contentType : "application/json;charset=utf-8",
			success : function(res){
				showToastMessage("등록성공.", "success");
				getList(1);
			},
			error : function(){
				
			}
		});
	});
	
	// 수정버튼 클릭이벤트
	$(document).on("click", ".updateBtn", function() {
		if($(this).text() == "수정"){
		    dclzNo = $(this).closest("tr").find("td:first-child input").val();
		    console.log("dclzNo", dclzNo);
		    
		    // 출,퇴근 td 요서
		    let dclzStimeTd = $(this).closest("tr").find("td:eq(1)");
		    let dclzEtimeTd = $(this).closest("tr").find("td:eq(2)");
		    
		    // 출,퇴근 날짜 + 시각
		    let dclzFullStime = dclzStimeTd.data("full-time");
		    let dclzFullEtime = dclzEtimeTd.data("full-time");
		    
		    console.log("dclzFullStime : ", dclzFullStime);
		    console.log("dclzFullEtime : ", dclzFullEtime);
		    
		    let dclzStimeInput = `<input type="datetime-local" step="60" id="dclzStime" class="form-control" value="\${dclzFullStime}">`;
		    let dclzEtimeInput = `<input type="datetime-local" step="60" id="dclzEtime" class="form-control" value="\${dclzFullEtime}">`;
		    
		    dclzStimeTd.html(dclzStimeInput);
		    dclzEtimeTd.html(dclzEtimeInput);
		    
		    $(this).text("확인");
		} else{
			if($("#dclzStime").val() > $("#dclzEtime").val()){
				showToastMessage("퇴근시각은 출근시각보다 이전일 수 없습니다.", "warning");
				return;
			}
			$.ajax({
				url : "/hrms/admin/updateAttendance",
				data : JSON.stringify({
					dclzNo : dclzNo,
					dclzStime : $("#dclzStime").val().replace("T", " "),
					dclzEtime : $("#dclzEtime").val().replace("T", " "),
				}),
				type : "post",
				contentType : "application/json;charset=utf-8",
				success : function(res){
					if(res == 1){
						showToastMessage("✅ 수정성공.", "success");
						getList(1);
					}else{
						showToastMessage("❌ 수정실패.", "danger");
					}
				},
				error : function(){}
			});
			$(this).text("수정");
		}
	});
	
	// 검색버튼 클릭이벤트, 페이징버튼 클릭이벤트
	searchBtn.on("click", function(){
		let dateStart = $("#dateStart");
		let dateEnd = $("#dateEnd");
		let emplNo = $("#emplNo");
		let emplNm = $("#emplNm");
		console.log("검색어들 : ", dateStart.val(), dateEnd.val(), emplNo.val(), emplNm.val())
		getList(1, dateStart.val(), dateEnd.val(), emplNm.val(), emplNo.val());
	});
	
	pagingArea.on("click", "a", function(){
		event.preventDefault();
		let page = $(this).data("page");
		let dateStart = $("#dateStart");
		let dateEnd = $("#dateEnd");
		let emplNo = $("#emplNo");
		let emplNm = $("#emplNm");
		getList(page, dateStart.val(), dateEnd.val(), emplNm.val(), emplNo.val());
	})
	
	$("#acceptBtn").click(function () {
		$("#alertWindow, #alertOverlay").fadeOut();
	});
});

function getList(page, dateStart, dateEnd){
	let pagingArea = $("#pagingArea");
	let dataTable_tbody = $("#dataTable-tbody");
	let data = {emplNo:emplNo, page:page};
	if(dateStart != null && dateStart != "") {data.dateStart = dateStart};
	if(dateEnd != null && dateEnd != "") {data.dateEnd = dateEnd};
	$.ajax({
		url : "/hrms/admin/adminAttendance",
		type : "post",
		data : JSON.stringify(data),
		contentType : "application/json;charset=utf-8",
		success : function(res){
			console.log(res);
			let tr = "";
			
			for(let i=0; i<res.dalList.length; i++){
				let dclzDate = res.dalList[i].dclzDate.substr(0,11);
				let dclzStime = res.dalList[i].dclzStime;
				let dclzEtime = "";
				if(res.dalList[i].dclzEtime != null){
					dclzEtime = res.dalList[i].dclzEtime;
				}
				tr += `
					<tr>
						<td><input type="hidden" value="\${res.dalList[i].dclzNo}" class="dclzNo">\${dclzDate}</td>
						<td data-full-time="\${dclzStime}">\${dclzStime.substr(11)}</td>
						<td data-full-time="\${dclzEtime}">\${dclzEtime.substr(11)}</td>
						<td>\${res.dalList[i].dclzStatus}</td>
						<td><button class="btn btn-primary d-flex align-items-center updateBtn">수정</button></td>
					</tr>
				`;
			}
			dataTableTbody.html(tr);
			pagingArea.html(res.pageVO.pagingHTML);
		}
	});
}

</script>
</html>