<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
		<meta name="description" content="Smarthr - Bootstrap Admin Template">
		<meta name="keywords" content="admin, estimates, bootstrap, business, html5, responsive, Projects">
		<meta name="author" content="Dreams technologies - Bootstrap Admin Template">
		<meta name="robots" content="noindex, nofollow">
	<title>일정관리</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css">
	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/luxon/3.3.0/luxon.min.js"></script>
	<style>
	.fc-event:hover {
		cursor: pointer;
	}
	
	#addEventButton {
		margin-bottom: 10px;
		padding: 10px 15px;
		font-size: 16px;
		background-color: #28a745;
		color: white;
		border: none;
		cursor: pointer;
		border-radius: 5px;
	}
	</style>
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
		
				<h1>일정관리</h1>
				<button id="addEventButton">추가하기</button>
				<div id="calendar"></div>
	
				<!-- 사용자 입력 폼 -->
				<div id="eventForm"
					style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #fff; border: 1px solid #ccc; padding: 20px; z-index: 1000;">
					<label>일정명: <input type="text" id="eventTitle"></label><br><br>
					<label>시작날짜: <input type="datetime-local" id="eventStart"></label><br><br>
					<label>마지막날짜: <input type="datetime-local" id="eventEnd"></label><br><br>
					<label>하루종일: <input type="checkbox" id="eventAllDay" onclick="toggleTimeFields()"></label><br> <br>
					<label>색: <input type="color" id="eventColor"></label><br><br>
					<label>글자 색: <input type="color" id="eventTextColor" value="#ffffff"></label><br><br>
					<button id="saveButton" style="display: none;" onclick="saveEvent()">저장</button>
					<button id="updateButton" style="display: none;" onclick="updateEvent()">수정</button>
					<button id="deleteButton" style="display: none;" onclick="deleteEvent()">삭제</button>
					<button onclick="closeForm()">취소</button>
				</div>
			</div>
			
			<!-- Footer -->
			<div class="footer d-sm-flex align-items-center justify-content-between bg-white border-top p-3">
				<p class="mb-0">2014 - 2025 &copy; SmartHR.</p>
				<p>Designed & Developed By <a href="#" class="text-primary">Dreams</a></p>
			</div>
			<!-- /Footer -->
			<!--Page  -->
		</div>
	<!--/Main Wrapper  -->	
	</div>

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
	
	<%-- <!-- Datatable JS -->
	<script src="${pageContext.request.contextPath }/assets/js/jquery.dataTables.min.js"></script>
	<script src="${pageContext.request.contextPath }/assets/js/dataTables.bootstrap5.min.js"></script>	 --%>
	
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
<script>
	let calendar, currentEventId, selectedDate = null
	const userId = sessionStorage.getItem("userId"); //아이디 세션 가져오기
	console.log("아이디 :" + userId);
	
	$(document).ready(function () {
	const calendarEl = document.getElementById('calendar');
	
	// 캘린더 생성
	calendar = new FullCalendar.Calendar(calendarEl, {
	
	// 캘린더 기본설정
	headerToolbar: {
		left: 'prev,next today',
		center: 'title',
		right: 'dayGridMonth,timeGridWeek,timeGridDay'
	},
		editable: true,
		selectable: true,
		eventOverlap: true,
		slotEventOverlap: true,
		displayEventTime: true,
		displayEventEnd: true,
		
		// ✅ AJAX를 활용하여 서버에서 일정 데이터 가져오기
		events: function (fetchInfo, successCallback, failureCallback) {
			let data = {
				emplNo : userId 
			}
			console.log("data.emplNo : " + data.emplNo)
			$.ajax({
				url: `/api/events/selectById`,
				type: 'Post',
				contentType: 'application/json;charset=utf-8',
				dataType: 'json',
				data: JSON.stringify(data),
				success: function (events) {
					console.log("성공");
					const convertedEvents = events.map(event => {
						const DateTime = luxon.DateTime;
						let start = DateTime.fromISO(event.start).setZone("local").toISO();
						let end = event.end ? DateTime.fromISO(event.end).setZone("local").toISO() : start;
						return { ...event, start, end };
					});
					successCallback(convertedEvents);
				},
				error: function (xhr, status, error) {
					console.log("실패");
					console.error("Error fetching events:", error);
					failureCallback(error);
				}
			});
		}
	});
		calendar.render();
	});
	
	// 캘린더 닫기
	function closeForm() {
		$('#eventForm').hide();
	}
	
	// 추가하기 누르면 폼띄우기
	function showEventForm(date) {
		currentEventId = null; // 새로운 일정 추가 시 ID 초기화
		$('#saveButton').show(); // ✅ 저장 버튼 표시
		$('#updateButton').hide(); // ✅ 수정 버튼 숨김
		$('#deleteButton').hide(); // ✅ 삭제 버튼 숨김
		$('#eventTitle').val('');
		$('#eventDescription').val('');
		$('#eventStart').val(date);
		$('#eventEnd').val(date);
		$('#eventColor').val('#3788d8');
		$('#eventTextColor').val('#ffffff');
		$('#eventAllDay').prop('checked', false);
		toggleTimeFields();
		$('#eventForm').show();
	}

	// ✅ "추가하기" 버튼 클릭 시 입력 폼 표시
	$('#addEventButton').on('click', function () {
		showEventForm('');
	});

	// ✅ 이벤트 저장 기능 (새 일정 추가)
	function saveEvent() {
		let eventData = {
			schTitle: $('#eventTitle').val(),
			schSDate: $('#eventStart').val(),
			schEDate: $('#eventEnd').val(),
			schColor: $('#eventColor').val(),
			schTextColor: $('#eventTextColor').val(),
			schAllDay: $('#eventAllDay').prop('checked'),
			emplNo : userId
		};

		// ✅ `allDay` 일정 변환
		const DateTime = luxon.DateTime;
		if (eventData.allDay) {
			eventData.schSDate = DateTime.fromISO(eventData.schSDate, { zone: "Asia/Seoul" }).toISODate() + "T00:00:00";
			eventData.schEDate = eventData.schSDate; 
		}else{
			//일반일정일 경우 endDate가 없으면 startDate와 동일하게 설정
			if (!eventData.schEDate || eventData.schEDate.trim() === "") {
				eventData.schEDate = eventData.schSDate;
		}
	            	
		// ✅ 일반 일정의 경우 UTC로 변환
		eventData.schSDate = DateTime.fromISO(eventData.schSDate, { zone: "Asia/Seoul" }).toUTC().toISO();
		eventData.schEDate = DateTime.fromISO(eventData.schEDate, { zone: "Asia/Seoul" }).toUTC().toISO();
		} 
	
		$.ajax({
			url: '/api/events',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify(eventData),
			success: function () {
				calendar.refetchEvents();
				closeForm();
				alert('새 일정이 추가되었습니다!');
			},
			error: function (xhr, status, error) {
				console.error("Error adding event:", error);
			}
		});
	}

	// 일정을 보여주기
	

	function toggleTimeFields() {
		const allDay = $('#eventAllDay').prop('checked');
		$('#eventStart').attr('type', allDay ? 'date' : 'datetime-local');
		$('#eventEnd').attr('type', allDay ? 'date' : 'datetime-local');
	}
</script>
</body>
</html>