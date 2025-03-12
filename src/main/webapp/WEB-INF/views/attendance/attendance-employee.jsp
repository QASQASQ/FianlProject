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
<style>
    .progress {
        position: relative;
        height: 30px !important;
        background-color: #e9ecef;
    }
    .progress-bar {
        position: absolute;
        height: 100%;
        transition: left 0.5s ease-in-out, width 0.5s ease-in-out;
    }
</style>
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

		<!-- Page Wrapper -->
		<div class="page-wrapper">
			<div class="content">

				<!-- Breadcrumb -->
				<div class="d-md-flex d-block align-items-center justify-content-between page-breadcrumb mb-3">
					<div class="my-auto mb-2">
						<h2 class="mb-1">출 / 퇴근</h2>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<div class="row">
					<div class="col-xl-3 col-lg-4 d-flex">
						<div class="card flex-fill border-primary attendance-bg">
							<div class="card-body">
								<div class="attendance-circle-progress mx-auto mb-3" style="width:150px;padding-top: 50px;" data-value='65'>
									<div class="mb-3 text-center">
										<h6 class="fw-medium text-gray-5 mb-2">현재 시각</h6>
										<h4 id="clock"></h4>
									</div>
								</div>
								<div class="text-center" style="padding-top: 50px;">
									<div class="fw-medium d-flex align-items-center justify-content-center mb-3">
										<i class="ti ti-fingerprint text-primary me-1"></i>
										출근시간 :  <div id="todayDclzStime"></div>
									</div>
									<div class="fw-medium d-flex align-items-center justify-content-center mb-3">
										<i class="ti ti-fingerprint text-primary me-1"></i>
										퇴근시간 :  <div id="todayDclzEtime"></div>
									</div>
									<button class="btn btn-primary w-100" id="punchOutBtn">출근</button>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-9 col-lg-8 d-flex">
						<div class="row flex-fill">
							<div class="col-xl-3 col-md-6">
								<div class="card">
									<div class="card-body">
										<div class="border-bottom mb-2 pb-2">
											<span class="avatar avatar-sm bg-info mb-2"><i class="ti ti-calendar-up"></i></span>
											<h2 class="mb-2">출근<span class="fs-20 text-gray-5"> </span></h2>
										</div>
										<div>
											<h2>
												<span class="fs-20 text-gray-5" id="NORMAL"> 0일</span>
											</h2>
										</div>
									</div>
								</div>
							</div>
							<div class="col-xl-3 col-md-6">
								<div class="card">
									<div class="card-body">
										<div class="border-bottom mb-2 pb-2">
											<span class="avatar avatar-sm bg-primary mb-2"><i class="ti ti-clock-stop"></i></span>
											<h2 class="mb-2">초과근무<span class="fs-20 text-gray-5"> </span></h2>
										</div>
										<div>
											<h2>
												<span class="fs-20 text-gray-5" id="OVERTIMEHOUR"> 0시간</span>
											</h2>
										</div>
									</div>
								</div>
							</div>
							<div class="col-xl-3 col-md-6">
								<div class="card">
									<div class="card-body">
										<div class="border-bottom mb-2 pb-2">
											<span class="avatar avatar-sm bg-dark mb-2"><i class="ti ti-clock-up"></i></span>
											<h2 class="mb-2">지각</h2>
										</div>
										<div>
											<h2>
												<span class="fs-20 text-gray-5" id="LATE"> 0일</span>
											</h2>
										</div>
									</div>
								</div>
							</div>
							<div class="col-xl-3 col-md-6">
								<div class="card">
									<div class="card-body">
										<div class="border-bottom mb-2 pb-2">
											<span class="avatar avatar-sm bg-pink mb-2"><i class="ti ti-calendar-star"></i></span>
											<h2 class="mb-2">결근</h2>
										</div>
										<div>
											<h2>
												<span class="fs-20 text-gray-5" id="ABSENT"> 0일</span>
											</h2>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="card">
									<div class="card-body">
										<div class="container">
									        <div class="row">
									            <div class="col-md-12">
									            	<div class="mb-3">
									            		<p class="d-flex align-items-center mb-1">
									            			<i class="ti ti-point-filled text-success me-1"></i>금일 근무시간
									            		</p>
								            			<h3 id="workTime">0 시간</h3>
									            	</div>
									            </div>
									
									            <div class="col-md-12 mt-3">
									                <div class="progress">
									                    <div id="progressBar" class="progress-bar bg-primary"></div>
									                </div>
									            </div>
									
									            <div class="col-md-12">
									                <div class="d-flex align-items-center justify-content-between flex-wrap row-gap-2">
									                    <span class="fs-10">06:00</span>
									                    <span class="fs-10">07:00</span>
									                    <span class="fs-10">08:00</span>
									                    <span class="fs-10">09:00</span>
									                    <span class="fs-10">10:00</span>
									                    <span class="fs-10">11:00</span>
									                    <span class="fs-10">12:00</span>
									                    <span class="fs-10">13:00</span>
									                    <span class="fs-10">14:00</span>
									                    <span class="fs-10">15:00</span>
									                    <span class="fs-10">16:00</span>
									                    <span class="fs-10">17:00</span>
									                    <span class="fs-10">18:00</span>
									                    <span class="fs-10">19:00</span>
									                    <span class="fs-10">20:00</span>
									                    <span class="fs-10">21:00</span>
									                    <span class="fs-10">22:00</span>
									                    <span class="fs-10">23:00</span>
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

				<table class="datatable"></table>

				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>나의 출근기록</h5>
						<div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
							<div class="me-3">
								<input type="date" class="form-control" id="dateStart">
							</div>
							~&nbsp;&nbsp;&nbsp;
							<div class="me-3">
								<input type="date" class="form-control" id="dateEnd">
							</div>
							<div>
								<input type="submit" class="btn btn-primary d-flex align-items-center" id="searchBtn" value="검색">
							</div>
						</div>
					</div>
					<div class="card-body p-0">
						<div class="custom-datatable-filter table-responsive">
							<table class="table datatable text-center">
								<thead class="thead-light">
									<tr>
										<th>출근날짜</th>
										<th>출근시각</th>
										<th>퇴근시각</th>
										<th>근무상태</th>
										<th>근무 유형</th>
									</tr>
								</thead>
								<tbody id="dataTable-tbody">
									<tr>
										<td></td>									
									</tr>
								</tbody>
							</table>
							<!-- 페이징 구역 -->
							<div id="pagingArea" style="display: flex; justify-content: center; align-items: center; padding:15px;">
							</div>
							<!-- /페이징 구역 -->
						</div>
					</div>
				</div>

			</div>
			<!-- Footer -->
			<%@ include file="/WEB-INF/views/theme/footer.jsp" %>
			<!-- /Footer -->
		</div>
		<!-- /Page Wrapper -->

	</div>
	<!-- /Main Wrapper -->

</body>
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

<script>
const userId = sessionStorage.getItem("userId");// 이거하면 세션가져올수있음
let clock = $("#clock");					// 현재시각 표시하는 곳
let punchOutBtn = $("#punchOutBtn");		// 출퇴근 버튼
let todayDclzStime = $("#todayDclzStime");	// 오늘 나의 출근시간을 표시하는 곳
let todayDclzEtime = $("#todayDclzEtime");	// 오늘 나의 퇴근시간을 표시하는 곳
let pagingArea = $("#pagingArea");			// 페이지 표시하는 div
let searchBtn = $("#searchBtn");			// 날짜검색버튼
let LATE = $("#LATE");
let OVERTIMEHOUR = $("#OVERTIMEHOUR");
let NORMAL = $("#NORMAL");
let workTime = $("#workTime");

time(); // 시계함수 실행
setInterval(time, 1000); // 시계함수 1초마다 계속실행

$(function(){
	console.log()
	selectThisMonthData();
	printList(1); // 페이지 로드할때 출퇴근목록 출력하기
	getTodayPunchOut();
	
	// 검색 버튼클릭이벤트
	searchBtn.on("click", function(){
		let dateStart = $("#dateStart").val();
		let dateEnd = $("#dateEnd").val();
		printList(1, dateStart, dateEnd);
	});
	// 검색 버튼클릭이벤트 끝
	
	// 페이지 버튼클릭이벤트 여기에 검색어 추가하기
	pagingArea.on("click", "a", function(){
		event.preventDefault();
		let page = $(this).data("page");
		let dateStart = $("#dateStart").val();
		let dateEnd = $("#dateEnd").val();
		printList(page, dateStart, dateEnd);
	});
	// 페이지버튼 클릭이벤트 끝
	
	// 출퇴근버튼 클릭
	punchOutBtn.on("click", function(){
		let btnText = $("#punchOutBtn").text();
		if(btnText == "출근"){ // 버튼의 텍스트가 출근일때 실행
			$.ajax({
				url : "/hrms/attendance/punchOut",
				type : "post",
				data : JSON.stringify({emplNo : userId}),
				contentType: "application/json;charset=utf-8",
				success : function(res){
					showToastMessage("✅출근시간이 기록되었습니다.", "success");
					printList(1);
					getTodayPunchOut();
					todayDclzEtime.text("");
				},
				error : function(error){
					showToastMessage("❌ 출근등록중 오류발생.", "danger");
				}	
			});	
		}else if(btnText == "퇴근"){ // 버튼의 텍스트가 퇴근일때 실행
			$.ajax({
				url : "/hrms/attendance/goHome",
				type : "post",
				data : JSON.stringify({emplNo : userId}),
				contentType: "application/json;charset=utf-8",
				success : function(res){
					showToastMessage("✅퇴근시간이 기록되었습니다.", "success");
					printList(1);
					getTodayPunchOut();
				},
				error : function(error){
					showToastMessage("❌ 퇴근등록중 오류발생.", "danger");
				}				
			});
		}
		selectThisMonthData();
	});
	// 출퇴근버튼 클릭 끝
	
	// 권한을 가져와서 권한에따라 탭을표시, 안표시
	let changeTab = $("#changeTab");
});

function printList(page, dateStart, dateEnd){ // 출퇴근 목록 가져오기
	let data = {page : page, emplNo : userId};
	if(dateStart != null){data.dateStart = dateStart}
	if(dateEnd != null){data.dateEnd = dateEnd}
	$.ajax({
		url : "/hrms/attendance/getMyPunchOut",
		type : "post",
		data : JSON.stringify(data),
		contentType: "application/json;charset=utf-8",
		success : function(res){
			let time = new Date();
			let year = time.getFullYear();
			let month = ("0" + (1 + time.getMonth())).slice(-2);
			let day = ("0" + time.getDate()).slice(-2);
		    let today = year + "-" + month + "-" + day // 오늘날짜 예시)2025-02-05
		    let lastDclzDate = ""; // 가장최근 출근일자를 넣기위한 변수
		    
		    if(res.dalList.length > 0){ // 지금까지 한번도 출근을 안했을수도 있으니까 null체크
				lastDclzDate = res.dalList[0].dclzDate.substr(0,10); // 가장최근 출근을 찍은 일자. 연,월,일만 가져옴 예시)2025-02-05
				let lastDclz = res.dalList[0];

				// 출/퇴근버튼에 텍스트 출력
				if(lastDclz.dclzEtime != null && lastDclz.dclzEtime != ""){ // 마지막기록의 퇴근시각이 존재하면
					punchOutBtn.text("출근");
				}else if(lastDclz.dclzEtime == null){ // 마지막기록의 퇴근시각이 존재하지 않으면
					punchOutBtn.text("퇴근");
				}
		    }
			// 출퇴근 데이터를 화면에 뿌리기
			let dataTable_tbody = $("#dataTable-tbody");
			let tr = "";
			for(let i=0; i<res.dalList.length; i++){
				tr += `
					<tr>
						<td>\${res.dalList[i].dclzDate.substr(0,10)}</td>
						<td>\${res.dalList[i].dclzStime.substr(11)}</td>
					`;
				if(res.dalList[i].dclzEtime != null && res.dalList[i].dclzEtime != ""){ // 출근만했고 퇴근은 안했을수 있기때문에 퇴근시간이 존재할때만 td에 넣기
					tr += `<td>\${res.dalList[i].dclzEtime.substr(11)}</td>`
				}else{
					tr+= `<td></td>`;
				}
				tr += `
						<td>\${res.dalList[i].dclzType}</td>
						<td>\${res.dalList[i].dclzStatus}</td>
					</tr>
				`;
			}
			dataTable_tbody.html(tr);
			pagingArea.html(res.pagingVO.pagingHTML);
		},
		error : function(res){
			showToastMessage("❌ 목록을 불러오는데 실패했습니다.", "danger");
		}
	});
}

// 나의 가장 최근 출근기록 가져와서 출근날짜랑 오늘날짜랑비교해서 같으면 출근시각, 퇴근시각 출력 아니면 비워두기
function getTodayPunchOut(){
	data = {emplNo : userId}
	$.ajax({
		url : "/hrms/attendance/getTodayPunchOut",
		type : "post",
		data : JSON.stringify(data),
		contentType : "application/json;charset=utf-8",
		success : function(res){
			// 오늘날짜 구하기
			let day = new Date();
			let year = day.getFullYear(); // 년도
			let month = ("0" + (day.getMonth() + 1)).slice(-2);  // 월
			let date = ("0" + day.getDate()).slice(-2);  // 날짜
			let today = year + "-" + month + "-" + date
			// 결과값의 날짜 구하기
			let lastDclzDate = res.dclzDate
			// 결과값과 오늘날짜 비교해서 같으면 위에 출력하기
			if(today == lastDclzDate.substr(0,10)){
				todayDclzStime.text(res.dclzStime.substr(11));
				if(res.dclzEtime != null){
					todayDclzEtime.text(res.dclzEtime.substr(11));
					console.log("aaaaaaa", res.dclzStime.substr(11), res.dclzEtime.substr(11))
					updateProgressBar(res.dclzStime.substr(11), res.dclzEtime.substr(11))
				}
			}else{
				console.log("다르다")
			}
		},
		error : function(error){
			showToastMessage("❌ 목록을 불러오는데 실패했습니다.", "danger");
		}
	})
}

function selectThisMonthData(){
	$.ajax({
		url : "/hrms/attendance/selectThisMonthData",
		data : JSON.stringify({emplNo:userId}),
		type : "post",
		contentType : "application/json;charset=utf-8",
		success : function(res){
			console.log(res);
			if(res.LATE != null && res.LATE != ""){
				LATE.text(" " + res.LATE + " 일");
			}
			if(res.OVERTIMEHOUR != null && res.OVERTIMEHOUR != ""){
				OVERTIMEHOUR.text(" " + res.OVERTIMEHOUR + " 시간");
			}
			if(res.NORMAL != null && res.NORMAL != ""){
				NORMAL.text(" " + res.NORMAL + " 일");
			}
		},
		error : function(){
			showToastMessage("❌ 목록을 불러오는데 실패했습니다.", "danger");
		}
	});
}

function time(){ //현재시간 표시하는 시계.
	let time = new Date();
	let hours = time.getHours();
	let minutes = time.getMinutes();
	let seconds = time.getSeconds();
	clock.text(hours + "시 " + minutes + "분 " + seconds + "초")
}

function updateProgressBar(startTime, endTime) {

    const startHour = 6;
    const endHour = 23;
    const totalHours = endHour - startHour; // 총 17시간 범위

    const [startHourInput, startMinInput] = startTime.split(":").map(Number);
    const [endHourInput, endMinInput] = endTime.split(":").map(Number);

    if ([startHourInput, startMinInput, endHourInput, endMinInput].some(isNaN)) {
    	showToastMessage("올바른 시간 형식이 아닙니다. 'HH:MM:SS' 형식으로 입력하세요.", "warning");
        return;
    }
    if (startHourInput < startHour || endHourInput > endHour || startHourInput > endHourInput || startMinInput > endMinInput) {
    	showToastMessage("시간 범위는 06:00:00 ~ 23:00:00 사이여야 하며, 시작 시간이 종료 시간보다 작아야 합니다.", "warning");
        return;
    }

    const startPercentage = ((startHourInput - startHour) + (startMinInput / 60)) / totalHours * 100;

    const timeDifference = (endHourInput - startHourInput) + ((endMinInput - startMinInput) / 60);
    const widthPercentage = (timeDifference / totalHours) * 100;

    const progressBar = document.getElementById("progressBar");
    progressBar.style.left = startPercentage + "%"; // 시작 위치
    progressBar.style.width = widthPercentage + "%"; // 진행 바 길이
    workTime.text((endHourInput - startHourInput) + "시간 " + (endMinInput - startMinInput) + "분");
}
</script>
</html>