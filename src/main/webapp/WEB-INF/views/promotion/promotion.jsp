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
	<title>승진관리</title>
    
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
						<h2 class="mb-1">승진관리</h2>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<div class="row">

				</div>

				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>사원목록</h5>
						<div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="text" class="form-control" placeholder="사번" style="width: 120px;" id="emplNo">
								</div>
							</div>
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="text" class="form-control" placeholder="사원명" style="width: 100px;" id="emplNm">
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
							<table class="table datatable text-center">
								<thead class="thead-light">
									<tr>
										<th>사원번호</th>
										<th>사원명</th>
										<th>직급</th>
										<th>부서</th>
										<th>근속연수 <i class="fas fa-sort sort-icon" id="yearsSort"></i></th>
										<th>성과평가점수 <i class="fas fa-sort sort-icon" id="scoresSort"></i></th>
										<th>교육내역</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="table-tbody-up">
								</tbody>
							</table>
						</div>
					</div>
					<div id="pagingAreaUp" style="display: flex; justify-content: center; align-items: center; padding:15px;">
						
					</div>
				</div>
				<!--심사대상 추가 후 밑에 추가  -->
				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>심사대상자</h5>
						<button type="button" class="btn btn-primary d-flex align-items-center" id="terminateBtn">심사종료</button>
					</div>
					<div class="card-body p-0">
						<div class="custom-datatable-filter table-responsive">
							<table class="table datatable text-center">
								<thead class="thead-light">
									<tr>
										<th>사원번호</th>
										<th>사원명</th>
										<th>직급</th>
										<th>부서</th>
										<th>근속연수</th>
										<th>성과평가점수</th>
										<th>교육내역</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="table-tbody-down">
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<!--/심사대상추가 후 밑에 표시  -->
			</div>

			<!-- Footer -->
			<%@ include file="/WEB-INF/views/theme/footer.jsp" %>
			<!-- /Footer -->

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
<script type="text/javascript">

let deptCode = $("#deptCode");
let emplPosition = $("#emplPosition");
let searchBtn = $("#searchBtn");
let addBtn = $("#addBtn");
let promBtn = $("#promBtn");
let tableTbodyUp = $("#table-tbody-up");
let tableTbodyDown = $("#table-tbody-down");
let pagingAreaUp = $("#pagingAreaUp");
let terminateBtn = $("#terminateBtn"); 

let yearsSort = $("#yearsSort");
let scoresSort = $("#scoresSort");
let sorting = 1;

$(function(){
	
	getEmplList(1);
	getPromList();
	getSelect();
	
	yearsSort.on("click", function(){
		if(sorting >= 3){
			sorting = 1;
			searchFun(sorting);
			console.log(sorting);
			return;
		}else{
			sorting++;
			searchFun(sorting);
			console.log(sorting);
			return;
		}
	});
	scoresSort.on("click", function(){
		if(sorting <= 3 || sorting >= 6){
			sorting = 4;
			searchFun(sorting);
			console.log(sorting);
			return;
		}else{
			sorting++;
			searchFun(sorting);
			console.log(sorting);
			return;
		}
	});
	

	searchBtn.on("click", searchFun);
	
	// 페이지버튼 클릭이벤트
	pagingAreaUp.on("click", "a", function(){ 
		event.preventDefault();
		let page = $(this).data("page");
		let emplNo = $("#emplNo").val();
		let emplNm = $("#emplNm").val();
		let emplPosition = $("#emplPosition").val();
		let deptCode = $("#deptCode").val();
		getEmplList(page, emplNo, emplNm, emplPosition, deptCode, sorting);
	});
	
	//심사대상자 추가버튼
	$(document).on("click", ".addTargetBtn", function(){
		let emplPosition = $(this).closest('tr').find('td').eq(2).text().trim();
		if(emplPosition == "부장"){
			showToastMessage("부장급 이상은 더이상 승진할 수 없습니다.", "warning");
			return;
		}
		let emplNo = $(this).closest('tr').find('td').eq(0).text().trim();
		promoteTarget(emplNo);
		getEmplList(1);
	});

	//승진버튼
	$(document).on("click", ".promBtn", function(){
		let emplNo = $(this).closest('tr').find('td').eq(0).text();
		promEmpl(emplNo);
	});
	
	//심사종료 버튼
	terminateBtn.on("click",function(){
		let textArr = [];
		$(".promListTr").each(function(){
			let text = $(this).find("td").eq(0).text().trim();
			textArr.push(text);
		});
		if(!(textArr.length > 0)){
			showToastMessage("심사대상자가 없습니다.", "warning");
			return;
		}
		promCancel(textArr);
	})
})

//목록
function getEmplList(page, emplNo, emplNm, deptCode, position, sorting){
	let data = {page:page}
	if(emplNo != null) data.emplNo = emplNo;
	if(emplNm != null) data.emplNm = emplNm;
	if(deptCode != null) data.deptCode = deptCode;
	if(position != null) data.position = position;
	if(sorting != null) data.sorting = sorting;
	$.ajax({
		url : "/hrms/prom/getEmplList",
		type : "post",
		data : JSON.stringify(data),
		contentType : "application/json;charset=utf-8",
		success : function(res){
			console.log(res);
			let tr = "";
			for(let i=0; i<res.evaluList.length; i++){
				tr += `
					<tr>
						<td>\${res.evaluList[i].emplNo}</td>
						<td>\${res.evaluList[i].emplNm}</td>
						<td>\${res.evaluList[i].emplPosition}</td>
						<td>\${res.evaluList[i].deptCode}</td>
						<td>\${res.evaluList[i].yearsOfService}</td>
						<td>\${res.evaluList[i].score}</td>
						<td>\${res.evaluList[i].education}</td>
						<td><button class="btn btn-primary d-flex align-items-center addTargetBtn">심사 대상자 추가</button></td>
					<tr>
				`;
			}
			tableTbodyUp.html(tr);
			pagingAreaUp.html(res.pageVO.pagingHTML);
			
		},
		error : function(){
			
		}
	});
}

function getSelect(){
	$.ajax({
		url : "/hrms/prom/getSelect",
		type : "post",
		success : function(res){
			console.log(res);
			
			let positionOption = "<option value=''>직급</option>";
			for(let i=0; i<res.commonCodeList.length; i++){
				positionOption += `
					<option value="\${res.commonCodeList[i].ccCode}">\${res.commonCodeList[i].ccName}</option>
				`;
			}
			emplPosition.html(positionOption);
			
			let deptOption = "<option value=''>부서</option>";
			for(let i=0; i<res.commonCodeList.length; i++){
				deptOption += `
					<option value="\${res.deptList[i].deptCode}">\${res.deptList[i].deptName}</option>
				`;
			}
			
			deptCode.html(deptOption);
		},
		error :function(){}
	});
}

//대상자 추가 
function promoteTarget(emplNo){
	console.log("emplNo:",emplNo);
	$.ajax({
		url : "/hrms/prom/promoteTarget",
		type : "post",
		data : JSON.stringify({emplNo:emplNo}),
		contentType : "application/json;charset=utf-8",
		success : function(res){
			showToastMessage(emplNo + "번의 사원이 심사대상자에 추가되었습니다.", "success");
			getPromList();
		},
		error : function(){}
	});
}

//심사대상자 테이블목록
function getPromList(){
	$.ajax({
		url : "/hrms/prom/getPromList",
		type : "post",
		success : function(res){
			console.log("resresresresres: ", res);
			let tr = "";
			for(let i=0; i<res.length; i++){
				tr += `
					<tr class="promListTr">
						<td>\${res[i].emplNo}</td>
						<td>\${res[i].emplNm}</td>
						<td>\${res[i].emplPosition}</td>
						<td>\${res[i].deptCode}</td>
						<td>\${res[i].yearsOfService}</td>
						<td>\${res[i].score}</td>
						<td>\${res[i].education}</td>
						<td><button class="btn btn-primary d-flex align-items-center promBtn">승진</button></td>
					<tr>
				`;
			}
			tableTbodyDown.html(tr);
		},
		error : function(){
			
		}
	});
}

//승진
function promEmpl(emplNo){
	$.ajax({
		url : "/hrms/prom/promEmpl",
		type : "post",
		data : JSON.stringify({emplNo:emplNo}),
		contentType : "application/json;charset=utf-8",
		success : function(res){
			getEmplList(1);
			getPromList();
		},
		error : function(){}
	});
}

//심사취소
function promCancel(emplList){
	$.ajax({
		url : "/hrms/prom/promCancel",
		type : "post",
		data : JSON.stringify(emplList),
		contentType : "application/json;charset=utf-8",
		success : function(res){
			getEmplList(1);
			getPromList();
		},
		error : function(){}

	});
}

// 검색함수
function searchFun(sorting){
	let emplNoSearch = $("#emplNo").val();
	let emplNmSearch = $("#emplNm").val();
	let emplPositionSearch = $("#emplPosition").val();
	let deptCodeSearch = $("#deptCode").val();
	getEmplList(1, emplNoSearch, emplNmSearch, deptCodeSearch, emplPositionSearch, sorting);
}
</script>

</html>