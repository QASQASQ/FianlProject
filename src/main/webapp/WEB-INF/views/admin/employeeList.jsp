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
.modal{
            position:absolute;
            display:none;
            
            justify-content: center;
            top:0;
            left:0;

            width:100%;
            height:100%;
            background-color: rgba(0,0,0,0.4);
        }
        
.modal_body{
            position:absolute;
            top:50%; 
        
            padding:40px;  

            text-align: center;

            background-color: rgb(255,255,255); 
            border-radius:10px;
            box-shadow:0 2px 3px 0 rgba(34,36,38,0.15); 

            transform:translateY(-50%); 
        }
.form-label{
	width: 100px;
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
		
		<!-- Page Wrapper -->
		<div class="page-wrapper">
			<div class="content">

				<!-- Breadcrumb -->
				<div class="d-md-flex d-block align-items-center justify-content-between page-breadcrumb mb-3">
					<div class="my-auto mb-2">
						<h2 class="mb-1">전체사원 목록</h2>
					</div>
					<div class="d-flex my-xl-auto right-content align-items-center flex-wrap ">
						<div class="me-2 mb-2">
						</div>
						<div class="mb-2">
							<button class="btn-open-modal btn btn-primary d-flex align-items-center"><i class="ti ti-circle-plus me-2"></i>신규</button>
						</div>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<!-- Leads List -->
				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>전체사원 목록</h5>
						<div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="text" class="form-control" placeholder="사번" style="width: 100px;" id="emplNo">
								</div>
							</div>
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="text" class="form-control" placeholder="이름" style="width: 100px;" id="emplNm">
								</div>
							</div>
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<select class="form-select" style="width: 100px;" id="deptCode">
									</select>
								</div>
							</div>
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<select class="form-select" style="width: 100px;" id="emplPosition">
									</select>
								</div>
							</div>
							<input type="button" class="btn btn-primary d-flex align-items-center" value="검색" id="searchBtn">
						</div>
					</div>
					<div class="card-body p-0">
						<div class="custom-datatable-filter table-responsive">
							<table class="table datatable">
								<thead class="thead-light">
									<tr>
										<th>사원번호</th>
										<th>사원프로필 이미지</th>
										<th>사원명</th>
										<th>직급</th>
										<th>부서</th>
										<th>팀</th>
									</tr>
								</thead>
								<tbody id="table-tbody">
									<tr>
										<td><p class="fs-14 text-dark fw-medium">We scheduled a meeting for next week</p>
										<td>
											<span class=" badge badge-pink-transparent"><i class="ti ti-device-computer-camera me-1"></i>Meeting</span>
										</td>
										<td>16 Jan 2024</td>
										<td>Hendry</td>
										<td>14 Jan 2024</td>
										<td>
											<div class="action-icon d-inline-flex">
												<a href="#" class="me-2" data-bs-toggle="modal" data-bs-target="#edit_activity"><i class="ti ti-edit"></i></a>
												<a href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#delete_modal"><i class="ti ti-trash"></i></a>
											</div>
										</td>
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

		<!-- Add Activiy -->
		<div class="modal">
			<div class="modal_body">
				<div class="modal-header">
	            	<h4 class="modal-title">신규사원 추가</h4>
	            </div>
	            <form id="employeeForm">
	            	<div class="modal-body p-4">
		            	<div class="row">
			            	<div class="col-md-6">
			            		<div class="mb-3 d-flex align-items-center">
					            	<label class="form-label me-2">사원번호 </label>
				            		<input type="text" id="emplNo1" name="emplNo" class="form-control"/>
					            </div>
				            </div>
				            <div class="col-md-6">
					            <div class="mb-3 d-flex align-items-center">
					            	<label class="form-label me-2">비밀번호 </label>
				            		<input type="text" id="emplPwd1" name="emplPwd" class="form-control"/>
					            </div>
				            </div>
						</div>
						<div class="row">
				            <div class="col-md-6">
								<div class="mb-3 d-flex align-items-center">
					            	<label class="form-label me-2">사원명 </label>
				            		<input type="text" id="emplNm1" name="emplNm" class="form-control"/>
					            </div>
				            </div>
		            		<div class="col-md-6">
		            			<div class="mb-3 d-flex align-items-center">
			            			<label class="form-label me-2">직위 코드 </label>
					            	<select id="positionSelect1" name="emplPosition" class="form-control">
					            			<option>직위 선택</option> <!-- 직위 코드 다 받아와서 동적 출력(공통코드 테이블 내부) -->
			            			</select>
		            			</div>
	            			</div>
	            		</div>
		            	<div class="row">
	            			<div class="col-md-6">
	            				<div class="mb-3 d-flex align-items-center">
	            					<label class="form-label me-2">부서 코드 </label>
				            		<select id="deptCode1" name="deptCode" class="form-control">
				            			<option>부서 선택</option> <!-- 부서 목록 다 받아와서 동적 출력 -->
				            		</select>
            					</div>
           					</div>
           					<div class="col-md-6">
	            				<div class="mb-3 d-flex align-items-center">
	            					<label class="form-label me-2">팀 코드 </label>
				            		<select id="teamCode1" name="teamCode" class="form-control">
				            			<option>팀 선택</option> <!-- 팀 목록 다 받아와서 동적 출력 -->
				            		</select>
	            				</div>
	            			</div>
	            		</div>
	            		<div class="row">
	            			<div class="col-md-6">
			            		<div class="mb-3 d-flex align-items-center">
			            			<label class="form-label me-2">생년월일 </label>
			            			<input type="date" id="emplBrthdy1" name="emplBrthdy" class="form-control"/>
			            		</div>
			            	</div>
	            			<div class="col-md-6">
			            		<div class="mb-3 d-flex align-items-center">
			            			<label class="form-label me-2">입사 일자 </label>
			            			<input type="date" id="hireDate1" name="hireDate" class="form-control"/>
			            		</div>
			            	</div>
	            		</div>
	            		<div class="row">
	            			<div class="col-md-6">
			            		<div class="mb-3 d-flex align-items-center">
			            			<label class="form-label me-2">은행코드 </label>
			            			<select id="bankCode1" name="bankCode" class="form-control">
			            				<option>은행 선택</option>	<!-- 은행코드 전부 받아오기 -->
			            			</select>
			            		</div>
		            		</div>
	            			<div class="col-md-6">
			            		<div class="mb-3 d-flex align-items-center">
			            			<label class="form-label me-2">은행지점명 </label>
			            			<input type="text" id="bankName1" name="bankName" class="form-control"/>
			            		</div>
		            		</div>
	            		</div>
	            		<div class="row">
		            		<div class="col-md-12">
		            			<div class="mb-3 d-flex align-items-center">
		            				<label class="form-label me-2">계좌 번호 </label>
				            		<input type="number" id="account1" name="account" class="form-control" placeholder="-없이 입력해주세요"/>
				            	</div>
		            		</div>
	            		</div>
	            		<div class="col-md-12">
	            			<div class="mb-3 d-flex align-items-center">
	            				<label class="form-label me-2">기본 급여 </label>
			            		<input type="number" id="basicSalary1" name="basicSalary" class="form-control"/>
			            	</div>
	            		</div>
	            		<div class="col-md-12">
	            			<div class="mb-3">
	            				<label class="form-label">권한 부여 </label>
	            				<div id="authContainer" class="mt-2">
	            					<div class="mb-2 input-group">
							        	<select id="authSelect1" name="authSelect" class="authSelect form-control">
				           					<option>권한 선택</option>
					           			</select>
					           			<button id="addAuthBtn" class="btn btn-primary me-2 align-items-center">추가 권한</button>
				           			</div>
					           	</div>
	            			</div>
            			</div>
            			
            		</div>
									<button type="button" id="exampleButton" class="btn btn-success me-2">예시</button>
			            <button class="btn-close-modal btn btn-secondary me-2 waves-effect">취소</button>
			            <button type="button" id="saveBtn" class="btn btn-primary me-2 align-items-center">등록</button>
	            </form>
	            <br>
	            <div class="modal-footer">
				    <div class="col-md-12">
				        <div class="mb-3 d-flex align-items-center">
				            <label class="form-label me-2">일괄 등록</label>
				            <form id="bulkEmployeeForm" method="post" enctype="multipart/form-data" class="d-flex align-items-center w-100">
				                <input type="file" name="excelFile" accept=".xlsx, .xls" required class="form-control me-2" style="width: 500px;"/>
				                <button type="button" id="bulkSaveBtn" class="btn btn-primary d-inline-flex align-items-center justify-content-center">등록</button>
				            </form>
				        </div>
				    </div>
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
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/managingEmployee.js"></script>
	<script>
		$(document).ready(function () {
			const departmentList = {
					"01": { name: "경영 인사", teams: { "01001": "경영 인사 1팀", "01002": "경영 인사 2팀" } },
					"02": { name: "마케팅", teams: { "02001": "마케팅 1팀", "02002": "마케팅 2팀" } },
					"03": { name: "연구 개발", teams: { "03001": "연구 개발 1팀", "03002": "연구 개발 2팀" } },
					"04": { name: "운영", teams: { "04001": "운영 1팀", "04002": "운영 2팀" } },
					"05": { name: "재무 회계", teams: { "05001": "재무 회계 1팀", "05002": "재무 회계 2팀" } }
			};
	
			$("#exampleButton").click(function () {
					function generateEmployeeId() {
							return "2025" + Math.floor(10000 + Math.random() * 90000);
					}
	
					const koreanNames = ["김희수", "박선희", "박민수", "최지훈", "정하나", "한예진", "윤서준", "조민석", "강다은", "신동현"];
					let randomName = koreanNames[Math.floor(Math.random() * koreanNames.length)];
	
					const positionList = {
							"01": "사원",
							"02": "대리",
							"03": "과장",
							"04": "차장",
							"05": "부장"
					};
	
					let positionKeys = Object.keys(positionList);
					let randomPositionKey = positionKeys[Math.floor(Math.random() * positionKeys.length)];
					let randomPosition = positionList[randomPositionKey];
	
	
	
					let departmentKeys = Object.keys(departmentList);
					let randomDepartmentKey = departmentKeys[Math.floor(Math.random() * departmentKeys.length)];
					let randomDepartment = departmentList[randomDepartmentKey];
	
					let teamKeys = Object.keys(randomDepartment.teams);
					let randomTeamKey = teamKeys[Math.floor(Math.random() * teamKeys.length)];
	
					function getRandomBirthDate() {
							let year = Math.floor(Math.random() * (2005 - 1985 + 1)) + 1985;
							let month = String(Math.floor(Math.random() * 12) + 1).padStart(2, '0');
							let day = String(Math.floor(Math.random() * 28) + 1).padStart(2, '0');
							return `\${year}-\${month}-\${day}`;
					}
	
					function getTodayDate() {
							let today = new Date();
							let year = today.getFullYear();
							let month = String(today.getMonth() + 1).padStart(2, '0');
							let day = String(today.getDate()).padStart(2, '0');
							return `\${year}-\${month}-\${day}`;
					}
	
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
	
					let randomSalary = Math.floor(Math.random() * 13) * 500000 + 2000000;
	
					$("#emplNo1").val(generateEmployeeId());
					$("#emplPwd1").val("1234");
					$("#emplNm1").val(randomName);
					$("#positionSelect1").val(randomPositionKey).trigger("change");
					$("#deptCode1").val(randomDepartmentKey).trigger("change");
	
					setTimeout(() => {
							$("#teamCode1").val(randomTeamKey).trigger("change");
					}, 300);
	
					$("#emplBrthdy1").val(getRandomBirthDate());
					$("#hireDate1").val(getTodayDate());
					$("#bankCode1").val(randomBankKey).trigger("change");
					$("#bankName1").val(randomBranch);
					$("#account1").val(generateBankAccount());
					$("#basicSalary1").val(randomSalary);
	
			});
	
			$("#deptCode1").change(function () {
					let selectedDept = $(this).val();
					let teamSelect = $("#teamCode1");
	
					teamSelect.empty();
					teamSelect.append(`<option>팀 선택</option>`);
	
					if (departmentList[selectedDept]) {
							let teams = departmentList[selectedDept].teams;
							for (let teamCode in teams) {
									teamSelect.append(`<option value="\${teamCode}">\${teams[teamCode]}</option>`);
							}
					}
			});
	});
	
	
	</script>
</body>
<script>
let table_tbody = $("#table-tbody");
let searchBtn = $("#searchBtn");
let pagingArea = $("#pagingArea");
let deptCode = $("#deptCode");
let emplPosition = $("#emplPosition");

$(function(){
	getSelectBoxList();
	if(!sessionStorage.getItem("currentPage")){
		printList(1); // 페이지 최초로드시
	}else{
		printList(sessionStorage.getItem("currentPage"));
	}
	// 검색버튼 클릭이벤트
	searchBtn.on("click", function(){ 
		let emplNo = $("#emplNo").val();
		let emplNm = $("#emplNm").val();
		let emplPosition = $("#emplPosition").val();
		let deptCode = $("#deptCode").val();
		printList(1, emplNo, emplNm, emplPosition, deptCode);
	});
	
	// 페이지버튼 클릭이벤트
	pagingArea.on("click", "a", function(){ 
		event.preventDefault();
		let page = $(this).data("page");
		let emplNo = $("#emplNo").val();
		let emplNm = $("#emplNm").val();
		let emplPosition = $("#emplPosition").val();
		let deptCode = $("#deptCode").val();
		sessionStorage.setItem("currentPage", page);
		printList(page, emplNo, emplNm, emplPosition, deptCode);
	});
	
});

//목록가져오기 함수
function printList(page, emplNo, emplNm, emplPosition, deptCode){
	data = {page : page}
	if(emplNo != null){data.emplNo = emplNo}
	if(emplNm != null){data.emplNm = emplNm}
	if(emplPosition != null){data.emplPosition = emplPosition}
	if(deptCode != null){data.deptCode = deptCode}
	$.ajax({
		url : "/hrms/admin/selectEmplList",
		type : "post",
		data : JSON.stringify(data),
		contentType : "application/json;charset=utf-8",
		success : function(res){
			console.log(res);
			let tr = "";
			for(let i=0; i<res.emplList.length; i++){
				let img = "";
				if(res.emplList[i].profileImgpath != null){
					img = res.emplList[i].profileImgpath;
				}else{
					img = "forNull.png";
				}
				tr += `
					<tr>
						<td>\${res.emplList[i].emplNo}</td>
						<td><img src="/profile_images/\${img}" class="card-img mb-3" alt="img" style="width:100px; height:100px; object-fit: cover;"></td>
						<td><a href="/hrms/admin/employeeDetail/\${res.emplList[i].emplNo}">\${res.emplList[i].emplNm}</a></td>
						<td>\${res.emplList[i].emplPosition}</td>
						<td>\${res.emplList[i].deptCode}</td>
						<td>\${res.emplList[i].teamCode}</td>
					</tr>
				`;
			}
			table_tbody.html(tr);
			pagingArea.html(res.pageVO.pagingHTML)
		},
		error : function(error){
			console.log(error);
		}
	});
}

function getSelectBoxList(){
	$.ajax({
		url : "/hrms/admin/getSelectBoxList",
		type : "post",
		success : function(res){
			console.log(res);
			let deptOptions = "<option value='' selected>부서</option>";
			for(let i=0; i<res.deptCode.length; i++){
				deptOptions += `
					<option value="\${res.deptCode[i].deptCode}">\${res.deptCode[i].deptName}</option>
				`;
			}
			let emplPositionOptions = "<option value='' selected>직급</option>";
			for(let i=0; i<res.emplPosition.length; i++){
				emplPositionOptions += `
					<option value="\${res.emplPosition[i].ccCode}">\${res.emplPosition[i].ccName}</option>
				`;
			}
			
			deptCode.html(deptOptions);
			emplPosition.html(emplPositionOptions);
			
		},
		error : function(error){console.log(error);}
	});
}
</script>
</html>