<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
	<meta name="description" content="Smarthr - Bootstrap Admin Template">
	<meta name="keywords" content="admin, estimates, bootstrap, business, html5, responsive, Projects">
	<meta name="author" content="Dreams technologies - Bootstrap Admin Template">
	<meta name="robots" content="noindex, nofollow">
	<title>사원 정보 페이지</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
						<h2 class="mb-1">사원 정보 </h2>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<div class="card">
					<div class="card-body">
						<div class="border-bottom mb-3 pb-3">
							<h4>사원 정보 </h4>
						</div>
						<form action="/hrms/employee/employeeUpdate">
							<div class="border-bottom mb-3">
								<div class="row">
									<div class="col-md-12">
										<div>					
											<h6 class="mb-3">기본 정보</h6> <!-- 이 부분 부터 기본 정보 -->
											<div class="d-flex align-items-center flex-wrap row-gap-3 bg-light w-100 rounded p-3 mb-4">                                              
												<div id="divForImg" style="width: 250px;">
												<h6 class="mb-1">프로필 사진</h6>
												</div>
												<div class="profile-upload" style="margin-left: 100px;">
													<div class="mb-2">
													</div>
												</div>
												<div class="col-md-6">
													<div class="row align-items-center mb-3" id="signDiv">
														<div class="col-md-4">
															<label class="form-label mb-md-0">서명</label>
														</div>
														<div class="col-md-8">
															<p id="emplSignature" style="background-color: white;"></p>
														</div>
													</div>
												</div>                                   
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">사원 번호</label>
											</div>
											<div class="col-md-8">
												<p id="emplNo"></p>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">성명</label>
											</div>
											<div class="col-md-8">
												<p id="emplNm"></p>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">직위</label>
											</div>
											<div class="col-md-8">
												<p id="emplPosition"></p>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">부서</label>
											</div>
											<div class="col-md-8">
												<p id="deptCode"></p>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">팀</label>
											</div>
											<div class="col-md-8">
												<p id="teamCode"></p>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">생년월일</label>
											</div>
											<div class="col-md-8">
												<p id="emplBrthdy"></p>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">입사 일자</label>
											</div>
											<div class="col-md-8">
												<p id="hireDate"></p>
											</div>
										</div>
									</div>
									<!-- <div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">보유 권한</label>
											</div>
											<div class="col-md-8">
												<p id="emplAuth"></p>
											</div>
										</div>
									</div> -->
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												
											</div>
											<div class="col-md-8">
												
											</div>
										</div>
									</div>
									
								</div>
							</div>
							<div class="border-bottom mb-3"> <!-- 이 부분 부터 추가 정보 -->
								<h6 class="mb-3">추가 정보</h6>
								<div class="row">
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">성별</label>
											</div>
											<div class="col-md-8">
												<p id="emplGender"></p>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">연락처</label>
											</div>
											<div class="col-md-8">
												<p id="emplTelno"></p>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">이메일</label>
											</div>
											<div class="col-md-8">
												<p id="emplEmail"></p>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">주소</label>
											</div>
											<div class="col-md-8">
												<p id="addr"></p>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">취미</label>
											</div>
											<div class="col-md-8">
												<p id="emplHobby"></p>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">결혼 기념일자</label>
											</div>
											<div class="col-md-8">
												<p id="emplMrnry"></p>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">세대주 여부</label>
											</div>
											<div class="col-md-8">
												<p id="householderAt"></p>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">차량 번호</label>
											</div>
											<div class="col-md-8">
												<p id="vehicleNumber"></p>
											</div>
										</div>
									</div>
									
								</div>
							</div>
							<div class="border-bottom mb-3">
								<h6 class="mb-3">급여 관련 정보</h6> <!-- 급여 관련 정보 -->
								<div class="row">
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">은행</label>
											</div>
											<div class="col-md-8">
												<p id="bankCode"></p>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">지점 명</label>
											</div>
											<div class="col-md-8">
												<p id="bankName"></p>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">계좌 번호</label>
											</div>
											<div class="col-md-8">
												<p id="account"></p>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- <div class="border-bottom mb-3">
								<h6 class="mb-3">퇴사 관련 정보</h6>
								<div class="row">
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">퇴사 일자</label>
											</div>
											<div class="col-md-8">
												<p id="retireDate"></p>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">사유</label>
											</div>
											<div class="col-md-8">
												<p id="retireResn"></p>
											</div>
										</div>
									</div>
								</div>
							</div> --> <!-- 정보 끝 (버튼 바로 위) -->
							
								<div class="d-flex align-items-center justify-content-end">
									<button type="button" class="btn btn-outline-light border me-2" id="changePwdBtn">비밀번호 변경</button>
									<button type="submit" class="btn btn-primary">수정</button>
								</div>
						</form>
					</div>
				</div>
			</div>
			<!-- Footer -->
			<%@ include file="/WEB-INF/views/theme/footer.jsp" %>
			<!-- /Footer -->
		</div>
		<!-- /Page Wrapper -->

	</div>
	
	<!-- 비밀번호 변경 모달 -->
	<div class="modal fade" id="changePwdModal" tabindex="-1" aria-labelledby="changePwdModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="changePwdModalLabel">비밀번호 변경</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
	      </div>
	      <div class="modal-body">
	        <!-- 모달 내용 입력 -->
	        <p>변경할 비밀번호를 입력하세요.</p>
	        <input type="password" id="changePwd" class="form-control"><br/>
	        <p>비밀번호를 다시 한번 입력하세요.</p>
	        <input type="password" id="changePwd2" class="form-control"/>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal" id="cancelFinalBtn">취소</button>
	        <button type="button" class="btn btn-primary" id="changeFinalBtn">저장</button>
	      </div>
	    </div>
	  </div>
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

<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/employeeInfo.js"></script>
</body>
<script type="text/javascript">

$(function(){
	
	// 직위, 부서코드, 팀코드, 은행코드 사원테이블에서 들고오기 (세션값으로 던져주면 수정 시 재로그인 전에는 반영이 안됨)
	
	const userId = sessionStorage.getItem("userId"); // 세션 아이디 가져오기
	console.log("userId: ", userId);
	
	let userIdData = {userId : userId};
	
	// 사원 권한 가져오기
	/* $.ajax({
		url: "/employee/getEmpAuth",
		method: 'get',
		data: {userId: userId},
		dataType: 'json',
		success: function(res){
			console.log("사원 권한: ", res);
			let authHtml = "";
			
	        for (var i = 0; i < res.length; i++) {
	        	if(res[i].authCode == 'ROLE_GENERAL') {
	        		res[i].authCode = '일반';
	        	}
	        	if(res[i].authCode == 'ROLE_MANAGER') {
	        		res[i].authCode = '인사권';
	        	}
	        	if(res[i].authCode == 'ROLE_ADMIN') {
	        		res[i].authCode = '인사관리';
	        	}
	        	
	            authHtml += "<span style='margin-right: 10px;'>" + res[i].authCode + ".</span>";
	        }
			
			$("#emplAuth").html(authHtml);
			
		}
	}); */
	
	
	$.ajax({
		url: "/employee/getSomeCode",
		method: "get",
		data: userIdData,
		dataType: "json",
		success: function(res){
			console.log("getSome 응답: ", res);
			console.log(res[0].EMPL_POSITION);
			console.log(res[0].DEPT_CODE);
			console.log(res[0].TEAM_CODE);
			console.log(res[0].BANK_CODE);
			
			let userPosition = res[0].EMPL_POSITION;
			let userDept = res[0].DEPT_CODE;
			let userTeam = res[0].TEAM_CODE;
			let userBank = res[0].BANK_CODE;
			console.log("userPosition: ", userPosition);
			console.log("userDept: ", userDept);
			console.log("userTeam: ", userTeam);
			console.log("userBank: ", userBank);

			const data = {
					emplNo : userId,
					emplPosition : userPosition,
					deptCode : userDept,
					teamCode : userTeam,
					bankCode : userBank
					};
			
			$.ajax({
				url: "/employee/getEmplInfo",
				method: "get",
				data: data,
				dataType: "json",
				success: function(res){
					console.log("사원 정보: ", res);
					
					if(res.profileImgpath == null) {
						$("#divForImg").append(`<img src='${pageContext.request.contextPath }/assets/img/profile_images/forNull.png'>`);
					} else {
						$("#divForImg").append(`<img src='/profile_images/\${res.profileImgpath}' alt='Profile Image'>`);
					}
					
					$("#emplNo").append(res.emplNo);
					$("#emplNm").append(res.emplNm);
					$("#emplPosition").append(res.emplPosition);
					$("#deptCode").append(res.deptCode);
					$("#teamCode").append(res.teamCode);
					$("#emplBrthdy").append(res.emplBrthdy);
					$("#hireDate").append(res.hireDate);
					
					var imgHtml = '<img src="data:image/png;base64,' + res.emplSignature + '" alt="Signature" />';
					
					if(res.emplSignature == null) {
						$("#emplSignature").html("등록한 서명이 없습니다.");
					} else {
						$("#emplSignature").append(imgHtml);	// 서명
						$("#signDiv").css('width', '500px');
						$("#emplSignature").css("border", "1px solid black");
					}
					
					// 여기부터 추가 정보
					if(res.emplGender == null) {
						$("#emplGender").append("성별을 등록 해 주세요.");
					} else {
						let gender = "";
						if(res.emplGender == "M") {
							gender = "남자";
						}
						if(res.emplGender == "F") {
							gender = "여자";
						}
						$("#emplGender").append(gender);
					}
					
					if(res.emplTelno == null) {
						$("#emplTelno").append("연락처를 등록 해 주세요.");
					} else {
						$("#emplTelno").append(res.emplTelno);
					}
					
					if(res.householderAt == null) {
						$("#householderAt").append("세대주 여부를 등록 해 주세요.");
					} else {
						if(res.householderAt == "Y") {
							res.householderAt = "세대주";
						}
						if(res.householderAt == "N") {
							res.householderAt = "세대원";
						}
						$("#householderAt").append(res.householderAt);
					}
					
					if(res.vehicleNumber == null) {
						$("#vehicleNumber").append("등록 된 차량 번호가 없습니다.");
					} else {
						$("#vehicleNumber").append(res.vehicleNumber);
					}
					
					if(res.emplEmail == null) {
						$("#emplEmail").append("이메일을 등록 해 주세요.");
					} else {
						$("#emplEmail").append(res.emplEmail);
					}
					
					if(res.zipCode == null || res.addrMain == null || res.addrDetail == null) {
						$("#addr").append("주소를 등록 해 주세요.");
					} else {
						$("#addr").append(`\${res.zipCode}, \${res.addrMain}, \${res.addrDetail}`);
					}
					
					if(res.emplHobby == null) {
						$("#emplHobby").append("등록 된 취미가 없습니다.");
					} else {
						$("#emplHobby").append(res.emplHobby);
					}
					
					if(res.emplMrnry == null){
						$("#emplMrnry").append("등록 된 결혼 기념일자가 없습니다.");
					} else {
						$("#emplMrnry").append(res.emplMrnry);
					}
					
					if(res.retireDate == null) {
						$("#retireDate").append("퇴사 일자가 없습니다.");
					} else {
						$("#retireDate").append(res.retireDate);
					}
					
					if(res.retireResn == null) {
						$("#retireResn").append("퇴사 사유가 없습니다.");
					} else {
						$("#retireResn").append(res.retireResn);
					}
					
					// 급여 관련 정보
					$("#bankCode").append(res.bankCode);
					$("#bankName").append(res.bankName);
					$("#account").append(res.account);
					
				}
			});
		}
		
	});
	
	
	
	
	$("#changePwdBtn").on("click", function(){
		$('#changePwdModal').modal('show');
	});
	
	$("#cancelFinalBtn").on("click", function(){
		$("#changePwd, #changePwd2").val("");
	});
	
	$("#changeFinalBtn").on("click", function(){
		
		if($("#changePwd").val() != $("#changePwd2").val()) {
			showToastMessage("두 비밀번호가 일치하지 않습니다.", "warning");
		} else {
			
			let pwd = {
					emplPwd : $("#changePwd").val(),
					emplNo : userId
					}
			
			$.ajax({
				url: "/employee/changePwd",
				method: "post",
				data: JSON.stringify(pwd),
				dataType: "json",
				contentType: "application/json; charset=UTF-8",
				success: function(res){
					console.log("비밀번호 변경 응답: ", res);
				}
			});
			
		}
		
	});
	
	let savedMessage = sessionStorage.getItem("toastMessage");
	let savedType = sessionStorage.getItem("toastType");

	if (savedMessage) {
		let toast = $("#toastMessage");
		toast.removeClass("bg-primary bg-success bg-danger bg-warning");
		toast.addClass(`bg-\${savedType}`);
		$("#toastBody").text(savedMessage);
		
		let toastInstance = new bootstrap.Toast(toast[0]);
		toastInstance.show();
		
		// 메시지 한 번 표시 후 제거 (새로고침 시 다시 뜨지 않도록)
		sessionStorage.removeItem("toastMessage");
		sessionStorage.removeItem("toastType");
	}
	
}); // ready function 종료 영역

</script>
</html>