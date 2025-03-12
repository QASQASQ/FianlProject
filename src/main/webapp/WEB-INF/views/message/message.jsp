<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
	<meta name="description" content="Smarthr - Bootstrap Admin Template">
	<meta name="keywords" content="admin, estimates, bootstrap, business, html5, responsive, Projects">
	<meta name="author" content="Dreams technologies - Bootstrap Admin Template">
	<meta name="robots" content="noindex, nofollow">
	<title>쪽지함</title>
	<style>
	/* 📌 기본적으로 Bootstrap의 모달보다 높은 z-index 설정 */
	#employeeSelectionModal {
			z-index: 1060 !important;
	}
	#compose-view {
			z-index: 1050 !important;
	}

	/* 📌 백드롭보다 모달이 위로 올라오도록 설정 */
	.modal-backdrop {
			z-index: 1049 !important;
	}

	.bootstrap-tagsinput input {
			display: none !important;
	}

	/* compose-modal는 애니메이션 없이 하단에 고정 */
	.modal.fade.compose-modal .modal-dialog {
		position: fixed !important;
    bottom: 0 !important;
    left: 50% !important;
    right: auto !important;
    transform: translateX(-50%) translateY(100%);
    opacity: 0;
    transition: transform 0.3s ease-out, opacity 0.3s ease-out;
    width: 90%;          /* 모달 너비 설정 */
    max-width: 600px;    /* 최대 너비 제한 */
    min-height: 200px;   /* 최소 높이 설정 */
    min-width: 300px;    /* 최소 너비 설정 */
	}
	
	.modal.show.compose-modal .modal-dialog {
    transform: translateX(-50%) translateY(0);
    opacity: 1;
	}
	
	.modal-body p {
		word-wrap: break-word;
		white-space: pre-wrap; /* ✅ 개행과 공백 유지 */
	}

	</style>
</head>

<body>

	<div id="global-loader">
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

		<!-- Horizontal Menu -->
		<%@ include file="/WEB-INF/views/theme/horizontalMenu.jsp" %>
		<!-- /Horizontal Menu -->

		<!-- Two Col Sidebar -->
		<%@ include file="/WEB-INF/views/theme/twoColSidebar.jsp" %>
		<!-- /Two Col Sidebar -->

		<!-- Stacked Sidebar -->
		<%@ include file="/WEB-INF/views/theme/stackedSidebar.jsp" %>
		<!-- /Stacked Sidebar -->

		<!-- Page Wrapper -->
		<div class="page-wrapper">
			<div class="content p-0">
				<div class="d-md-flex">
					<div class="email-sidebar border-end border-bottom">
						<div class="active slimscroll h-100">
							<div class="slimscroll-active-sidebar">					
								<div class="p-3">
									<div class="shadow-md bg-white rounded p-2 mb-4">
										<div class="d-flex align-items-center">
											<a href="javascript:void(0);" class="avatar avatar-md flex-shrink-0 me-2">
												<img src="${pageContext.request.contextPath }/assets/img/profile_images/${emp.profileImgpath}" class="rounded-circle" alt="Img">
											</a>
											<div>
												<h6 class="mb-1"><a href="javascript:void(0);">${emp.emplNm}</a></h6>
												<p>${userId}</p>
											</div>
										</div>
									</div>
									<a href="javascript:void(0);" class="btn btn-primary w-100" id="compose_mail"><i class="ti ti-edit me-2"></i>작성하기</a>
									<div class="mt-4">
										<h5 class="mb-2">쪽지함</h5>
										<div class="d-block mb-4 pb-4 border-bottom email-tags">
											<a class="d-flex align-items-center justify-content-between p-2 rounded active">
												<span class="d-flex align-items-center fw-medium">
													<i class="ti ti-inbox text-gray me-2"></i>받은쪽지함
												</span>
											</a>
											
											<a href="javascript:void(0);" class="d-flex align-items-center justify-content-between p-2 rounded">
												<span class="d-flex align-items-center fw-medium">
													<i class="ti ti-rocket text-gray me-2"></i>보낸쪽지함
												</span>
											</a>
											
											<a href="javascript:void(0);" class="d-flex align-items-center justify-content-between p-2 rounded">
												<span class="d-flex align-items-center fw-medium">
													<i class="ti ti-trash text-gray me-2"></i>휴지통
												</span>
											</a>
											
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="bg-white flex-fill border-end border-bottom mail-notifications">
						<div class="active slimscroll h-100">
							<div class="slimscroll-active-sidebar">	
								<div class="p-3">
									<div class="d-flex align-items-center justify-content-between flex-wrap row-gap-3">
										<div class="email">	
											<h5 class="mb-1">
												받은 쪽지함
											</h5>								
											<div class="d-flex align-items-center">
												<span>총 <span class="total-messages" id="total-messages">0</span> 개</span>
												<i class="ti ti-point-filled text-primary mx-1"></i>
												<span class="unread-messages">안읽은 쪽지 <span>0</span></span>
											</div>
										</div>

										<div class="d-flex align-items-center">
											<!-- 내용별 검색 컨테이너 -->
											<div class="position-relative input-icon me-3" id="contentSearchContainer">
												<span class="input-icon-addon">
													<i class="ti ti-search"></i>
												</span>
												<input type="text" class="form-control" id="searchInput" placeholder="검색하세요.">
											</div>
											
											<!-- 날짜별 검색 컨테이너 (datepicker) -->
											<div class="position-relative input-icon me-3" id="datePickerContainer" style="display:none;">
												<input type="text" class="form-control" id="datePickerInput" placeholder="날짜를 선택하세요.">
											</div>
											
											<!-- 연도별 검색 컨테이너 (select) -->
											<div class="position-relative input-icon me-3" id="yearSelectContainer" style="display:none;">
												<select class="form-select" id="yearSelect"></select>
											</div>
											
											<!-- 월별 검색 컨테이너 (select) -->
											<div class="position-relative input-icon me-3" id="monthSelectContainer" style="display:none;">
												<select class="form-select" id="monthSelect"></select>
											</div>
											
											<!-- 필터 선택 드롭다운 -->
											<div class="dropdown">
												<button class="btn btn-icon btn-sm rounded-circle" id="filterButton" data-bs-toggle="dropdown">
													<i class="ti ti-filter-edit"></i>
												</button>
												<div class="dropdown-menu p-2">
													<a class="dropdown-item filter-option active" data-filter="content" href="#">내용별</a>
													<a class="dropdown-item filter-option" data-filter="date" href="#">날짜별</a>
													<a class="dropdown-item filter-option" data-filter="year" href="#">연도별</a>
													<a class="dropdown-item filter-option" data-filter="month" href="#">월별</a>
												</div>
											</div>
											
											<!-- 새로고침 버튼 -->
											<button class="btn btn-icon btn-sm rounded-circle" id="resetButton">
												<i class="ti ti-refresh"></i>
											</button>
										</div>
										
										
										</div>
									</div>
								</div>
									<div class="list-group list-group-flush emails-list">
										<!-- 📩 받은쪽지, 보낸쪽지, 휴지통 불러오기 -->
									</div>

											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="footer d-sm-flex align-items-center justify-content-between bg-white p-3">
					<p>Developed By <a href="javascript:void(0);" class="text-primary">HERMES</a></p>
				</div>
			</div>
		</div>
		<!-- /Page Wrapper -->

		<!-- 쪽지 작성하기 모달 -->
		<div id="compose-view" class="modal fade compose-modal" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog modal-dialog-bottom">
					<div class="modal-content bg-white border-0 rounded compose-view">
							<div class="compose-header d-flex align-items-center justify-content-between bg-dark p-3">
									<h5 class="text-white">새로운 쪽지 작성하기</h5>
									<div class="d-flex align-items-center">
											<button type="button" class="btn-close custom-btn-close bg-transparent fs-16 text-white position-static" id="compose-close" data-bs-dismiss="modal">
													<i class="ti ti-x"></i>
											</button>
									</div>
							</div>
							<form action="/messageHome">
									<div class="p-3 position-relative pb-2 border-bottom">
											<div class="tag-with-img d-flex align-items-center">
													<label class="form-label me-2">To</label>
													<input class="input-tags form-control border-0 h-100" id="inputBox" type="text" data-role="tagsinput" name="Label" readonly>
													<input type="hidden" id="receiverInput" name="receiverIds">
											</div>
											<div class="d-flex align-items-center email-cc">
													<a href="javascript:void(0);" class="d-inline-flex me-2" id="openEmployeeSearch">추가</a>
											</div>
									</div>  
									<div class="p-3 border-bottom">
											<div class="mb-0">
													<textarea rows="7" class="form-control" id="messageContent" placeholder="내용을 입력하세요."></textarea>
											</div>
									</div>
									<div class="p-3 d-flex align-items-center justify-content-between">
											<div class="d-flex align-items-center compose-footer">
													<button type="button" class="btn btn-primary d-inline-flex align-items-center ms-2" id="sendMessageBtn">
															보내기 <i class="ti ti-arrow-right ms-2"></i>
													</button>
											</div>
									</div>
							</form>
					</div>
			</div>
	</div>
	
		<!-- /쪽지 작성하기 모달 -->


		<!-- 사원 선택 모달 -->
		<div class="modal fade" id="employeeSelectionModal" tabindex="-1" aria-labelledby="employeeSelectionModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="employeeSelectionModalLabel">수신자 선택</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<input type="text" class="form-control mb-3" id="searchEmployeeInput" placeholder="사원의 이름 또는 번호 입력">
						<div class="table-responsive">
							<table class="table table-bordered table-hover">
								<thead class="table-dark">
									<tr>
										<th>
											<input type="checkbox" id="selectAllEmployees">
										</th>
										<th>부서명</th>
										<th>사원명</th>
										<th>직책</th>
										<th>사원번호</th>
									</tr>
								</thead>
								<tbody id="employeeSelectionList">
									<!-- 검색 결과가 여기에 추가됨 -->
								</tbody>
							</table>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-light me-2" data-bs-dismiss="modal">취소</button>
						<!-- 여러 명 선택 후 추가 버튼 -->
						<button type="button" class="btn btn-primary" id="addSelectedEmployees">추가</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 사원 선택 모달 -->

		<!-- 📩 쪽지 상세보기 모달 -->
		<div id="messageDetailModal" class="modal fade" tabindex="-1" aria-labelledby="messageDetailModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="messageDetailModalLabel">쪽지 상세보기</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<p id="messageSender"></p>
						<p id="messageDate"></p>
						<p id="messageContent"></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-light me-2" data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 쪽지 상세보기 모달 -->

		<!-- 삭제 확인 모달 -->
		<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="deleteConfirmLabel">쪽지 삭제</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						쪽지를 정말 삭제하시겠습니까?
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-danger" id="confirmDeleteBtn">삭제</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 삭제 확인 모달 -->

		<!-- Toast 알림 메시지 -->
		<div class="position-fixed top-0 start-50 translate-middle-x p-3" style="z-index: 1100">
			<div id="toastMessage" class="toast hide align-items-center text-white bg-primary border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
					<div class="d-flex">
							<div class="toast-body" id="toastBody">
									<!-- 메시지가 여기에 표시됨 -->
							</div>
							<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
					</div>
			</div>
		</div>
		<!-- Toast 알림 메시지 -->

	</div>
	<!-- /Main Wrapper -->

	<!-- jQuery -->
	<script src="${pageContext.request.contextPath }/assets/js/jquery-3.7.1.min.js"></script>

	<!-- Bootstrap Core JS -->
	<script src="${pageContext.request.contextPath }/assets/js/bootstrap.bundle.min.js"></script>

	<!-- Bootstrap Datepicker CSS/JS  -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

	<!-- Feather Icon JS -->
	<script src="${pageContext.request.contextPath }/assets/js/feather.min.js"></script>

	<!-- Slimscroll JS -->
	<script src="${pageContext.request.contextPath }/assets/js/jquery.slimscroll.min.js"></script>

	<!-- Bootstrap Tagsinput JS -->
	<script src="${pageContext.request.contextPath }/assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.js"></script>

	<!-- Owl Carousel JS -->
	<script src="${pageContext.request.contextPath }/assets/js/owl.carousel.min.js"></script>

	<!-- Color Picker JS -->
	<script src="${pageContext.request.contextPath }/assets/plugins/@simonwep/pickr/pickr.es5.min.js"></script>

	<!-- Custom JS -->
	<script src="${pageContext.request.contextPath }/assets/js/email.js"></script>
	<script src="${pageContext.request.contextPath }/assets/js/theme-colorpicker.js"></script>
	<script src="${pageContext.request.contextPath }/assets/js/script.js"></script>
	<script type="module" src="${pageContext.request.contextPath }/assets/js/message.js"></script>
</body>
</html>