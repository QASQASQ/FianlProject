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
	<title>사원 정보 수정 페이지</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/signature_pad@2.3.2/dist/signature_pad.min.js"></script>
	
<style type="text/css">
	input[readonly] {
    	background-color: #E2E2E2;
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
						<form action="profile.html" enctype="multipart/form-data" id="updateForm">
							<div class="border-bottom mb-3">
								<div class="row">
									<div class="col-md-12">
										<div>					
											<h6 class="mb-3">기본 정보</h6> <!-- 이 부분 부터 기본 정보 -->
											<div class="d-flex align-items-center flex-wrap row-gap-3 bg-light w-100 rounded p-3 mb-4">                                                
												<div id="divForImg" style="width: 250px; height: 300px;">
												<h6 class="mb-1" style="margin-bottom: 30px;">프로필 사진</h6>
												</div>                                              
												<div class="profile-upload" style="margin-left: 100px;">
													<div class="mb-2">
														<input type="file" id="profileImg" name="profileImgpath" class="form-control">
														
													</div>
													<div class="profile-uploader d-flex align-items-center">
														<button type="button" class="btn btn-primary" id="imgSaveBtn">저장</button>
														
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
												<input type="text" id="emplNo" name="emplNo" class="form-control" readonly>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
											</div>
											<div class="col-md-8">
											</div>
										</div>
									</div>
									
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">성명</label>
											</div>
											<div class="col-md-8">
												<input type="text" id="emplNm" class="form-control" readonly>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">직위</label>
											</div>
											<div class="col-md-8">
												<input type="text" id="emplPosition" class="form-control" readonly>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">부서</label>
											</div>
											<div class="col-md-8">
												<input type="text" id="deptCode" class="form-control" readonly>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">팀</label>
											</div>
											<div class="col-md-8">
												<input type="text" id="teamCode" class="form-control" readonly>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">생년월일</label>
											</div>
											<div class="col-md-8">
												<input type="text" id="emplBrthdy" class="form-control" readonly>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">입사 일자</label>
											</div>
											<div class="col-md-8">
												<input type="text" id="hireDate" class="form-control" readonly>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">권한</label>
											</div>
											<div class="col-md-8">
												<input type="text" id="emplAuth" class="form-control" placeholder="인사 관리자에게 문의하세요." readonly>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
											</div>
											<div class="col-md-8">
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">서명</label>
											</div>
											<div class="col-md-8">
												<button type="button" class="btn btn-primary" id="showSignBtn">등록</button>
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
												<input type="radio" name="gender" id="emplGenderM" class="emplGender" value="M">남성 <br/>
												
												<input type="radio" name="gender" id="emplGenderF" class="emplGender" value="F">여성
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">연락처</label>
											</div>
											<div class="col-md-8">
												<input type="text" id="emplTelno" class="form-control" placeholder="하이픈(-) 없이 입력하세요.">
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">이메일</label>
											</div>
											<div class="col-md-8">
												<input type="text" id="emplEmail" class="form-control" placeholder="ex) abc@gmail.com">
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											
											<div class="col-md-4">
												우편번호
											</div>
											<div class="col-md-8">
												<div class="input-group mb-2 sort-item">
													<input type="text" id="zipCode" class="form-control tech-item" placeholder="우편 번호" readonly>
													<button type="button" id="findAddr" class="btn btn-primary">주소 검색</button>
												</div>
											</div>
											
											<div class="col-md-4">
												기본주소
											</div>
											<div class="col-md-8">
												<div class="input-group mb-2">
													<input type="text" id="addrMain" class="form-control tech-item" placeholder="기본 주소" readonly>
												</div>
											</div>
											
											<div class="col-md-4">
												상세주소
											</div>
											<div class="col-md-8">
												<div class="input-group mb-2">
												<input type="text" id="addrDetail" class="form-control" placeholder="상세 주소">
												</div>
											</div>
											
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">취미</label>
											</div>
											<div class="col-md-8">
												<input type="text" id="emplHobby" class="form-control" placeholder="필수 기입 사항이 아닙니다.">
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">결혼 기념일자</label>
											</div>
											<div class="col-md-8">
												<input type="date" id="emplMrnry" class="form-control">
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">세대주 여부</label>
											</div>
											<div class="col-md-8">
												<input type="radio" name="householderAt" id="householderAtY" class="householderAt" value="Y">세대주 <br/>
												<input type="radio" name="householderAt" id="householderAtN" class="householderAt" value="N">세대원
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">차량 번호</label>
											</div>
											<div class="col-md-8">
												<input type="text" id="vehicleNumber" class="form-control" placeholder="차량 소지자에 한하여 기입합니다.">
											</div>
										</div>
									</div>
									
								</div>
							</div>
							<div class="border-bottom mb-3">
								<h6 class="mb-3">급여 관련 정보</h6>
								<div class="row">
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">은행</label>
											</div>
											<div class="col-md-8">
												<select id="bankCode" name="bankCode" class="form-select">
							            			<option>은행 선택</option>	<!-- 은행코드 전부 받아오기 -->
							            		</select>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">지점 명</label>
											</div>
											<div class="col-md-8">
												<input type="text" id="bankName" class="form-control">
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="row align-items-center mb-3">
											<div class="col-md-4">
												<label class="form-label mb-md-0">계좌 번호</label>
											</div>
											<div class="col-md-8">
												<input type="text" id="account" class="form-control">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="d-flex align-items-center justify-content-end">
								<button type="button" class="btn btn-success me-2" id="exampleButton">예시</button>
								<a href="/hrms/employee/employeeInfo"><button type="button" class="btn btn-secondary border me-2" id="cancelBtn">취소</button></a>
								<button type="button" class="btn btn-primary" id="saveBtn">등록</button>
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
	
	<!-- 주소 검색 모달 -->
	<div class="modal fade" id="addrModal" tabindex="-1" aria-labelledby="addrModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content" style="width: 535px;">
	            <div class="modal-header">
	                <h5 class="modal-title" id="addrModalLabel">주소 검색</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                <div id="addrLayer" style="width:500px;height:500px;"></div>
	            </div>
	        </div>
	    </div>
	</div>
	
	<!-- 서명 모달 -->
	<div class="modal fade" id="signModal" tabindex="-1" aria-labelledby="addrModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="addrModalLabel">전자 서명</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	            	<canvas id="signatureCanvas" width="465" height="300" style="border: 1px solid #ccc;"></canvas>
	                <!-- <div id="addrLayer" style="width:500px;height:300px;"></div> -->
	            </div>
	            <div class="modal-footer">
		        	<button type="button" id="clearSignature" class="btn btn-secondary me-2">서명 지우기</button>
		        	<button type="button" id="saveSignature" class="btn btn-primary">서명 저장</button>
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

<script>
	$(document).ready(function () {
    $("#exampleButton").click(function () {
        // 1️⃣ 성별 랜덤 선택
        let genders = ["M", "F"];
        let randomGender = genders[Math.floor(Math.random() * genders.length)];
        if (randomGender === "M") {
            $("#emplGenderM").prop("checked", true);
        } else {
            $("#emplGenderF").prop("checked", true);
        }

        // 2️⃣ 랜덤 연락처 
        function generatePhoneNumber() {
            let firstPart = Math.floor(1000 + Math.random() * 9000);  // 4자리
            let secondPart = Math.floor(1000 + Math.random() * 9000); // 4자리
            return `010\${firstPart}\${secondPart}`;
        }
        $("#emplTelno").val(generatePhoneNumber());

        // 3️⃣ 랜덤 이메일 생성
        const emailNames = ["hermes1234", "wonbin5678", "hellowolrd2023", "dev001", "dongjun456", "gwon203", "yerim00"];
        const emailDomains = ["gmail.com", "naver.com", "daum.net", "kakao.com"];
        let randomEmail = `\${emailNames[Math.floor(Math.random() * emailNames.length)]}@\${emailDomains[Math.floor(Math.random() * emailDomains.length)]}`;
        $("#emplEmail").val(randomEmail);

        // 4️⃣ 취미 랜덤 선택
        const hobbies = ["독서", "등산", "요리", "여행", "게임", "음악 감상", "사진 촬영"];
        let randomHobby = hobbies[Math.floor(Math.random() * hobbies.length)];
        $("#emplHobby").val(randomHobby);

        // 5️⃣ 결혼 기념일이 없거나 있을 확률 50%
        function getRandomMarriageDate() {
            if (Math.random() < 0.5) return ""; // 50% 확률로 빈 값 반환
            let year = Math.floor(Math.random() * (2022 - 1980 + 1)) + 1980;
            let month = String(Math.floor(Math.random() * 12) + 1).padStart(2, '0');
            let day = String(Math.floor(Math.random() * 28) + 1).padStart(2, '0');
            return `\${year}-\${month}-\${day}`;
        }
        $("#emplMrnry").val(getRandomMarriageDate());

        // 6️⃣ 세대주 여부 랜덤 선택
        let headOfHousehold = Math.random() < 0.5 ? "Y" : "N";
        if (headOfHousehold === "Y") {
            $("#householderAtY").prop("checked", true);
        } else {
            $("#householderAtN").prop("checked", true);
        }

        // 7️⃣ 랜덤 차량번호
        function generateCarNumber() {
					const validKoreanChars = ["가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하"];
					let regionCode = Math.floor(10 + Math.random() * 90); // 10~99 숫자
					let middleChar = validKoreanChars[Math.floor(Math.random() * validKoreanChars.length)]; // 한글 한 글자

					let isNewType = Math.random() < 0.5; // 50% 확률로 신형/구형 랜덤
					let lastNumbers = isNewType
							? Math.floor(1000 + Math.random() * 9000) // 신형(4자리)
							: Math.floor(100 + Math.random() * 900);  // 구형(3자리)

					return `\${regionCode}\${middleChar} \${lastNumbers}`;
			}

			$("#vehicleNumber").val(generateCarNumber());

        // 8️⃣ 랜덤 은행 선택 및 지점명, 계좌번호 자동 입력
        const bankList = {
            "001": "한국은행",
            "002": "산업은행",
            "003": "기업은행",
            "004": "국민은행",
            "005": "외환은행",
            "011": "농협은행",
            "020": "우리은행",
            "045": "새마을금고중앙회",
            "048": "신협중앙회"
        };

        let bankKeys = Object.keys(bankList);
        let randomBankKey = bankKeys[Math.floor(Math.random() * bankKeys.length)];
        let randomBranch = `\${bankList[randomBankKey]} \${Math.floor(100 + Math.random() * 900)}지점`;

        function generateBankAccount() {
            return Math.floor(100000000000 + Math.random() * 900000000000).toString();
        }

        $("#bankCode").val(randomBankKey).trigger("change");
        $("#bankName").val(randomBranch);
        $("#account").val(generateBankAccount());
    });
});


</script>
</body>
<script>
const userId = sessionStorage.getItem("userId"); // 세션 아이디 가져오기
console.log("userId: ", userId);



$(function(){
	
	// 사원 권한 가져오기
/* 	$.ajax({
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
	        	
	            authHtml += "<span style='margin-right: 10px;'>" + res[i].authCode + "</span>";
	        }
			
			$("#emplAuth").html(authHtml);
			
		}
	}); */
	
	// 프로필 이미지 업로드
	let imgSaveBtn = $("#imgSaveBtn");
	
	imgSaveBtn.on("click", function(){
		
		let formData = new FormData($("#updateForm")[0]);
		
		$.ajax({
			url: "/employee/profileImgUpload",
			method: "post",
			data: formData,
			processData: false,
			contentType: false,
			success: function(res){
				console.log("##########: ", res);
				
				showToastMessage("이미지 등록이 완료되었습니다.", "success");
					$("#divForImg img").attr("src", "/profile_images/" + res);
				
			},
			error: function(error){
				showToastMessage("이미지 등록에 오류가 발생했습니다.", "danger");
			}
		});
		
	});
	
	// selectbox 들어갈 은행 목록
	let bankSelect = $("#bankCode");
	let bankCode = "BANKCODE";
	let bankCodedata = {bankCode : bankCode};
	
	$.ajax({
		url: "/employee/getBankCodes",
		method: "get",
		data: bankCodedata,
		dataType: "json",
		success: function(res) {
			console.log("은행 목록: ", res);
			
			$.each(res, function(index, item) {
				console.log(`ccCode: \${item.ccCode}, ccName: \${item.ccName}`);
				bankSelect.append(`<option value="\${item.ccCode}">\${item.ccName}</option>`);
            });
			
		}
	});
	
	let userIdData = {userId : userId};
	
	$.ajax({
		url: "/employee/getSomeCode",
		method: "get",
		data: userIdData,
		dataType: "json",
		success: function(res){
			let userPosition = res[0].EMPL_POSITION;
			let userDept = res[0].DEPT_CODE;
			let userTeam = res[0].TEAM_CODE;
			let userBank = res[0].BANK_CODE;
			
			const data = {
					emplNo : userId,
					emplPosition : userPosition,
					deptCode : userDept,
					teamCode : userTeam,
					bankCode : userBank
					};
			
					$.ajax({////////////////////
						url: "/employee/getEmplInfo",
						method: "get",
						data: data,
						dataType: "json",
						success: function(res){
							console.log("사원 정보: ", res);
							
							//프로필 이미지 띄우기
							let divForImg = $("#divForImg");
							
							if(res.profileImgpath == null) {
								$("#divForImg").append(`<img src='${pageContext.request.contextPath }/assets/img/profile_images/forNull.png'>`);
							} else {
								$("#divForImg").append(`<img src='/profile_images/\${res.profileImgpath}' alt='Profile Image'>`);
							}
							
							$("#emplNo").val(res.emplNo);
							$("#emplNm").val(res.emplNm);
							$("#emplPosition").val(res.emplPosition);
							$("#deptCode").val(res.deptCode);
							$("#teamCode").val(res.teamCode);
							$("#emplBrthdy").val(res.emplBrthdy);
							$("#hireDate").val(res.hireDate);
							
							// 먼저 모든 라디오 버튼을 체크 해제합니다.
							$(".emplGender").prop("checked", false);

							// 성별 정보가 있을 때만 체크
							if (res.emplGender === "M") {
							    $("#emplGenderM").prop("checked", true);
							} else if (res.emplGender === "F") {
							    $("#emplGenderF").prop("checked", true);
							}
							
							$("#emplTelno").val(res.emplTelno);
							$("#emplEmail").val(res.emplEmail);
							$("#zipCode").val(res.zipCode);
							$("#addrMain").val(res.addrMain);
							$("#addrDetail").val(res.addrDetail);
							$("#emplHobby").val(res.emplHobby);
							$("#emplMrnry").val(res.emplMrnry);
							
							if(res.householderAt == "Y"){
								$("#householderAtY").attr("checked", "checked");
							}
							if(res.householderAt == "N") {
								$("#householderAtN").attr("checked", "checked");
							}
							
							$("#vehicleNumber").val(res.vehicleNumber);
							
							let getBankCode = {userId : res.emplNo};
							
							$.ajax({	// 은행 코드 하나만 들고오기
								url: "/employee/getBankCode",
								method: "get",
								data: getBankCode,
								success: function(res) {
									console.log("은행코드만 가져온 값: ", res);
									
									// 급여 관련 정보
									let bankSelector = $("#bankCode");
									bankSelector.val(res);
								},
								error: function(error) {
									showToastMessage("문제가 발생했습니다.", "danger");
								}
							})
							
							$("#bankName").val(res.bankName);
							$("#account").val(res.account);
							
						}
					});
			
			}
		});
	
	let findAddr = $("#findAddr");
	
	findAddr.on("click", function(){
		
		$("#addrModal").modal("show");
		
		 // 다음 주소 API 실행
        new daum.Postcode({
            oncomplete: function(data) {
                // 선택한 주소를 입력 필드에 자동 입력
                $("#zipCode").val(data.zonecode); // 우편번호
                $("#addrMain").val(data.roadAddress); // 도로명 주소
                $("#addrDetail").focus(); // 상세 주소 입력으로 포커스 이동

                // 모달 닫기
                $("#addrModal").modal("hide");
            }
        }).embed(document.getElementById("addrLayer"));
		
	});
	
	// 수정 후 저장
	$("#saveBtn").on("click", function(){
		showConfirmModal("수정내용을 저장하시겠습니까?").then((isConfirmed) => {
			let emplGender = $(".emplGender:checked").val();
			console.log("### emplGender: ", emplGender);
			
			let emplTelno = $("#emplTelno").val();
			let emplEmail = $("#emplEmail").val();
			let zipCode = $("#zipCode").val();
			let addrMain = $("#addrMain").val();
			let addrDetail = $("#addrDetail").val();
			let emplHobby = $("#emplHobby").val();
			let emplMrnry = $("#emplMrnry").val();
			let householderAt = $(".householderAt:checked").val();
			console.log("### householderAt: ", householderAt);
			
			let vehicleNumber = $("#vehicleNumber").val();
			
			// 급여 관련 정보
			let bankCode2 = $("#bankCode").val();
			let bankName = $("#bankName").val();
			let account = $("#account").val();
			
			console.log("업데이트 눌렀을때 파라미터: ", account);
			console.log("업데이트 눌렀을때 파라미터: ", emplEmail);
			
			let data2 = {
					emplNo : userId,	// 조건절 용도의 사원번호
					emplGender : emplGender,
					emplTelno : emplTelno,
					emplEmail : emplEmail,
					zipCode : zipCode,
					addrMain : addrMain,
					addrDetail : addrDetail,
					emplHobby : emplHobby,
					emplMrnry : emplMrnry,
					householderAt : householderAt,
					vehicleNumber : vehicleNumber,
					bankCode : bankCode2,
					bankName : bankName,
					account : account
			};
			
			console.log("### data2: ", data2);
			
			$.ajax({
				url: "/employee/employeeUpdate",
				method: "post",
				data: JSON.stringify(data2),
				dataType: "json",
				contentType: "application/json; charset=UTF-8",
				success: function(res){
					console.log("업데이트 응답: ", res);
					
					if(res == 1) {
						showSessionToastMessage("수정이 완료되었습니다.", "success");
						 location.href = "/hrms/employee/employeeInfo";
					} else {
						showToastMessage("수정에 실패했습니다.", "danger");
					}
				}
			});
			
			
		});
		
		
	});
	
	$("#showSignBtn").on("click", function(){
		$("#signModal").modal("show");
		
		// 모달이 열렸을 때 캔버스 초기화
	  	var canvas = document.getElementById('signatureCanvas');
	    var signaturePad = new SignaturePad(canvas);

	    // 서명 지우기 버튼 이벤트
	    $("#clearSignature").on("click", function(){
	      signaturePad.clear();
	    });
	    
	    // 서명 저장 버튼 눌렀을 때
		$("#saveSignature").on("click", function(){
			
			if (signaturePad.isEmpty()) {
				showToastMessage("서명 후 저장해주세요.", "warning");
		      	return;
		    }
			
			// 캔버스의 내용을 데이터 URL (base64 문자열)로 변환
		    let dataURL = signaturePad.toDataURL("image/png");
			
			let payload = {
				emplNo: userId,
				signatureData: dataURL
			};
			
			$.ajax({
				url: "/employee/saveSignature",
				type: "post",
				data: JSON.stringify(payload),
				contentType: 'application/json; charset=UTF-8',
				success: function(res) {
					showToastMessage("서명이 저장되었습니다.", "success");
				},
				error: function(error) {
					showToastMessage("서명 저장에 오류가 발생하였습니다.", "danger");
		      	}
			});
			
		});
	    
	});
	
});
</script>
</html>