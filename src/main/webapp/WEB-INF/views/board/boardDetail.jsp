<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
	<meta name="description" content="Smarthr - Bootstrap Admin Template">
	<meta name="keywords" content="admin, estimates, bootstrap, business, html5, responsive, Projects">
	<meta name="author" content="Dreams technologies - Bootstrap Admin Template">
	<meta name="robots" content="noindex, nofollow">
	<title>게시글 상세보기</title>
	
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
						<h2 class="mb-1">건의사항</h2>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<!-- Invoices -->
                <div>
                    <div class="row">
                        <div class="col-sm-10 mx-auto">
							 <a href="/hrms/board/boardList" class="back-icon d-flex align-items-center fs-15 fw-medium mb-3 d-inline-flex">
								<span class=" d-flex justify-content-center align-items-center rounded-circle me-2">
									<i class="ti ti-arrow-left"></i>
								</span>
								목록으로 돌아가기
                        	</a>
                            <div class="card">
                                <div class="card-body">
                                    <div class="row justify-content-between align-items-center border-bottom mb-3">
                                        <div class="col-md-6">
                                            <h4 class="fw-bold">제목:<span>${board.boardTitle}</span></h4>
                                        </div>
                                        <div class="col-md-6">
                                            <div class=" text-end mb-3">
                                                <h5 class="text-gray mb-1">게시글 번호 <span class="text-primary">${board.boardNo }</span></h5>
                                                <h5 class="text-gray mb-1">작성일 : <span class="text-dark">${fn:substring(board.boardDate,0,16) }</span> </h5>
                                                <c:choose>
                                                	<c:when test="${board.boardAnon eq 'Y' }">
                                                		<c:choose>
                                                			<c:when test="${sessionScope.userId eq board.boardWriter}">
		                                               			<h5 class="text-gray mb-1">작성자 : <span class="text-dark">익명(본인)</span> </h5>
                                                			</c:when>
                                                			<c:otherwise>
                                                				<h5 class="text-gray mb-1">작성자 : <span class="text-dark">익명</span> </h5>
                                                			</c:otherwise>	
                                                		</c:choose>
                                                	</c:when>
                                                	<c:otherwise>
		                                                <h5 class="text-gray mb-1">작성자 : <span class="text-dark">${board.boardWriter}</span> </h5>
                                                	</c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row border-bottom mb-3">
                                        <div class="col-md-5">
                                            <p class="text-dark mb-2 fw-semibold"></p>
                                            <div>
                                                <p class="mb-1">${board.boardContent}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row text-center border-bottom mb-3">
                                        <div class="mb-3">
											<div class="row row-cols-xxl-5 row-cols-xl-3 row-cols-sm-3 row-cols-1 justify-content-center">
												<c:choose>
													<c:when test="${empty fileList}">
													<p style="font-size:15px">첨부파일이 존재하지 않습니다.</p>
													</c:when>
													<c:otherwise>
														<div class="access-wrap border-0 flex-fill">
															<div class="row justify-content-start">
																<c:forEach items="${fileList}" var="file">
																	<div class="col-12"> <!--d-inline-flex  -->
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
													</c:otherwise>
												</c:choose>
											</div>
                                        </div>
                                    </div>
					                <div class="d-flex justify-content-end align-items-center mb-4" style="max-width: 200px; margin-left: auto;">
					                	<c:choose>
					                		<c:when test="${sessionScope.userId eq board.boardWriter }">
							                   <button type="button" class="btn btn-primary me-2" id="updateBtn">수정</button>
							                   <button type="button" class="btn btn-secondary border" id="deleteBtn">삭제</button>
					                		</c:when>
					                		<c:otherwise>
					                			<button type="button" class="btn btn-primary me-2" id="updateBtn" style="display: none;">수정</button>
												<button type="button" class="btn btn-secondary border" id="deleteBtn" style="display: none;">삭제</button>
					                		</c:otherwise>
					                	</c:choose>
					                </div>
                                </div>
                            </div>
                             <!--댓글  -->
			                 <div class="card">
				                 <div class="card-body">
					                <div class="card-footer card-comments" id="cmtArea">
					                	<c:choose>
					                		<c:when test="${empty commentList}">
					                			<p class="text-muted text-center">등록된 댓글이 없습니다.</p>
					                		</c:when>
					                		<c:otherwise>
							                	<c:forEach items="${commentList}" var="cmt">
							                		<div class="card-comment" style="margin-left: ${cmt.depth * 80}px;">
							                			<div class="comment-text">
							                				<span class="username">
								                				 <c:choose>
					                                               	<c:when test="${cmt.commentAnon eq 'Y' }">
					                                               		<c:choose>
					                                               			<c:when test="${sessionScope.userId eq cmt.commentWriter}">
						                                               			<h5 class="text-gray fs-14"><span class="text-dark">익명(본인)</span> </h5>
					                                               			</c:when>
					                                               			<c:otherwise>
					                                               				<h5 class="text-gray fs-14"><span class="text-dark">익명</span> </h5>
					                                               			</c:otherwise>	
					                                               		</c:choose>
					                                               	</c:when>
					                                               	<c:otherwise>
						                                                <h5 class="text-gray fs-14"><span class="text-dark">${cmt.commentWriter}</span> </h5>
					                                               	</c:otherwise>
				                                               </c:choose>
				                                               <div class="d-flex justify-content-between align-items-center">
				                                               		<div class="d-flex align-items-center gap-2">
						                                               <span class="text-muted small">${fn:substring(cmt.commentDate,0,16)}</span>
						                                               <span>${cmt.commentTitle}</span>
						                                                 <!--대댓글 버튼  -->
						                                               <c:choose>
							                                               	<c:when test="${cmt.depth ne 0 }">
							                                               		<button type="button" class="btn btn-sm btn-light reply-btn px-2 py-1 me-1" data-comment-no="${cmt.commentNo}" style="display: none">답글</button>
							                                               	</c:when>
							                                               	<c:otherwise>
							                                               		<button type="button" class="btn btn-sm btn-light reply-btn px-2 py-1 me-1" data-comment-no="${cmt.commentNo}">답글</button>
							                                               	</c:otherwise>
						                                               </c:choose>
					                                               	</div>
				                                               		<div class="d-flex align-items-center gap-1">
													                	<c:choose>
													                		<c:when test="${sessionScope.userId eq cmt.commentWriter}">
													                			<form action="/hrms/board/commentDelete" method="post" class="cmtDelForm">
													                				<input type="hidden" name="commentNo" value="${cmt.commentNo}"/>
													                				<input type="hidden" name="commentNos" value="${cmt.commentNos}"/>
													                				<input type="hidden" name="depth" value="${cmt.depth}"/>
																	                   <button type="button" class="btn btn-sm btn-primary px-2 py-1 cmtUbtn">수정</button>
																	                   <button type="button" class="btn btn-sm btn-secondary border px-2 py-1 cmtDbtn">삭제</button>
													                			</form>
													                		</c:when>
													                		<c:otherwise>
													                			<button type="button" class="btn btn-sm btn-primary px-2 py-1 cmtUbtn" style="display: none;">수정</button>
															                   	<button type="button" class="btn btn-sm btn-secondary border px-2 py-1 cmtDbtn" style="display: none;">삭제</button>
													                		</c:otherwise>
													                	</c:choose>
				                                               		</div>
						                						</div>
							                				</span>
							                			</div>
							                			
							                			<!-- 대댓글 입력창(초기에는 숨김) -->
							                			<div class="reply-form mt-2" id="replyForm-${cmt.commentNo}" style="display: none;">
							                				<form action="/hrms/board/replyCommentInsert" method="post" class="replyForm">
							                					<input type="hidden" name="commentWriter" value="${sessionScope.userId}"/>
							                					<input type="hidden" name="boardNo" value="${board.boardNo}"/>
							                					<input type="hidden" name="commentNos" id="cmtNos"/> <!--츄츄  -->
							                					<input type="hidden" name="commentNo" value="${cmt.commentNo}"/>
							                					<input type="hidden" name="commentAnon" class="replyAnonHidden" value="N"/>
							                					<textarea class="form-control form-control-sm replyContent" rows="2" name="commentTitle" placeholder="답글 작성"></textarea>
							                					
							                					 <div class="d-flex justify-content-end pt-2">
									                              <label class="me-2"><input type="checkbox" class="replyAnon" /> 익명</label>
									                              <button type="button" class="btn btn-sm btn-primary reply-submit">등록</button>
									                          	</div>
							                				</form>
							                			</div>
							                			<!--/대댓글 입력창  -->
							                		</div>
							                		<!--댓글 삭제 폼  -->
							                		<%--  <form action="/hrms/board/commentDelete" method="post" id="cmtDelForm">
							                		 
									                	<input type="text" name="commentNo" value="${cmt.commentNo}"/>
									                	<input type="text" name="commentNos" value="${cmt.commentNos}"/>
									                	<input type="hidden" name="depth" value="${cmt.depth}"/>
									                </form> --%>
							                	</c:forEach>
					                		</c:otherwise>
					                	</c:choose>
					                </div>
					                <div class="card-footer">
					                	<div class="img-push pt-3 cmt-sub-text">
					                		<form action="/hrms/board/commentInsert" method="post" id="cmtForm">
					                			<input type="hidden" name="commentWriter" id="cmtWriter"/>
					                			<input type="hidden" name="boardNo" value="${board.boardNo}"/>
					                			<input type="hidden" name="commentAnon" id="cmtAnonHidden" value="N"/>
						                		<textarea class="form-control form-control-sm cmtContent" onkeyup="contentLengthCheck(this)" rows="3" cols="20" id="cmtContent" name="commentTitle" placeholder="댓글작성"></textarea>
						                		<div>
							                		<label class="form-label col-md-1">익명여부</label>
							                		<input type="checkbox" id="cmtAnon"/>익명선택
						                		</div>
						                		<div class="d-flex justify-content-end pt-2">
						                			<button type="button" class="btn btn-sm btn-primary" id="cmtBtn">등록</button>
						                		</div>
					                		</form>
					                	</div>
					                </div>
			               		 </div>
			                 </div>
		                <!--/댓글  -->
                        </div>
                    </div>
                </div>
                
				<!-- /Invoices -->

                
                <form action="/hrms/board/boardDelete" method="post" id="delForm">
                	<input type="hidden" name="boardNo" value="${board.boardNo}"/>
                </form>
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
	const userId = sessionStorage.getItem("userId");
	let delForm = $("#delForm");
	let updateBtn = $("#updateBtn");
	let deleteBtn = $("#deleteBtn");
	
	////////////////////////////////댓글
	let cmtBtn = $("#cmtBtn");
	let cmtArea = $("#cmtArea");
	let cmtForm = $("#cmtForm");
	let cmtDelForm = $(".cmtDelForm");
	let cmtUbtn = $(".cmtUbtn");
	let cmtDbtn = $(".cmtDbtn");
	//수정버튼 클릭시 수정폼페이지 이동
	updateBtn.on("click", function(){
		delForm.attr("action", "/hrms/board/boardUpdateForm");
		delForm.attr("method", "get");
		delForm.submit();
	});
	
	//삭제버튼
	deleteBtn.on("click", function(){
		showConfirmModal("정말 삭제하시겠습니까?").then((isConfirmed) => {
			if(isConfirmed){
				delForm.submit();
			}
		});
	});
	
	//////////////////////////////////////////댓글 영역
	//댓글 등록 버튼
	cmtBtn.on("click",function(){
		let comment = $("#cmtContent").val();
		let cmtAnon = $("#cmtAnon").is(":checked");
		let cmtWriter = $("#cmtWriter").val(userId);
		
		$("#cmtAnonHidden").val(cmtAnon ? "Y" : "N");
	
		if(comment == null || comment == ""){
			showToastMessage("댓글 내용을 입력해주세요!", "warning");
			return false;
		}
		cmtForm.submit();
	});
	
	//대댓글 입력창 보이기/숨기기
	$(".reply-btn").on("click", function(){
		let commentNo = $(this).data("comment-no");
		$("#replyForm-" + commentNo).toggle();
	});
	
	//대댓글 등록 버튼
	$(".reply-submit").on("click",function(){
		let form = $(this).closest("form");
		let comment = form.find(".replyContent").val();
		let replyAnon = form.find(".replyAnon").is(":checked");
		
		form.find(".replyAnonHidden").val(replyAnon ? "Y" : "N");
		
		if(comment == null || comment == ""){
			showToastMessage("댓글 내용을 입력해주세요!", "warning");
			return false;
		}
		form.submit();
	})
	
	cmtDbtn.on("click",function(){
		
		showConfirmModal("정말 삭제하시겠습니까?").then((isConfirmed) => {
			if(isConfirmed){
				$(this).closest("form").submit();
			}
		});
		
	});
	
	let savedMessage = sessionStorage.getItem("toastMessage");
	let savedType = sessionStorage.getItem("toastType");

	if (savedMessage) {
		let toast = $("#toastMessage");
		toast.removeClass("bg-primary bg-success bg-danger bg-warning");
		toast.addClass(`bg-\${savedType}`);
		$("#toastBody").text(savedMessage);
		
		let toastInstance = new bootstrap.Toast(toast[0]);
		toastInstance.show();
		
		// 메시지 한 번 표시 후 제거 (새로고침 시 다시 뜨지 않도록)
		sessionStorage.removeItem("toastMessage");
		sessionStorage.removeItem("toastType");
	}
	
});

</script>
</html>