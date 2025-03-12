<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>나의 급여</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/style.css">
</head>
<body>
    <div class="main-wrapper">
        <%@ include file="/WEB-INF/views/theme/header.jsp" %>
        <%@ include file="/WEB-INF/views/theme/sidebar.jsp" %>

        <div class="page-wrapper">
            <div class="content">
                <h2 class="mb-3">나의 급여 내역</h2>
                <div class="card">
									<div class="card-header d-flex justify-content-between">
										<h5>급여 목록</h5>
										<div>
												<select id="yearSelect" class="form-select d-inline" style="width: 100px;">
														<option value="">년</option>
												</select>
												<select id="monthSelect" class="form-select d-inline" style="width: 80px;">
														<option value="">월</option>
												</select>
												<select id="daySelect" class="form-select d-inline" style="width: 80px;">
														<option value="">일</option>
												</select>
												<button class="btn btn-primary" id="searchBtn">검색</button>
												<!-- <button class="btn btn-secondary" id="resetBtn">초기화</button> -->
										</div>
									</div>								
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>지급 일자</th>
                                        <th>지급 내용</th>
                                        <th>총 지급액</th>
                                        <th>실 지급액</th>
                                        <th>보기</th>
                                    </tr>
                                </thead>
                                <tbody id="myPayTableBody">
                                    <!-- ✅ JavaScript에서 동적 로딩 -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <%@ include file="/WEB-INF/views/theme/modal.jsp" %>
        </div>
    </div>

    <!-- 📄 급여 명세서 모달 -->
	<div class="modal fade" id="payStubModal" tabindex="-1" aria-labelledby="payStubModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
				<div class="modal-content">
						<div class="modal-header text-white">
								<h5 class="modal-title" id="payStubModalLabel">급여 지급 명세서</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>

						<div class="modal-body">
								<!-- 📌 사원 정보 테이블 -->
								<table class="table pay-stub-emp-info">
									<thead>
											<tr>
													<th colspan="4">사원 정보</th>
											</tr>
									</thead>
									<tbody>
											<tr>
													<td>부서</td>
													<td id="modalDeptName">-</td>
													<td>지급 일자</td>
													<td id="modalPayDate">-</td>
											</tr>
											<tr>
													<td>성명</td>
													<td id="modalEmpName">-</td>
													<td>직급</td>
													<td id="modalPosition">-</td>
											</tr>
									</tbody>
								</table>

								<!-- 지급 및 공제 내역 -->
								<h5 class="mt-4 mb-3">지급 및 공제 내역</h5>
								<table class="table pay-stub-details table-hover text-center">
										<thead>
												<tr>
														<th>지급 항목</th>
														<th>금액 (₩)</th>
														<th>공제 항목</th>
														<th>금액 (₩)</th>
												</tr>
										</thead>
										<tbody>
												<tr>
														<td>기본급</td>
														<td id="modalBasicSalary">-</td>
														<td>소득세</td>
														<td id="modalIncomeTax">-</td>
												</tr>
												<tr>
														<td>시간 외 수당</td>
														<td id="modalOvertimePay">-</td>
														<td>지방세</td>
														<td id="modalLocalTax">-</td>
												</tr>
												<tr>
														<td>식대</td>
														<td id="modalMealPay">-</td>
														<td>고용보험</td>
														<td id="modalEmploymentInsurance">-</td>
												</tr>
												<tr>
														<td>상여금</td>
														<td id="modalBonus">-</td>
														<td>건강보험</td>
														<td id="modalHealthInsurance">-</td>
												</tr>
												<tr>
														<td></td>
														<td></td>
														<td>장기요양보험</td>
														<td id="modalNursingInsurance">-</td>
												</tr>
												<tr>
														<td></td>
														<td></td>
														<td>국민연금</td>
														<td id="modalNationalPension">-</td>
												</tr>
										</tbody>
										<tfoot>
												<tr>
														<th>총 지급액</th>
														<td id="modalTotalPayment">-</td>
														<th>실 지급액</th>
														<td id="modalActualSalary">-</td>
												</tr>
										</tfoot>
								</table>
						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">닫기</button>
							<button id="downloadPdf" class="btn btn-primary">다운로드</button>
						</div>
				</div>
		</div>
	</div>
	<!-- 📄 급여 명세서 모달 -->

    <!-- jQuery -->
	<script src="${pageContext.request.contextPath }/assets/js/jquery-3.7.1.min.js"></script>

	<!-- jsPDF 라이브러리 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>

	<!-- jsPDF AutoTable 플러그인 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.23/jspdf.plugin.autotable.min.js"></script>

	<!-- Bootstrap Core JS -->
	<script src="${pageContext.request.contextPath }/assets/js/bootstrap.bundle.min.js"></script>
	
	<!-- Feather Icon JS -->
	<script src="${pageContext.request.contextPath }/assets/js/feather.min.js"></script>
	
	<!-- Slimscroll JS -->
	<script src="${pageContext.request.contextPath }/assets/js/jquery.slimscroll.min.js"></script>
	
	<!-- Color Picker JS -->
	<script src="${pageContext.request.contextPath }/assets/plugins/@simonwep/pickr/pickr.es5.min.js"></script>
	
	<!-- Datatable JS -->
	<%-- <script src="${pageContext.request.contextPath }/assets/js/jquery.dataTables.min.js"></script> --%>
	<%-- <script src="${pageContext.request.contextPath }/assets/js/dataTables.bootstrap5.min.js"></script> --%>
	
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
	<script src="${pageContext.request.contextPath }/js/font/font.js"></script>
	<script src="${pageContext.request.contextPath }/js/img/img.js"></script>
    <script type="module" src="${pageContext.request.contextPath }/assets/js/myPayStub.js"></script>
</body>
</html>
