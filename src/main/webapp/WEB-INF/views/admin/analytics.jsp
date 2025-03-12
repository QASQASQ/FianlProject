<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
	<meta name="description" content="Smarthr - Bootstrap Admin Template">
	<meta name="keywords" content="admin, estimates, bootstrap, business, corporate, creative, management, minimal, modern,  html5, responsive">
	<meta name="author" content="Dreamstechnologies - Bootstrap Admin Template">
	<meta name="robots" content="noindex, nofollow">
	<title>Smarthr Admin Template</title>

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


		<!-- Page Wrapper -->
		<div class="page-wrapper cardhead">
			<div class="content ">

				<!-- Page Header -->
				<div class="page-header">
					<div class="row">
						<div class="col-sm-12">
							<h3 class="page-title">사내 애널리틱스</h3>
						</div>
					</div>
				</div>
				<!-- /Page Header -->
				<div class="row">
				
				
					<!-- Chart -->
					<div class="col-md-4">
						<div class="card">
							<div class="card-header">
								<h5 class="card-title">부서별 근속연수</h5>
							</div>
							<div class="card-body">
								<div id="s-col3" class="chart-set"></div>
							</div>
						</div>
					</div>
					<!-- /Chart -->
					
					<!-- Chart -->
					<div class="col-md-4">
						<div class="card w-100">
							<div class="card-header">
								<h5 class="card-title">연차</h5>
							</div>
							<div class="card-body">
								<div id="radial-chart" class="chart-set"></div>
							</div>
						</div>
					</div>
					<!-- /Chart -->
										
					<!-- Chart -->
					<div class="col-md-4">
						<div class="card">
							<div class="card-header">
								<h5 class="card-title">월별 지각횟수</h5>
							</div>
							<div class="card-body">
								<div id="s-line" class="chart-set"></div>
							</div>
						</div>
					</div>
					<!-- /Chart -->
					
					<!-- Chart -->
					<div class="col-md-4">
						<div class="card w-100">
							<div class="card-header">
								<h5 class="card-title">부서별 인원수</h5>
							</div>
							<div class="card-body">
								<div id="donut-chart" class="chart-set"></div>
							</div>
						</div>
					</div>
					<!-- /Chart -->

					<!-- Chart -->
					<div class="col-md-4">
						<div class="card">
							<div class="card-header">
								<h5 class="card-title">부서별 기본급 평균</h5>
							</div>
							<div class="card-body">
								<div id="s-col" class="chart-set"></div>
							</div>
						</div>
					</div>
					<!-- /Chart -->
					
					<!-- Chart -->
					<div class="col-md-4">
						<div class="card">
							<div class="card-header">
								<h5 class="card-title">채용공고수와 지원자수</h5>
							</div>
							<div class="card-body">
								<div id="s-col2" class="chart-set"></div>
							</div>
						</div>
					</div>
					<!-- /Chart -->

					
				</div>
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

<!-- Chart JS -->
<script src="${pageContext.request.contextPath }/assets/plugins/apexchart/apexcharts.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/plugins/apexchart/chart-data.js"></script>

<!-- Custom JS -->
<script src="${pageContext.request.contextPath }/assets/js/circle-progress.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/theme-colorpicker.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/script.js"></script>

</body>

</html>