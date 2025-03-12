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
						<h2 class="mb-1">참조 문서함</h2>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<!-- Leads List -->
				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>참조 문서 목록</h5>
					</div>
					<div class="card-body p-0">
						<div class="custom-datatable-filter table-responsive">
							<table class="table datatable text-center">
								<thead class="thead-light">
									<tr>
										<th>문서 번호</th>
										<th>제목</th>
										<th>읽음 여부</th>
										<th>기안 일자</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<!-- 문서 목록 출력 영역 -->
								</tbody>
							</table>
						</div>
					</div>
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

$(function(){
	
	const userId = sessionStorage.getItem("userId"); // 세션 아이디 가져오기
	console.log("userId: ", userId);
	
	let data = {userId : userId};
	
	$.ajax({
		url: "/sanction/getRefDocuments",
		method: "get",
		data: data,
		dataType: "json",
		success: function(res){
			console.log(res);
			
			$.each(res, function(i, doc){
				
				let readText = "";
				
				if(doc.refRead == 'N') {
					readText = '안읽음';
				}
				if(doc.refRead == 'Y') {
					readText = '읽음';
				}
				
				$("tbody").append(
					`<tr>
						<td>
							<p>\${doc.docNo}</p>
						</td>
						<td><p class="fs-14 text-dark fw-medium">
								<a class="documentTitle" href="/hrms/sanction/personalDocumentsDetail?docNo=\${doc.docNo}" data-no="\${doc.docNo}" data-refread="\${doc.refRead}">
									\${doc.docTitle}
								</a>
							</p>
						<td>
							<span class="badge badge-pink-transparent">\${readText}</span>
						</td>
						<td>\${doc.sanctnRqstdt}</td>
						<td><a class="btn btn-primary" href="/hrms/sanction/personalDocumentsDetail?docNo=\${doc.docNo}">자세히보기</a></td>
					</tr>`		
				);
				
				if(readText == "읽음") {
					$("tbody tr:last-child .badge")
		            .removeClass("badge-pink-transparent")
		            .addClass("badge-info-transparent");
				}
				
			});
			
			// 참조문서 제목 클릭 이벤트
			$("tbody").on("click",".documentTitle", function(e){
				e.preventDefault(); // 기본 링크 동작 차단
				
				let ele = $(this)[0];
				let selectEle = $(ele);
				
				var clickedDocNo = selectEle.data("no");
				var targetUrl = selectEle.attr("href"); // 링크에 지정된 URL 가져오기
				
				console.log(targetUrl);
				
				let updateData = {
						userId: userId,
						docNo: clickedDocNo
				};
				
				var refRead = selectEle.data("refread");
				
				console.log("updateData: ", updateData);
				
				if(refRead == 'N') {
					
					// 참조자 읽음 여부 업데이트
					$.ajax({
						url: "/sanction/refReadUpdate",
						method: "post",
						data: updateData,
						dataType: 'json',
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
						success: function(res){
							console.log("읽음여부 res: ", res);
							if(res == 1) {
								console.log("읽음 여부가 업데이트 되었습니다.");
								window.location.href = targetUrl;
							} else {
								showToastMessage("읽음 여부 업데이트 중 오류가 발생했습니다.", "danger");
							}
							
						}
						
					});
					
				} else {
					window.location.href = targetUrl;
				}
				
			});
			
			
		},
		error: function(error){
			showToastMessage("참조문서 호출에 실패했습니다.", "danger");
		}
	});	// 페이지 로드 시 ajax
	
});	// ready function 종료 영역

</script>
</html>