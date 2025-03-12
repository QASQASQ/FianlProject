<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- 로그인한 사용자 세션 -->
<!-- 사용자 정보를 가져오려면 \${emp.필드이름} 이런식으로 사용하면됨 -->
<sec:authentication property="principal.emp" var="emp"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- Favicon -->
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath }/assets/img/favicon.png">

<!-- Apple Touch Icon -->
<link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath }/assets/img/apple-touch-icon.png">

<!-- Theme Script js -->
<script src="${pageContext.request.contextPath }/assets/js/theme-script.js"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/bootstrap.min.css">

<!-- Feather CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/icons/feather/feather.css">

<!-- Tabler Icon CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/tabler-icons/tabler-icons.css">

<!-- Select2 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/select2/css/select2.min.css">

<!-- Fontawesome CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/fontawesome/css/fontawesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/fontawesome/css/all.min.css">

<!-- Datetimepicker CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/bootstrap-datetimepicker.min.css">

<!-- Color Picker Css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/flatpickr/flatpickr.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/@simonwep/pickr/themes/nano.min.css">

<!-- Daterangepikcer CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/daterangepicker/daterangepicker.css">

<!-- Datatable CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/dataTables.bootstrap5.min.css">

<!-- Select2 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/select2/css/select2.min.css">

<!-- Main CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/style.css">
	<!--  -->
<div class="header">
	<div class="main-header">

		<div class="header-left">
			<a href="index.html" class="logo">
				<img src="${pageContext.request.contextPath }/assets/img/logo.png" alt="Logo">
			</a>
			<a href="index.html" class="dark-logo">
				<img src="${pageContext.request.contextPath }/assets/img/logo-white.svg" alt="Logo">
			</a>
		</div>

		<a id="mobile_btn" class="mobile_btn" href="#sidebar">
			<span class="bar-icon">
				<span></span>
				<span></span>
				<span></span>
			</span>
		</a>

		<div class="header-user">
			<div class="nav user-menu nav-list">

				<div class="me-auto d-flex align-items-center" id="header-search">
				</div>

				<div class="d-flex align-items-center">
					<div class="me-1">
						<a href="#" class="btn btn-menubar btnFullscreen">
							<i class="ti ti-maximize"></i>
						</a>
					</div>
					<div class="me-1 notification_item">
						<a href="#" class="btn btn-menubar position-relative me-1" id="notification_popup"
							data-bs-toggle="dropdown">
							<i class="ti ti-bell"></i>
						</a>
						<div class="dropdown-menu dropdown-menu-end notification-dropdown p-4">
							<div class="noti-content" id="noti-content">
							</div>
							<div class="d-flex p-0">
								<a href="#" class="btn btn-light w-100 me-2">닫기</a>
							</div>
						</div>
					</div>
					<div class="dropdown profile-dropdown">
						<a href="javascript:void(0);" class="dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">
								${emp.emplNm }(${emp.emplNo })
						</a>
						<div class="dropdown-menu shadow-none">
							<div class="card mb-0">
								<div class="card-header">
									<div class="d-flex align-items-center">
										<span class="avatar avatar-lg me-2 avatar-rounded">
											<img src="/profile_images/${emp.profileImgpath }" alt="이미지" style="width: 100%; height: 100%; object-fit: cover;" class="img-fluid rounded-circle profileImgHeader">
										</span>
										<div>
											<h5 class="mb-0">${emp.emplNm}</h5>
											<p class="fs-12 fw-medium mb-0">${emp.emplEmail}</p>
										</div>
									</div>
								</div>
								<div class="card-footer py-1">
									<a class="dropdown-item d-inline-flex align-items-center p-0 py-2"
										href="/temporary/profile.html">
										<i class="ti ti-user-circle me-1"></i>나의 정보
									</a>
									<!-- <a class="dropdown-item d-inline-flex align-items-center p-0 py-2" href="/temporary/bussiness-settings.html">
										<i class="ti ti-settings me-1"></i>Settings
									</a> -->
								</div>
								<div class="card-footer py-1">
									<form action="/logout">
										<button type="submit" class="dropdown-item d-inline-flex align-items-center p-0 py-2"><i class="ti ti-login me-2"></i>로그아웃</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>
const baseUrl = window.location.origin;
const user = sessionStorage.getItem("userId"); // 현재 로그인한 사용자 ID
let noti_content = $("#noti-content");
let profileImgHeader = $(".profileImgHeader");

window.onload = function(){
	getMyInfo();
	const socket = new SockJS(`\${baseUrl}/ws/notify`);
	const stompClient = Stomp.over(socket);
	
	getNotification();

	stompClient.connect({}, function (frame) {
	    console.log('Connected to Notifications: ' + frame);

	    
	    stompClient.subscribe(`/queue/notifications-\${user}`, function (notification) { // 사용자 ID를 붙여서 구독
	        const message = JSON.parse(notification.body);
	        console.log("알림 수신:", message);
	        notify(message.ntcnContent);
	        
	    });
	});
}
function notify(message){ // 메시지 태그 만들기
    $("#notification-box").remove();

    // div 태그 생성
    const notification = $("<div>", {
        id: "notification-box",
        text: message
    }).addClass("alert alert-solid-success alert-dismissible fade show");
	// 버튼태그 생성
    const closeButton = $("<button>", {
        type: "button",
        class: "btn-close",
        "data-bs-dismiss": "alert",
        "aria-label": "Close",
        html: '<i class="fas fa-xmark"></i>' // 아이콘 추가
    });
    
    // div태그에 스타일 설정 (우측 하단 고정)
    notification.css({
		position: "fixed",
		top: "20px",
		right: "20px",
		zIndex: "1000",
		width: "350px",
		padding: "15px",
		fontSize: "20px",
        borderRadius: "8px", // ✅ 모서리 둥글게
        boxShadow: "0px 4px 10px rgba(0, 0, 0, 0.2)", // ✅ 그림자 추가 (더 돋보이게)
    	fontWeight: "800"
    });
    // div 태그에 버튼 추가
    notification.append(closeButton);
    // body에 추가
    $("body").append(notification);
    getNotification();
}

 function getNotification(){
	data = {emplNo : user}
	$.ajax({
		url : "/hrms/notification/getNotification",
		data : JSON.stringify(data),
		type : "post",
		contentType : "application/json;charset=utf-8",
		success : function(res){
			console.log(res);
			let result = "";
			if(res != null && res.notificationList.length > 0){
				for(let i=0; i<res.notificationList.length; i++){
					result += `
						<div class="d-flex flex-column">
							<div class="border-bottom mb-3 pb-3">
								<div class="d-flex">
									<div class="flex-grow-1">
										<p class="mb-1">\${res.notificationList[i].ntcnContent}</p>
										<span>\${res.notificationList[i].ntcnDate}</span>
									</div>
								</div>
							</div>
						</div>
					`;
				}
			}else{
				result += `
					<div class="d-flex flex-column">
						<div class="border-bottom mb-3 pb-3">
							<div class="d-flex">
								<div class="flex-grow-1">
									<p class="mb-1">알림이 없습니다.</p>
									<span></span>
								</div>
							</div>
						</div>
					</div>
				`;
			}
			noti_content.html(result);
		},
		error : function(error){}
	});
}
 
function getMyInfo(){
	$.ajax({
		url : "/cmm/getMyInfo",
		data : JSON.stringify({emplNo:user}),
		type : "post",
		contentType : "application/json;charset=utf-8",
		success : function(res){
			$(".profileImgHeader").attr("src", `/profile_images/\${res.profileImgpath }`);
		},
		error : function(error){},
	});
	
}
</script>