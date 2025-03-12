<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib uri="jakarta.tags.core" prefix="c"  %>
<%@ page import="kr.or.ddit.education.vo.BookVO"%>
<%@ page import="kr.or.ddit.education.vo.CurriculumVO"%>
<%@ page import="kr.or.ddit.education.vo.EducationVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <meta name="description" content="Smarthr - Bootstrap Admin Template">
    <meta name="keywords" content="admin, estimates, bootstrap, business, html5, responsive, Projects">
    <meta name="author" content="Dreams technologies - Bootstrap Admin Template">
    <meta name="robots" content="noindex, nofollow">
    <title>전체교육유저자세히보기</title>
</head>
<body>

    <div class="main-wrapper">
        <%@ include file="/WEB-INF/views/theme/header.jsp" %>
        <%@ include file="/WEB-INF/views/theme/sidebar.jsp" %>
        <%@ include file="/WEB-INF/views/theme/modal.jsp" %>
        
        <div class="page-wrapper">
            <div class="content">

                <div class="row align-items-center mb-4">
                    <div class="d-md-flex d-sm-block justify-content-between align-items-center flex-wrap">
                        <h6 class="fw-medium d-inline-flex align-items-center mb-3 mb-sm-0">
                            <a href="/hrms/education/user/userAllTrainingListSearch" class="back-icon d-flex align-items-center fs-15 fw-medium mb-3 d-inline-flex">
								<span class=" d-flex justify-content-center align-items-center rounded-circle me-2">
									<i class="ti ti-arrow-left"></i>
								</span>
								목록으로 돌아가기
                        	</a>
                        </h6>
                    </div>
                </div>

                <div class="row">
                    <!-- 왼쪽 교육 상세 정보 -->
                    <div class="col-xxl-3 col-xl-4 theiaStickySidebar">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="mb-3">교육상세정보</h5>
                                <div class="list-group details-list-group mb-4">
                                    <div class="list-group-item">
                                        <span>교육명</span>
                                        <p class="text-gray-9">${education.edcTitle}</p>
                                    </div>
                                    <div class="list-group-item">
                                        <span>교육 분류</span>
                                        <p class="text-gray-9">${education.edcSort}</p>
                                    </div>
                                    <div class="list-group-item">
                                        <span>교육 방식</span>
                                        <p class="text-gray-9">${education.edcWay}</p>
                                    </div>
                                    <div class="list-group-item">
                                        <span>교육 담당자</span>
                                        <p class="text-gray-9">${education.educator}</p>
                                    </div>
                                    <div class="list-group-item">
                                        <span>교육 정원</span>
                                        <p class="text-gray-9">${education.edcPsncpa}명</p>
                                    </div>
                                    <div class="list-group-item">
                                        <span>교육 대상</span>
                                        <p class="text-gray-9">${education.edcTarget}</p>
                                    </div>
                                    <div class="list-group-item">
                                        <span>모집 기간</span>
                                        <p class="text-gray-9">${education.recruitSdateFormatted} ~ ${education.recruitEdateFormatted}</p>
                                    </div>
                                    <div class="list-group-item">
                                        <span>교육 기간</span>
                                        <p class="text-gray-9">${education.edcSdateFormatted} ~ ${education.edcEdateFormatted}</p>
                                    </div>
                                </div>
                                <h5 class="mb-3">교육 교재</h5>
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>책 제목</th>
                                        </tr>
                                    </thead>
                                    <tbody>
									    <c:choose>
									        <c:when test="${not empty bookList}">
									            <c:forEach var="book" items="${bookList}">
									                <tr>
									                    <td>${book.bookName}</td>
									                </tr>
									            </c:forEach>
									        </c:when>
									        <c:otherwise>
									            <tr>
									                <td colspan="1" class="text-center text-danger">해당 강의에는 교재가 없습니다.</td>
									            </tr>
									        </c:otherwise>
									    </c:choose>
									</tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-xxl-9 col-xl-8">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="mb-3">교육 설명</h5>
                                <p>${education.edcContent}</p>
                            </div>
                        </div>
                        <div class="custom-accordion-items">
						    <div class="accordion accordions-items-seperate" id="accordionExample">
						        <div class="accordion-item">
						            <div class="accordion-header" id="headingTwo">
						                <div class="accordion-button">
						                    <h5>커리큘럼 미리보기</h5>
						                    <div class="ms-auto">
						                        <a href="#" class="d-flex align-items-center collapsed collapse-arrow"
						                            data-bs-toggle="collapse" data-bs-target="#primaryBorderTwo"
						                            aria-expanded="false" aria-controls="primaryBorderTwo">
						                            <i class="ti ti-chevron-down fs-18"></i>
						                        </a>
						                    </div>
						                </div>
						            </div>
						            <div id="primaryBorderTwo" class="accordion-collapse collapse show border-top"
						                aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
						                <div class="accordion-body">
						                    <div class="list-group list-group-flush">
						                        <c:choose>
						                            <c:when test="${not empty curriculumList}">
						                                <c:forEach var="cur" items="${curriculumList}">
						                                    <div class="list-group-item border rounded mb-2 p-2">
						                                        <h4 class="fs-17">${cur.curName}</h4><br/>
						                                        <p> : ${cur.curExplain}</p>
						                                    </div>
						                                </c:forEach>
						                            </c:when>
						                            <c:otherwise>
						                                <div class="text-center text-muted p-3">
						                                    <h5>등록된 커리큘럼이 없습니다.</h5>
						                                </div>
						                            </c:otherwise>
						                        </c:choose>
						                    </div>
						                </div>
						            </div>
						        </div>
						    </div>
						</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

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

<!-- Datatable JS -->
<script src="${pageContext.request.contextPath }/assets/js/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/dataTables.bootstrap5.min.js"></script>	

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
