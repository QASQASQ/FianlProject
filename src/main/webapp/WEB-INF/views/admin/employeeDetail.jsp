<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>
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

		<!-- Page Wrapper -->
		<div class="page-wrapper">
			<div class="content">

				<!-- Breadcrumb -->
				<div class="d-md-flex d-block align-items-center justify-content-between page-breadcrumb mb-3">
					<div class="my-auto mb-2">
						<h6 class="fw-medium d-inline-flex align-items-center mb-3 mb-sm-0"><a href="/hrms/admin/employeeList">
							<i class="ti ti-arrow-left me-2"></i>목록으로</a>
						</h6>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<div class="row">
					<div class="col-xl-4 theiaStickySidebar">
						<div class="card card-bg-1">
							<div class="card-body p-0">
								<span class="avatar avatar-xl border-white m-auto d-flex mb-2">
								</span>
								<div class="text-center px-3 pb-3 border-bottom">
									<div class="mb-3">
										<h5 class="d-flex align-items-center justify-content-center mb-1">${emplVO.emplNm }</h5>
									</div>
									<div>
										<div class="d-flex align-items-center justify-content-between mb-2">
											<span class="d-inline-flex align-items-center">
												<i class="ti ti-id me-2"></i>
												사원번호
											</span>
											<p class="text-dark">${emplVO.emplNo }</p>
										</div>
										<div class="d-flex align-items-center justify-content-between mb-2">
											<span class="d-inline-flex align-items-center">
												<i class="ti ti-id me-2"></i>
												생년월일
											</span>
											<p class="text-dark">${fn:substring(emplVO.emplBrthdy,0,11) }</p>
										</div>
										<div class="d-flex align-items-center justify-content-between mb-2">
											<span class="d-inline-flex align-items-center">
												<i class="ti ti-star me-2"></i>
												부서
											</span>
											<p class="text-dark">${emplVO.deptCode }</p>
										</div>
										<div class="d-flex align-items-center justify-content-between mb-2">
											<span class="d-inline-flex align-items-center">
												<i class="ti ti-star me-2"></i>
												팀
											</span>
											<p class="text-dark">${emplVO.teamCode }</p>
										</div>
										<div class="d-flex align-items-center justify-content-between mb-2">
											<span class="d-inline-flex align-items-center">
												<i class="ti ti-star me-2"></i>
												직급
											</span>
											<p class="text-dark">${emplVO.emplPosition }</p>
										</div>
										<div class="d-flex align-items-center justify-content-between mb-2">
											<span class="d-inline-flex align-items-center">
												<i class="ti ti-star me-2"></i>
												연락처
											</span>
											<p class="text-dark">${emplVO.emplTelno }</p>
										</div>
										<div class="d-flex align-items-center justify-content-between mb-2">
											<span class="d-inline-flex align-items-center">
												<i class="ti ti-star me-2"></i>
												이메일
											</span>
											<p class="text-dark">${emplVO.emplEmail }</p>
										</div>
										<div class="d-flex align-items-center justify-content-between mb-2">
											<span class="d-inline-flex align-items-center">
												<i class="ti ti-calendar-check me-2"></i>
												입사일자
											</span>
											<p class="text-dark">${fn:substring(emplVO.hireDate, 0, 11) }</p>
										</div>
										<div class="row gx-2 mt-3">
											<div class="col-12">
												<div>
													<a href="#" class="btn btn-dark w-100" data-bs-toggle="modal" data-bs-target="#edit_employee"><i class="ti ti-edit me-1"></i>인사기록카드</a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					
					
					<div class="col-xl-8">
					    <div class="row">
					    
							<div class="col-md-6">
							    <div class="card text-center" style="min-height: 150px;">
							        <div class="card-body d-flex flex-column justify-content-center" style="min-height: 150px;">
							            <div class="d-flex justify-content-between align-items-center px-3">
							                <h6 class="card-title fw-semibold mb-0">출퇴근 관리</h6>
							                <a href="/hrms/admin/adminAttendance?emplNo=${emplNo }" class="btn btn-primary">자세히보기</a>
							            </div>
							        </div>
							    </div>
							</div>
							<div class="col-md-6">
							    <div class="card text-center" style="min-height: 150px;">
							        <div class="card-body d-flex flex-column justify-content-center" style="min-height: 150px;">
							            <div class="d-flex justify-content-between align-items-center px-3">
							                <h6 class="card-title fw-semibold mb-0">휴가 관리</h6>
							                <a href="javascript:void(0);" class="btn btn-primary">자세히보기</a>
							            </div>
							        </div>
							    </div>
							</div>
							<div class="col-md-6">
							    <div class="card text-center" style="min-height: 150px;">
							        <div class="card-body d-flex flex-column justify-content-center" style="min-height: 150px;">
							            <div class="d-flex justify-content-between align-items-center px-3">
							                <h6 class="card-title fw-semibold mb-0">교육 관리</h6>
							                <a href="javascript:void(0);" class="btn btn-primary">자세히보기</a>
							            </div>
							        </div>
							    </div>
							</div>
							<div class="col-md-6">
							    <div class="card text-center" style="min-height: 150px;">
							        <div class="card-body d-flex flex-column justify-content-center" style="min-height: 150px;">
							            <div class="d-flex justify-content-between align-items-center px-3">
							                <h6 class="card-title fw-semibold mb-0">복리후생 관리</h6>
							                <a href="javascript:void(0);" class="btn btn-primary">자세히보기</a>
							            </div>
							        </div>
							    </div>
							</div>
							<div class="col-md-6">
							    <div class="card text-center" style="min-height: 150px;">
							        <div class="card-body d-flex flex-column justify-content-center" style="min-height: 150px;">
							            <div class="d-flex justify-content-between align-items-center px-3">
							                <h6 class="card-title fw-semibold mb-0">보상 관리</h6>
							                <a href="javascript:void(0);" class="btn btn-primary">자세히보기</a>
							            </div>
							        </div>
							    </div>
							</div>
							<div class="col-md-6">
							    <div class="card text-center" style="min-height: 150px;">
							        <div class="card-body d-flex flex-column justify-content-center" style="min-height: 150px;">
							            <div class="d-flex justify-content-between align-items-center px-3">
							                <h6 class="card-title fw-semibold mb-0">급여 관리</h6>
							                <a href="javascript:void(0);" class="btn btn-primary">자세히보기</a>
							            </div>
							        </div>
							    </div>
							</div>
					    </div>
					</div>

					
				</div>
			</div>
			<div class="footer d-sm-flex align-items-center justify-content-between border-top bg-white p-3">
				<p class="mb-0">2014 - 2025 &copy; SmartHR.</p>
				<p>Designed &amp; Developed By <a href="#" class="text-primary">Dreams</a></p>
			</div>
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

</html>