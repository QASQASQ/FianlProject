<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
	<meta name="description" content="Smarthr - Bootstrap Admin Template">
	<meta name="keywords" content="admin, estimates, bootstrap, business, html5, responsive, Projects">
	<meta name="author" content="Dreams technologies - Bootstrap Admin Template">
	<meta name="robots" content="noindex, nofollow">
	<title>HERMES</title>
</head>

<body>
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
		
		<form action="/logout">
			<input type="submit" value="로그아웃">
		</form>

		<!-- Page Wrapper -->
		<div class="page-wrapper">
			<div class="content">
				<!-- Breadcrumb -->
				<div class="d-md-flex d-block align-items-center justify-content-between page-breadcrumb mb-3">
					<div class="my-auto mb-2">
						<h2 class="mb-3" ><span style="font-family: Pretendard-Black;">${emp.emplNm}</span> 님의 메인페이지</h2>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<div class="row"> <!-- 첫 줄 -->
					<div class="col-xl-4 d-flex">
						<div class="card position-relative flex-fill">
							<div class="card-header bg-dark">
								<div class="d-flex align-items-center">
									<span class="avatar avatar-lg avatar-rounded border border-white border-2 flex-shrink-0 me-2">
										<img alt="이미지" style="width: 100%; height: 100%; object-fit: cover;" id="profileImg">
									</span>
									<div>
										<h5 class="text-white mb-1">${emp.emplNm} (${emp.emplNo })</h5>
										<div class="d-flex align-items-center">
										<span class="mx-1"><i class="ti ti-point-filled text-primary"></i></span>
										<p class="fs-12" id="emplPosition"></p>
									</div>
									</div>
								</div>
								<a href="/hrms/employee/employeeInfo" class="btn btn-icon btn-sm text-white rounded-circle edit-top"><i class="ti ti-edit"></i></a>
							</div>
							<div class="card-body">
								<div class="mb-3">
									<span class="d-block mb-1 fs-13">부서</span>
									<p class="text-gray-9" id="deptCode"></p>
								</div>
								<div class="mb-3">
									<span class="d-block mb-1 fs-13">팀</span>
									<p class="text-gray-9" id="teamCode"></p>
								</div>
								<div class="mb-3">
									<span class="d-block mb-1 fs-13">연락처</span>
									<p class="text-gray-9">${emp.emplTelno}</p>
								</div>
								<div class="mb-3">
									<span class="d-block mb-1 fs-13">Email</span>
									<p class="text-gray-9"><a href="/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="fcaf88998c998e9899cdcec8bc99849d918c9099d29f9391">${emp.emplEmail}</a></p>
								</div>
								<div>
									<span class="d-block mb-1 fs-13">입사일</span>
									<p class="text-gray-9" id="hireDate"></p>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-4 d-flex">
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
								</div>
								<div class="text-center" style="padding-top: 50px; padding-bottom: 50px">
									<button class="btn btn-primary w-100" id="punchOutBtn">출근</button>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-4 d-flex">
						<div class="card-body">
							<div class="mb-4 text-center">
								<h4>캘린더</h4>
								<div id="calendar"></div>
							</div>
						</div>
					</div>
				 <!-- 셋째줄 -->
				<div class="row">
					<!-- 팀 연락처 들어가는 곳 -->
					<div class="col-xl-4 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<div class="d-flex align-items-center justify-content-between flex-wrap">
										<h5>부서원</h5>
										<div>
											<a href="/hrms/hr/hr" class="btn btn-light btn-sm">더보기</a>
										</div>
									</div>
								</div>
								
								<div class="card-body" >
							        <div style="max-height: 200px; overflow-y: auto; padding: 15px; background-color: #fff;" id="deptMembersCard">
							        </div>
								</div> 
							</div>
						</div> 
						<!-- /팀 연락처 들어가는 곳 --> 
						
						<!-- 셋째줄 게시판 들어가는 곳 -->
						<div class="col-xl-8 d-flex"> <!-- 게시판 너비 조정 -->
							<div class="card flex-fill">
								<div class="card-header">
								    <div class="d-flex align-items-center justify-content-between flex-wrap row-gap-2">
								        <!-- 왼쪽: 제목 + 게시판 유형 버튼 -->
								        <div class="d-flex align-items-center">
								            <h5 class="mb-0">사내 게시판</h5>
								            <button class="btn btn-light btn-sm" style="margin-left: 10px;" id="boardChangeBtn">공지사항</button>
								        </div>
								
								        <a href="#" class="btn btn-light btn-sm" style="margin-right: 10px;" id="boardsDetail">더보기</a>
								    </div>
								</div>


								<!-- 게시판 내부 -->
								<div class="card-body d-flex justify-content-center align-items-center" style="padding: 0;">
								    <div class="w-100 h-100">
								        <table class="table mb-0 text-center" style="width: 100%; height: 100%; border-collapse: collapse;">
								            <thead>
								                <tr>
								                    <th>제목</th>
								                    <th>작성자</th>
								                    <th>조회수</th>
								                    <th>작성날짜</th>
								                </tr>
								            </thead>
								            <tbody id="boardTable">
								            </tbody>
								        </table>
								    </div>
								</div>


								<!-- /게시판 내부 -->
							</div>
						</div>
					</div>
				</div>

			</div>
			<!-- /Page Wrapper -->
			
			<!-- Footer -->
			<%@ include file="/WEB-INF/views/theme/footer.jsp" %>
			<!-- /Footer -->
			
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

<script type="module" src="${pageContext.request.contextPath }/assets/js/session.js"></script>

<!--풀캘린더  -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/luxon/3.3.0/luxon.min.js"></script>
</body>
<script type="text/javascript">
const userId = sessionStorage.getItem("userId");// 세션에 아이디가져오기

let clock = $("#clock");					// 현재시각 표시하는 곳
time(); // 시계함수 실행
setInterval(time, 1000); // 시계함수 1초마다 계속실행

let emplPosition = $("#emplPosition");
let deptCode = $("#deptCode");
let teamCode = $("#teamCode");
let hireDate = $("#hireDate")
let profileImg = $("#profileImg");

let punchOutBtn = $("#punchOutBtn");		// 출퇴근 버튼
let todayDclzStime = $("#todayDclzStime");	// 오늘 나의 출근시간을 표시하는 곳
let todayDclzEtime = $("#todayDclzEtime");	// 오늘 나의 퇴근시간을 표시하는 곳

let deptMembersCard = $("#deptMembersCard") // 부서원 출력하는곳

let boardChangeBtn = $("#boardChangeBtn");	// 게시판 전환하는 버튼
let boardTable = $("#boardTable");			// 게시판 출력하는 곳
let boardsDetail = $("#boardsDetail");

let calendar = $("#calendar");
$(function(){
	
	calendar.on("click", function(){
		location.href = "/hrms/cal/viewCalendar";
	});
	
	getBoards();
	getEmplList();
	setInterval(getEmplList, 600000);
	
	getTodayPunchOut();
	printList();
	getMyInfo();
	
	getCalendar();
	
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
					showToastMessage("출근성공", "success");
					printList();
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
					showToastMessage("퇴근성공", "success");
					printList();
					getTodayPunchOut();
				},
				error : function(error){
					showToastMessage("퇴근등록중 오류발생.", "danger");
				}				
			});
		}
	});
	// 출퇴근버튼 클릭 끝
	
	// 게시판 보기전환 버튼
	boardChangeBtn.on("click", function(){
		getBoards();
	});
	
	// 게시판 자세히보기 버튼
	boardsDetail.on("click", function(){
		if(boardChangeBtn.text() == "공지사항"){
			location.href = "/hrms/notice/noticeList";
		}else{
			location.href = "/hrms/board/boardList";
		}
	});
})

//나의 가장 최근 출근기록 가져와서 출근날짜랑 오늘날짜랑비교해서 같으면 출근시각, 퇴근시각 출력 아니면 비워두기
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
			if(lastDclzDate != null && lastDclzDate != "" && today == lastDclzDate.substr(0,10)){
				todayDclzStime.text(res.dclzStime.substr(11))
				if(res.dclzEtime != null){
					todayDclzEtime.text(res.dclzEtime.substr(11))
				}
			}else{}
			
		},
		error : function(error){
			showToastMessage("❌ 목록을 불러오는데 실패했습니다.", "danger");
		}
	})
}

//출퇴근 목록 가져오기
function printList(){ 
	let data = {page : 1, emplNo : userId};
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
		    
		    if(res.dalList != null && res.dalList != "" && res.dalList.length > 0){ // 지금까지 한번도 출근을 안했을수도 있으니까 null체크
				lastDclzDate = res.dalList[0].dclzDate.substr(0,10); // 가장최근 출근을 찍은 일자. 연,월,일만 가져옴 예시)2025-02-05
				let lastDclz = res.dalList[0];

				// 출/퇴근버튼에 텍스트 출력
				if(lastDclz.dclzEtime != null && lastDclz.dclzEtime != ""){ // 마지막기록의 퇴근시각이 존재하면
					punchOutBtn.text("출근");
				}else if(lastDclz.dclzEtime == null){ // 마지막기록의 퇴근시각이 존재하지 않으면
					punchOutBtn.text("퇴근");
				}
		    }
		},
		error : function(res){
			showToastMessage("❌ 목록을 불러오는데 실패했습니다.", "danger");
		}
	});
}
// 현재시간 표시하는 시계.
function time(){
	let time = new Date();
	let hours = time.getHours();
	let minutes = time.getMinutes();
	let seconds = time.getSeconds();
	clock.text(hours + "시 " + minutes + "분 " + seconds + "초")
}

// 부서원 출력하기
function getEmplList(){
	$.ajax({
		url : "/cmm/getEmplList",
		data : JSON.stringify({deptCode:'${emp.deptCode}'}),
		type : "post",
		contentType : "application/json;charset=utf-8",
		success : function(res){
			console.log("부서원 출력하기 실행됨");
			let tr = "";
			for(let i=0; i<res.length; i++){
				tr += `
					<div class="d-flex align-items-center justify-content-between mb-4">
						<div class="d-flex align-items-center">
							<div class="ms-2">
								<h6 class="fs-14 fw-medium text-truncate mb-1">\${res[i].emplNm}</h6>
								<p class="fs-13">\${res[i].teamCode}</p>
							</div>
						</div>
						<div class="d-flex align-items-center">
						`;
				if(res[i].emplPwd == "퇴근"){
					tr += `
						<span class="badge badge-danger-transparent d-inline-flex align-items-center">
							<i class="ti ti-point-filled me-1"></i>
							부재중
						</span>
					`;
				}else{
					tr += `
						<span class="badge badge-success-transparent d-inline-flex align-items-center">
							<i class="ti ti-point-filled me-1"></i>
							근무중
						</span>
					`;
				}
							
							
					tr += `
						</div>
					</div>
				`;
				deptMembersCard.html(tr);
			}
		},
		error : function(error){},
	});
}

// 게시판데이터 가져오기
function getBoards(){
	$.ajax({
		url : "/cmm/getBoards",		
		type : "post",		
		success : function(res){
			let tText = boardChangeBtn.text();
			if(tText == "공지사항"){
				boardChangeBtn.text("건의사항");
				printBoards(res.boardList);
			}else if(tText == "건의사항"){
				boardChangeBtn.text("공지사항");
				printBoards(res.noticeList);
			}
		},		
		error : function(error){},		
	});
}

// 게시판 데이터 출력하기
function printBoards(data){
	let tr = "";
	for(let i=0; i<data.length; i++){
		let date = data[i].boardDate.substr(0,11);
		tr += `
			<tr class="text-center">
				<td class="text-start">\${data[i].boardTitle}</td>
				<td>\${data[i].boardWriter}</td>
				<td>\${data[i].boardHit}</td>
				<td>\${date}</td>
			</tr>
		`;
	}
	boardTable.html(tr);
}

// 내 정보 가져오기
function getMyInfo(){
	$.ajax({
		url : "/cmm/getMyInfo",
		data : JSON.stringify({emplNo:"${emp.emplNo}"}),
		type : "post",
		contentType : "application/json;charset=utf-8",
		success : function(res){
			emplPosition.text(res.emplPosition);
			deptCode.text(res.deptCode);
			teamCode.text(res.teamCode);
			hireDate.text(res.hireDate.substr(0,11));
			if(res.profileImgpath != null){
				profileImg.attr("src", `/profile_images/\${res.profileImgpath }`);
			}else{
				profileImg.attr("src", `/profile_images/forNull.png`);
			}
		},
		error : function(error){},
	});
	
}


// 캘린더

//캘린더 오늘 하루만 보기
function getCalendar () {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridDay',
        initialDate: luxon.DateTime.local().toFormat('yyyy-MM-dd'), // 현재 날짜로 설정
        headerToolbar: {
            left: '',
            center: 'title',
            right: ''
        },
        nowIndicator: true, // 현재 시간 표시
        validRange: {
            start:luxon.DateTime.local().toISODate(),
            end: luxon.DateTime.local().toISODate()
        },
        titleFormat: function(date) {
                		return date.date.marker.getFullYear() + '년 ' + 
                       (date.date.marker.getMonth() + 1) + '월 ' + 
                       date.date.marker.getDate() + '일 (' + 
                       ['일', '월', '화', '수', '목', '금', '토'][date.date.marker.getDay()] + ')';
        },
        events: function (fetchInfo, successCallback, failureCallback) {
			let data = {
					emplNo : userId,
					today: luxon.DateTime.local().toFormat('yyyy-MM-dd')
				};
			
				console.log("data.emplNo : " + data.emplNo)
				console.log("오늘 날짜:", data.today);

				$.ajax({
					url: "/cmm/getCalendarDay",
					type: 'post',
					contentType: 'application/json;charset=utf-8',
					 dataType: 'json',
					data: JSON.stringify(data),
					success: function (events) {
						console.log("가져온 일정 : " + events);
						const convertedEvents = events.map(event => ({
							 	id: event.id,
		                        title: event.title,
		                        start: event.start,
		                        end: event.end ? event.end : event.start, // 종료 시간이 없으면 시작 시간과 동일하게
		                        backgroundColor: event.color || '#3788d8', // 기본 색상 설정
		                        textColor: event.textColor || '#ffffff',
		                        allDay: event.allDay
						}));
						successCallback(convertedEvents);
						$(".fc-scrollgrid-sync-inner").css("background-color", "white");
					},
					error: function (xhr, status, error) {
						console.log("실패");
						console.error("Error fetching events:", error);
				        console.error("응답 상태 코드:", xhr.status);
				        console.error("응답 텍스트:", xhr.responseText);
						failureCallback(error);
					}
				});
			}
    });

    calendar.render();
}
</script>

</html>