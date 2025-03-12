<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
	<meta name="description" content="Smarthr - Bootstrap Admin Template">
	<meta name="keywords" content="admin, estimates, bootstrap, business, html5, responsive, Projects">
	<meta name="author" content="Dreams technologies - Bootstrap Admin Template">
	<meta name="robots" content="noindex, nofollow">
	<title>채용</title>
	
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

				<!-- Breadcrumb -->
				<div class="d-md-flex d-block align-items-center justify-content-between page-breadcrumb mb-3">
					<div class="my-auto mb-2">
						<h2 class="mb-1">채용 관리</h2><br/>
						<a href="/hrms/job" class="back-icon d-flex align-items-center fs-15 fw-medium mb-3 d-inline-flex">
							<span class=" d-flex justify-content-center align-items-center rounded-circle me-2">
								<i class="ti ti-arrow-left"></i>
							</span>
							목록으로 돌아가기
						</a>
					</div>
					<div class="d-flex my-xl-auto right-content align-items-center flex-wrap">
						<div class="mb-2">
							<a href="#" class="btn btn-primary d-flex align-items-center" id="downloadExcel"><i class="ti ti-circle-plus me-2"></i>다운로드</a>
						</div>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>입사 지원자 목록</h5>
						<div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
							<div class="card-tools">
								<form class="input-group input-group-sm" method="get" id="searchForm" style="width: 250px;">
									<input type="hidden" name="page" id="page"/>
									<input type="text" name="searchWord" class="form-control me-3" value="${searchWord }" placeholder="지원자 이름 / 채용 여부">
									<div class="input-group-append">
										<button type="submit" class="btn btn-primary d-flex align-items-center">검색</button>
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
										<th></th>
										<th>지원자 성명</th>
										<th>생년 월일</th>
										<th>연락처</th>
										<th>이메일</th>
										<th>채용 여부</th>
										<th>입사 지원서</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="applierTableBody">
								</tbody>
							</table>
							<div style="display: flex; justify-content: center; align-items: center; padding:15px;" id="pagingArea">${paging.pagingHTML}</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /Page Wrapper -->

		<!-- 채용 입력 모달 -->
		<div class="modal fade" id="hireModal" tabindex="-1" aria-labelledby="hireModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="hireModalLabel">입사자 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="hireForm">
							<div class="mb-3">
								<label for="EMPL_NO" class="form-label">사원번호</label>
								<input type="text" class="form-control" id="EMPL_NO" required>
							</div>
							<div class="mb-3">
								<label for="password" class="form-label">비밀번호</label>
								<input type="password" class="form-control" id="EMPL_PWD" required>
							</div>
							<div class="mb-3">
								<label for="POSITION" class="form-label">직위</label>
								<select class="form-select" id="POSITION" required>
										<option value="" disabled selected>직위를 선택하세요</option>
										<option value="01">사원</option>
										<option value="02">대리</option>
										<option value="03">과장</option>
										<option value="04">차장</option>
										<option value="05">부장</option>
								</select>
						</div>
							<div class="mb-3">
									<label for="DEPARTMENT" class="form-label">부서</label>
									<select class="form-select" id="DEPARTMENT" required>
											<option value="" disabled selected>부서를 선택하세요</option>
											<option value="01">경영 및 인사</option>
											<option value="02">마케팅</option>
											<option value="03">연구 및 개발</option>
											<option value="04">운영</option>
											<option value="05">재무 및 회계</option>
									</select>
							</div>
							<div class="mb-3">
								<label for="HIRE_DATE" class="form-label">입사일자</label>
								<input type="date" class="form-control" id="HIRE_DATE" required>
							</div>
							<div class="mb-3">
								<label class="form-label">권한부여</label>
								<div class="form-check">
									<input class="form-check-input role-checkbox" type="checkbox" value="ROLE_GENERAL" id="ROLE_GENERAL">
									<label class="form-check-label" for="ROLE_GENERAL">일반 사원</label>
								</div>
								<div class="form-check">
									<input class="form-check-input role-checkbox" type="checkbox" value="ROLE_MANAGER" id="ROLE_MANAGER">
									<label class="form-check-label" for="ROLE_MANAGER">팀장</label>
								</div>
								<div class="form-check">
									<input class="form-check-input role-checkbox" type="checkbox" value="ROLE_ADMIN" id="ROLE_ADMIN">
									<label class="form-check-label" for="ROLE_ADMIN">관리자</label>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
								<button type="submit" class="btn btn-primary" id="hireSubmit">등록</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>		
		<!-- 채용 입력 모달 -->

	</div>
	<!-- /Main Wrapper -->

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


	<!-- 입사지원서 모달 -->
	<div class="modal fade" id="documentModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-lg"><!-- 필요시 modal-sm, modal-xl 등 변경 -->
				<div class="modal-content">
						<div class="modal-header">
								<h5 class="modal-title">입사지원서 내용</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
								<!-- 지원서 내용 표시 -->
								<pre id="appDocumentContent" style="white-space: pre-wrap;"></pre>

								<!-- 💬 코멘트 입력란 추가 -->
								<div class="mb-3">
										<label class="form-label">코멘트</label>
										<textarea class="form-control" id="evaluationComment" rows="3" placeholder="코멘트를 입력하세요."></textarea>
								</div>

								<!-- 🏅 평가 체크박스 추가 -->
								<div class="mb-3">
										<label class="form-label">평가</label>
										<div class="d-flex gap-3">
												<div class="form-check">
														<input class="form-check-input" type="radio" name="evaluation" id="excellent" value="우수">
														<label class="form-check-label" for="excellent">우수</label>
												</div>
												<div class="form-check">
														<input class="form-check-input" type="radio" name="evaluation" id="average" value="보통">
														<label class="form-check-label" for="average">보통</label>
												</div>
												<div class="form-check">
														<input class="form-check-input" type="radio" name="evaluation" id="poor" value="미흡">
														<label class="form-check-label" for="poor">미흡</label>
												</div>
										</div>
								</div>
						</div>

						<!-- ⚡ 모달 하단 버튼 (평가 완료 / 닫기) -->
						<div class="modal-footer">
								<button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">닫기</button>
								<button type="button" class="btn btn-primary" id="completeEvaluation" disabled>평가 완료</button>
						</div>
				</div>
		</div>
	</div>
	<!-- 입사지원서 모달 -->


	<!-- jQuery -->
	<script src="${pageContext.request.contextPath }/assets/js/jquery-3.7.1.min.js"></script>
	
	<!-- Bootstrap Core JS -->
	<script src="${pageContext.request.contextPath }/assets/js/bootstrap.bundle.min.js"></script>
	
	<!-- 엑셀 xlsx cdn -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

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
	<script type="module" src="${pageContext.request.contextPath }/assets/js/recruit.js"></script>

</body>
</html>