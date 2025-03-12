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
						<h2 class="mb-1">기안 문서함</h2>
					</div>
					<div class="d-flex my-xl-auto right-content align-items-center flex-wrap ">
						<div class="mb-2">
							<a href="/hrms/sanction/sanctionPage" class="btn btn-primary d-flex align-items-center"><i class="ti ti-circle-plus me-2"></i>신규</a>
						</div>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<!-- Leads List -->
				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>기안 문서 목록</h5>
						<div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
							<div class="card-tools">
								<form class="input-group input-group-sm" method="post" id="searchForm" style="width: 250px;">
									<input type="hidden" name="page" id="page"/>
									<input type="text" name="searchWord" class="form-control me-3" value="" placeholder="검색" style="height: 38px;">
									<div class="input-group-append">
										<button type="submit" class="btn btn-primary d-flex align-items-center justify-content-center" style="height: 38px; min-width: 80px; text-align: center;">검색</button>
									</div>
								</form>
							</div>
						</div>
					</div>
					<div class="card-body p-0">
						<div class="custom-datatable-filter table-responsive">
							<table class="table datatable">
								<thead class="thead-light">
									<tr>
										<th class="text-center">문서 번호</th>
										<th class="text-center">제목</th>
										<th class="text-center">양식</th>
										<th class="text-center">문서 상태</th>
										<th>기안 일자</th>
										<th class="text-center">첨부파일</th>
										<th class="text-center"></th>
									</tr>
								</thead>
								<tbody>
									
									<!-- 문서 목록 출력 영역 -->
									
								</tbody>
							</table>
						</div>
					</div>
					<div style="display: flex; justify-content: center; align-items: center; padding:15px;" id="pagingArea"></div>
				</div>
				<!-- /Leads List -->
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

let currentPage = 1;
const userId = sessionStorage.getItem("userId"); // 세션 아이디 가져오기
console.log("userId: ", userId);

let data = {
		userId : userId,
		currentPage : currentPage
		};
		
function preLoad(data){
	
	$.ajax({
		url: "/sanction/getDocumentsInfo",
		method: "get",
		data: data,
		dataType: "json",
		success: function(res){
			console.log(res);
			
			$("tbody").empty();
			
			$.each(res.documentList, function(i, doc){
				
				let apvText = "";
				let files = "";
				if(doc.docApv == '01') {
					apvText = '결재 중';
				}
				if(doc.docApv == '02') {
					apvText = '승인';
				}
				if(doc.docApv == '03') {
					apvText = '반려';
				}
				if(doc.fileIdentify != null && doc.fileIdentify != ''){
					files = "<img src='${pageContext.request.contextPath}/assets/img/icons/file-02.svg' style='display: block; margin: 0 auto;'>";
				}
				$("tbody").append(
					`<tr>
						<td class="text-center"><p>\${doc.docNo}</p></td>
						<td class="text-center"><p class="fs-14 text-dark fw-medium"><a href="/hrms/sanction/personalDocumentsDetail?docNo=\${doc.docNo}">\${doc.docTitle}</a></p>
						<td class="text-center">\${doc.dsCode}</td>
						<td class="text-center"><span class=" badge badge-pink-transparent">\${apvText}</span></td>
						<td>\${doc.sanctnRqstdt}</td>
						<td class="text-center">\${files}</td>
						<td class="text-center"><a href="/hrms/sanction/personalDocumentsDetail?docNo=\${doc.docNo}" class="btn btn-primary">자세히보기</a></td>
					</tr>`
				);
				
				if(apvText == '승인') {
					$("tbody tr:last-child .badge")
		            .removeClass("badge-pink-transparent")
		            .addClass("badge-success-transparent");
				} else if(apvText == '반려') {
					$("tbody tr:last-child .badge")
		            .removeClass("badge-pink-transparent")
		            .addClass("badge-purple-transparent");
				}
				
			});
			
			$("#pagingArea").html(res.pagingInfo.pagingHTML);
			
		},
		error: function(error){
			showToastMessage("개인문서 호출에 실패했습니다.", "danger");
		}
	});	// 페이지 로드 시 ajax
}

$(function(){
	
	// 문서 초기 로드
	preLoad(data);
	
	// 페이지 선택할 때
	$("#pagingArea").on("click", "a", function(event){
		event.preventDefault();
		let pageNo = $(this).data("page");
		console.log("pageNo: ", pageNo);
		
		currentPage = pageNo;
		
		let pageMoving = {
				userId : userId,
				currentPage : currentPage 
		};
		
		// 이동한 페이지로 로드 재호출
		preLoad(pageMoving);
	
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
	
});	// ready function 종료 영역

</script>
</html>