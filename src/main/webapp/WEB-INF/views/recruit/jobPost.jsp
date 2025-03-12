<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<style>
		.modal .modal-footer .btn {
			margin: 5px !important;
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
				<!-- Breadcrumb -->
				<div class="d-md-flex d-block align-items-center justify-content-between page-breadcrumb mb-3">
					<div class="my-auto mb-2">
						<h2 class="mb-1">채용 관리</h2>
					</div>
					<div class="d-flex my-xl-auto right-content align-items-center flex-wrap">
						<div class="mb-2">
							<button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#createRecruitModal">
								<i class="ti ti-circle-plus me-2"></i>신규
							</button>
						</div>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<!-- 채용공고 목록 카드 (탭 분리) -->
				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>채용공고 목록</h5>
						<div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
							<div class="card-tools">
								<form class="input-group input-group-sm" method="post" id="searchForm" style="width: 250px;">
									<input type="hidden" name="page" id="page"/>
									<input type="text" name="searchWord" class="form-control me-3" value="${searchWord }" placeholder="제목, 부서, 직급">
									<div class="input-group-append">
										<button type="submit" class="btn btn-primary d-flex align-items-center">검색</button>
									</div>
								</form>
							</div>
						</div>
					</div>
					<div class="card-body p-0">
						<!-- 탭 네비게이션 -->
						<ul class="nav nav-tabs" id="jobPostTabs" role="tablist">
						  <li class="nav-item" role="presentation">
						    <button class="nav-link active" id="ongoing-tab" data-bs-toggle="tab" data-bs-target="#ongoing" type="button" role="tab" aria-controls="ongoing" aria-selected="true">진행중 공고</button>
						  </li>
						  <li class="nav-item" role="presentation">
						    <button class="nav-link" id="completed-tab" data-bs-toggle="tab" data-bs-target="#completed" type="button" role="tab" aria-controls="completed" aria-selected="false">종료/완료 공고</button>
						  </li>
						</ul>
						<!-- 탭 콘텐츠 -->
						<div class="tab-content" id="jobPostTabsContent">
							<!-- 진행중 공고 탭 -->
						  <div class="tab-pane fade show active" id="ongoing" role="tabpanel" aria-labelledby="ongoing-tab">
						    <div class="custom-datatable-filter table-responsive">
						      <table class="table datatable text-center">
						        <thead class="thead-light">
						          <tr>
						            <th>제목</th>
						            <th>모집기간</th>
						            <th>부서</th>
						            <th>직급</th>
						            <th>상태</th>
						            <th></th>
						          </tr>
						        </thead>
						        <tbody id="ongoingTableBody">
						          <!-- 진행중 데이터 -->
						        </tbody>
						      </table>
						      <div style="display: flex; justify-content: center; align-items: center; padding:15px;" id="ongoingPagingArea"></div>
						    </div>
						  </div>
						  <!-- 종료/완료 공고 탭 -->
						  <div class="tab-pane fade" id="completed" role="tabpanel" aria-labelledby="completed-tab">
						    <div class="custom-datatable-filter table-responsive">
						      <table class="table datatable text-center">
						        <thead class="thead-light">
						          <tr>
						            <th>제목</th>
						            <th>모집기간</th>
						            <th>부서</th>
						            <th>직급</th>
						            <th>상태</th>
						            <th></th>
						          </tr>
						        </thead>
						        <tbody id="completedTableBody">
						          <!-- 종료/완료 데이터 -->
						        </tbody>
						      </table>
						      <div style="display: flex; justify-content: center; align-items: center; padding:15px;" id="completedPagingArea"></div>
						    </div>
						  </div>
						</div>
					</div>
				</div>
				<!-- /채용공고 목록 카드 -->
			</div>
		</div>
		<!-- /Page Wrapper -->

		<!-- "채용공고 작성" 버튼: 클릭 시 모달 오픈 (하단 별도 버튼도 있음) -->
		<button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#createRecruitModal">
			채용공고 작성
		</button>

		<!-- 채용공고 작성 모달 -->
		<div class="modal fade" id="createRecruitModal" tabindex="-1" aria-labelledby="createRecruitModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="createRecruitModalLabel">채용공고 작성</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<!-- 채용공고 작성 폼 -->
					<form id="jobPostForm">
						<div class="modal-body">
							<!-- 채용공고제목 -->
							<div class="mb-3">
								<label for="recTitle" class="form-label">채용공고제목</label>
								<input type="text" class="form-control" id="recTitle" name="recTitle" placeholder="예: 2025년도 하반기 HRMES 경영 부서 신입사원 채용 공고" required>
							</div>
							<!-- 모집 부서 & 직급 -->
							<div class="row">
								<div class="col-md-6 mb-3">
									<label for="deptCode" class="form-label">모집 부서</label>
									<select class="form-select" id="deptCode" name="deptCode" required>
										<option value="" disabled selected>부서를 선택하세요</option>
										<option value="01">경영 및 인사</option>
										<option value="02">마케팅</option>
										<option value="03">연구 및 개발</option>
										<option value="04">운영</option>
										<option value="05">재무 및 회계</option>
									</select>
								</div>
								<div class="col-md-6 mb-3">
									<label for="recPosition" class="form-label">모집 직급</label>
									<select class="form-select" id="recPosition" name="recPosition" required>
										<option value="" disabled selected>직급을 선택하세요</option>
										<option value="01">사원</option>
										<option value="02">대리</option>
										<option value="03">과장</option>
										<option value="04">차장</option>
										<option value="05">부장</option>
									</select>
								</div>
							</div>
							<!-- 모집기간 -->
							<div class="mb-3">
								<label class="form-label">모집기간</label>
								<div class="row g-2">
									<div class="col">
										<input type="date" class="form-control" id="recSdate" name="recSdate" required>
									</div>
									<div class="col-auto d-flex align-items-center">~</div>
									<div class="col">
										<input type="date" class="form-control" id="recEdate" name="recEdate" required>
									</div>
								</div>
							</div>
							<!-- 업무내용, 요구사항 등 -->
							<div class="mb-3">
								<label for="recContent" class="form-label">업무내용</label>
								<textarea class="form-control" id="recContent" name="recContent" rows="2" placeholder="업무 내용을 입력하세요"></textarea>
							</div>
							<div class="mb-3">
								<label for="recReq" class="form-label">요구기술</label>
								<textarea class="form-control" id="recReq" name="recReq" rows="2" placeholder="예: Java, Spring, MySQL"></textarea>
							</div>
							<div class="mb-3">
								<label for="recIdeal" class="form-label">요구인재상</label>
								<textarea class="form-control" id="recIdeal" name="recIdeal" rows="2" placeholder="예: 책임감 있고 커뮤니케이션이 원활한 인재"></textarea>
							</div>
							<div class="mb-3">
								<label for="recExp" class="form-label">요구경험</label>
								<textarea class="form-control" id="recExp" name="recExp" rows="2" placeholder="예: react 반응형 웹 개발 경험자"></textarea>
							</div>
							<div class="mb-3">
								<label for="recEssential" class="form-label">필수사항</label>
								<textarea class="form-control" id="recEssential" name="recEssential" rows="2" placeholder="예: 해외 출장 결격 사유 없는 자"></textarea>
							</div>
							<div class="mb-3">
								<label for="recTreatment" class="form-label">우대사항</label>
								<textarea class="form-control" id="recTreatment" name="recTreatment" placeholder="예: 정보처리기사 자격증 보유"></textarea>
							</div>
							<div class="mb-3">
								<label for="recTarget" class="form-label">모집인원</label>
								<input type="text" class="form-control" id="recTarget" name="recTarget" placeholder="예: 3명, 00명">
							</div>
							<!-- 기술항목 영역 -->
							<div class="mb-3">
								<label class="form-label">기술항목</label>
								<div id="sortList"></div>
								<button type="button" class="btn btn-secondary mt-2" id="addSortBtn">기술항목 추가</button>
							</div>
						</div>
						<!-- /modal-body -->
						<div class="modal-footer">
							<button type="button" id="exampleBtn" class="btn btn-success">예시</button>
							<button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">등록</button>
						</div>
					</form>
					<!-- /채용공고 작성 폼 -->
				</div>
			</div>
		</div>
		<!-- /채용공고 작성 모달 -->
	</div>
	<!-- /Main Wrapper -->

	<!-- 모달창들 -->
	<%@ include file="/WEB-INF/views/theme/modal.jsp" %>
	<!-- /모달창들 -->

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
	<script type="module" src="${pageContext.request.contextPath }/assets/js/jobPost.js"></script>
	<script>
		$(document).ready(function () {
			$("#exampleBtn").click(function () {
					$("#recTitle").val("2025년도 하반기 HRMES 연구 및 개발 부서 기획 및 정책연구를 위한 데이터 분석가 채용 공고");
					$("#deptCode").val("03"); // 연구 및 개발
					$("#recPosition").val("02"); // 대리
					$("#recSdate").val("2025-06-01");
					$("#recEdate").val("2025-06-30");
					$("#recContent").val("데이터 분석 및 정책 연구, AI 기반 모델 개발, 연구 결과 보고서 작성");
					$("#recReq").val("Python, R, SQL, 데이터 시각화, 통계 분석");
					$("#recIdeal").val("논리적 사고가 뛰어나고 협업 능력이 우수한 인재");
					$("#recExp").val("빅데이터 처리 및 머신러닝 모델 구축 경험");
					$("#recEssential").val("석사 이상 학위 또는 데이터 분석 관련 실무 경험 2년 이상");
					$("#recTreatment").val("TensorFlow 또는 PyTorch 활용 가능자 우대");
					$("#recTarget").val("1명");
			});
	});	
	</script>
</body>
</html>
