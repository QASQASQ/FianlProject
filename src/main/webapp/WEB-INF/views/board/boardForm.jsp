<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core"  prefix="c"%>   
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
	<meta name="description" content="Smarthr - Bootstrap Admin Template">
	<meta name="keywords"content="admin, estimates, bootstrap, business, corporate, creative, management, minimal, modern,  html5, responsive">
	<meta name="author" content="Dreamstechnologies - Bootstrap Admin Template">
	<meta name="robots" content="noindex, nofollow">
	<c:set value="등록" var="name"/>
		<c:if test="${status eq 'u' }">
			<c:set value="수정" var="name"/>
		</c:if>
	
	<title>건의사항 ${name}</title>	
     <script src="${pageContext.request.contextPath }/ckeditor/ckeditor.js"></script>

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

		<!-- 모달창들 -->
		<%@ include file="/WEB-INF/views/theme/modal.jsp" %>
		<!-- /모달창들 -->

		<!-- Page Wrapper -->
		<div class="page-wrapper cardhead">
			<div class="content">

				<!-- Page Header -->
				<div class="page-header">
					<div class="row">
						<div class="col">
							<h3 class="page-title">건의사항${name}</h3>
						</div>
					</div>
				</div>
				<!-- /Page Header -->

				<div class="row">
					<div class="col-lg-12">
							<a href="/hrms/board/boardList" class="back-icon d-flex align-items-center fs-15 fw-medium mb-3 d-inline-flex">
								<span class=" d-flex justify-content-center align-items-center rounded-circle me-2">
									<i class="ti ti-arrow-left"></i>
								</span>
								목록으로 돌아가기
							</a>
						<div class="card">
							<div class="card-header">
								<h5 class="card-title">건의사항${name}</h5>
							</div>
							<form action="/hrms/board/boardInsert" method="post" enctype="multipart/form-data" id="boardForm">
								<div class="card-body">
									<input type="hidden" name="boardWriter" id="boardWriter"/>
									<input type="hidden" name="boardAnon" id="boardAnonHidden" value="N"/> 
									<c:if test="${status eq 'u'}">
										<input type="hidden" name="boardNo" value="${board.boardNo}"/>
									</c:if>
										<div class="mb-3 row">
											<label class="form-label col-md-2">제목</label>
											<div class="col-md-10">
												<input type="text" class="form-control" name="boardTitle" id="boardTitle" value="${board.boardTitle}">
											</div>
										</div>
										<div class="mb-3 row">
											<label class="form-label col-md-2">내용</label>
											<div class="col-md-10">
												<textarea id="boardContent" name="boardContent" rows="15" cols="5" class="form-control"
													placeholder="Enter text here" >${board.boardContent}</textarea>
											</div>
										</div>
										<div class="mb-3 row">
											<label class="form-label col-md-2">파일 선택</label>
											<div class="col-md-10">
												<input class="form-control" name="files" type="file" id="inputFile" multiple="multiple">
											</div>
										</div>
										<div class="mb-3 row">
											<label class="form-label col-md-2">익명여부</label>
											<div class="col-md-10">
												<input  type="checkbox" id="boardAnon"> 익명선택
											</div>
										</div>
											<!--파일리스트 수정시  -->
										<div class="text-center">
											<div class="mb-3">
												<div class="row row-cols-xxl-5 row-cols-xl-3 row-cols-sm-3 row-cols-1 justify-content-center">
													<c:if test="${status eq 'u'}">
														<div class="access-wrap border-0 flex-fill">
															<div class="row justify-content-start">
																<c:forEach items="${fileList}" var="file">
																	<div class="col-12">
																	   <div class="p-2 border-0">
																	      <div class="d-flex align-items-center">
																	      	<c:set var="fileName" value="${file.fileName}"/>
																			<c:set var="words" value="${fn:split(fileName,'.')}"/>
																			<c:set var="ext" value="${words[fn:length(words)-1]}"/>
																			<c:set var="trimmedExt" value="${fn:trim(ext)}"/>
																			<c:set var="upperedExt" value="${fn:toUpperCase(trimmedExt)}"/>
																			<c:choose>
																				<c:when test="${upperedExt eq 'JPG' || upperedExt eq 'JPEG' || upperedExt eq 'PNG' }">
																					<c:set var="fileExt" value="image.svg"/>
																				</c:when>
																				<c:when test="${upperedExt eq 'PDF'}">
																					<c:set var="fileExt" value="pdf-icon.svg"/>
																				</c:when>
																				<c:when test="${upperedExt eq 'XLSX' }">
																					<c:set var="fileExt" value="xls-icon.svg"/>
																				</c:when>
																				<c:otherwise>
																					<c:set var="fileExt" value="file.svg"/>
																				</c:otherwise>
																			</c:choose>
																			<img src="${pageContext.request.contextPath }/assets/img/icons/${fileExt}" alt="img" class="me-2" style="width: 20px; height: 20px;">
																				<h6 class="file-name mb-1 text-truncate me-3" style="max-width: 200px;">${file.fileName}</h6>
																				<span class="badge bg-secondary" style="font-size:10px">${file.fileFancysize }</span>
																				<a href="/downloadFile?fileIdentify=${file.fileIdentify}&fileNo=${file.fileNo}">
																					<span class="btn btn-light btn-sm ms-2">
																						<i class="fas fa-download"></i>
																					</span>
																				</a>
																	      </div>
																	   </div>
																	</div>
																</c:forEach>
																</div>
															</div>
														</c:if>
													</div>
												</div>
											</div>
										<div class="text-end">
											<input type="button" value="${name}" id="addBtn" class="btn btn-primary"/>
											<c:if test="${status eq 'u'}">
												<input type="button" id="cancelBtn" value="취소" class="btn btn-secondary">
											</c:if>
											<c:if test="${status ne 'u'}">
												<input type="button" id="listBtn" value="취소" class="btn btn-secondary">
											</c:if>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>

			<!-- Footer -->
			<%@ include file="/WEB-INF/views/theme/footer.jsp" %>
			<!-- /Footer -->
		</div>
		<!-- /page wrapper -->
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
<script src="${pageContext.request.contextPath }
/assets/js/theme-colorpicker.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/script.js"></script>


</body>
<script type="text/javascript">
const userId = sessionStorage.getItem("userId");
$(function(){
	CKEDITOR.replace("boardContent", {
		
	});

	CKEDITOR.config.height = "600px";

	let addBtn = $("#addBtn");
	let boardForm = $("#boardForm");
	let cancelBtn = $("#cancelBtn");
	let listBtn = $("#listBtn");
	
	//등록버튼 클릭 시 
	addBtn.on("click", function(){
		let boardTitle = $("#boardTitle").val();
		let boardContent = CKEDITOR.instances.boardContent.getData();
		let boardAnon = $("#boardAnon").is(":checked"); //익명여부 확인
		let boardWriter = $("#boardWriter").val(userId);

		$("#boardAnonHidden").val(boardAnon ? "Y" : "N");
		
		if(boardTitle == null || boardTitle == ""){
			showToastMessage("제목을 입력해주세요!", "warning");
			return false;
		} 
		if(boardContent == null || boardContent == ""){
			showToastMessage("내용을 입력해주세요!", "warning");
			return false;
		}
		if($(this).val() == "수정"){
			boardForm.attr("action", "/hrms/board/boardUpdate");
		}
		
		if(!$("#inputFile")[0].files.length){
			$("#inputFile")[0].disabled = true;
		}
		
		showSessionToastMessage("게시글이 성공적으로 등록되었습니다.", "success");
		boardForm.submit();
	})
	
	cancelBtn.on("click", function(){
		location.href="/hrms/board/boardDetail?boardNo=${board.boardNo}";
	});
	
	listBtn.on("click", function(){
		location.href="/hrms/board/boardList";
	})
});

</script>

</html>