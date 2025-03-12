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
	<title>건의사항 게시판</title>
	
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
						<h2 class="mb-1">건의사항</h2>
					</div>
					<div class="d-flex my-xl-auto right-content align-items-center flex-wrap">
						<div class="mb-2">
							<a href="/hrms/board/boardForm" class="btn btn-primary d-flex align-items-center"><i class="ti ti-circle-plus me-2"></i>글쓰기</a>
						</div>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>건의사항 목록</h5>
						<div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
							<div class="card-tools"  style="margin-left: -50px;">
								<form class="input-group input-group-sm " method="post" id="searchForm"  style="width: 350px;">
									<input type="hidden" name="page" id="page"/>
									<div class="dropdown">
									<select class="dropdown-toggle btn me-3" style="height: 38px; width: 110px;"  name="searchType">
										<option value="title" <c:if test="${searchType eq 'title'}">selected</c:if>>제목</option>
										<option value="writer" <c:if test="${searchType eq 'writer'}">selected</c:if>>작성자</option>
									</select>
									</div>
									<input type="text" name="searchWord" class="form-control me-3" value="${searchWord }" placeholder="검색" style="height: 38px;">
									<div class="input-group-append">
										<button type="submit" class="btn btn-primary d-flex align-items-center justify-content-center" style="height: 38px; min-width: 80px; text-align: center;">검색</button>
									</div>
								</form>
							</div>
						</div>
					</div>
					<div class="card-body p-0">
						<div class="custom-datatable-filter table-responsive">
							<table class="table datatable text-center">
								<thead class="thead-light">
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>작성일</th>
										<th>조회수</th>
										<th></th>
									</tr>
								</thead>
									<tbody>
									<c:choose>
										<c:when test="${empty boardList }">
											<tr>
												<td>조회하신 게시글이 존재하지 않습니다.</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>		
										</c:when>
										<c:otherwise>
											<c:forEach items="${boardList }" var="board">
													<tr>
				                                        <td>${board.boardNo}</td>
				                                        <td>
				                                        	<a href="/hrms/board/boardDetail?boardNo=${board.boardNo}">${board.boardTitle }</a>
				                                        </td>
				                                        <c:choose>
				                                        	<c:when test="${board.boardAnon eq 'Y' }">
				                                        		<c:choose>
				                                        			<c:when test="${sessionScope.userId eq board.boardWriter}">
				                                        				<td>익명(본인)</td>
				                                        			</c:when>
				                                        			<c:otherwise>
				                                        				<td>익명</td>
				                                        			</c:otherwise>
				                                        		</c:choose>
				                                        	</c:when>
				                                        	<c:otherwise>
						                                        <td>${board.boardWriter}</td>
				                                        	</c:otherwise>
				                                        </c:choose>
														<td>${fn:substring(board.boardDate,0,16) }</td>										
														<td>${board.boardHit }</td>		
														<td></td>								
													</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
							<div style="display: flex; justify-content: center; align-items: center; padding:15px;" id="pagingArea">${paging.pagingHTML}</div>
						</div>
					</div>
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
	
	<!-- Custom JS -->
	<script src="${pageContext.request.contextPath }/assets/js/circle-progress.js"></script>
	<script src="${pageContext.request.contextPath }/assets/js/theme-colorpicker.js"></script>
	<script src="${pageContext.request.contextPath }/assets/js/script.js"></script>

</body>
<script type="text/javascript">
$(function(){
	let searchForm = $("#searchForm");
	let pagingArea = $("#pagingArea");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		let pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	
	});
	
});

</script>

</html>