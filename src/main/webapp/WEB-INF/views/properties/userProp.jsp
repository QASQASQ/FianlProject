<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib uri="jakarta.tags.core" prefix="c"  %>
<%@page import="kr.or.ddit.properties.vo.PropertiesVO"%>

<html>
<head>
<style>
.detail-card {
    display: flex;
    align-items: center;
    gap: 15px;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 15px;
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
}

/* 이미지 스타일 */
.detail-img img {
    width: 150px;
    height: auto;
    border-radius: 5px;
    object-fit: cover;
}

/* 상세 정보 스타일 */
.detail-info {
    flex-grow: 1;
}

.detail-info h4 {
    margin: 0;
    font-size: 18px;
    font-weight: bold;
}

.detail-info p {
    margin-top: 5px;
    font-size: 14px;
    color: #666;
}


</style>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
	<meta name="description" content="Smarthr - Bootstrap Admin Template">
	<meta name="keywords" content="admin, estimates, bootstrap, business, html5, responsive, Projects">
	<meta name="author" content="Dreams technologies - Bootstrap Admin Template">
	<meta name="robots" content="noindex, nofollow">
	<title>대여물품조회</title>
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>

<body>
<br/><br/>
	<div class="main-wrapper">
		<%@ include file="/WEB-INF/views/theme/header.jsp" %>
		<%@ include file="/WEB-INF/views/theme/sidebar.jsp" %>
	
		<div class="page-wrapper">
			<div class="content">
	
			<!-- Breadcrumb -->
			<div class="d-md-flex d-block align-items-center justify-content-between page-breadcrumb mb-3">
				<div class="my-auto mb-2">
					<h2 class="mb-1">물품 대여</h2>
				</div>
				<div class="d-flex my-xl-auto right-content align-items-center flex-wrap ">
					<div class="me-2 mb-2">
						<div class="dropdown">
							<ul class="dropdown-menu  dropdown-menu-end p-3">
								<li>
									<a href="javascript:void(0);" class="dropdown-item rounded-1"><i class="ti ti-file-type-pdf me-1"></i>Export as PDF</a>
								</li>
								<li>
									<a href="javascript:void(0);" class="dropdown-item rounded-1"><i class="ti ti-file-type-xls me-1"></i>Export as Excel </a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- /Breadcrumb -->

			<!-- Leads List -->
			<div class="card">
				<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
					<h5>대여가능한 물품</h5>
					<div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
						<div class="me-3">
							<div class="input-icon-end position-relative">
								<input type="text" class="form-control" placeholder="물품분류코드" style="width: 100px;" id="psCode">
							</div>
						</div>
						<div class="me-3">
							<div class="input-icon-end position-relative">
								<input type="text" class="form-control" placeholder="물품명" style="width: 100px;" id="propName">
							</div>
						</div>
						<input type="button" class="btn btn-primary d-flex align-items-center" value="검색" id="searchBtn">
					</div>
				</div>
				<div class="card-body p-0"> <!-- CARD CARD CARDCARDCARDCARDCARDCARDCARDCARDCARDCARDCARDCARD -->
					<div class="custom-datatable-filter table-responsive">
						<table class="table datatable">
							<thead class="thead-light">
								<tr>
									
									<th class="text-center">물품분류코드</th>
									<th class="text-center">물품명</th>
									<th class="text-center">대여가능수량</th>
									<th class="text-center">물품상세설명</th>
									<th class="text-center">물품대여신청</th>
								</tr>
							</thead>
							<tbody id="dataTable-tbody">
							</tbody> <!--  /tbody -->
						</table> <!-- /테이블 -->
					</div>
				</div>
				<div id="pagingArea" style="display: flex; justify-content: center; align-items: center; padding:15px;">
				</div>
				<script>
					let searchBtn = $("#searchBtn");
					let pagingArea = $("#pagingArea");
					getList(1);
					$(function(){
						searchBtn.on("click", function(){
							let psCode = $("#psCode");
							let propName = $("#propName");
							
							console.log("검색어들 : ", psCode.val(), propName.val());
							getList(1, psCode.val(), propName.val());
						});
						
						pagingArea.on("click", "a", function(){
							event.preventDefault();
							let page = $(this).data("page");
							let psCode = $("#psCode");
							let propName = $("#propName");
							let propQty = $("#propQty");
							getList(page, psCode.val(), propName.val(), propQty.val());
						})	
					});
					
					function getList(page, psCode, propName) {
					    let pagingArea = $("#pagingArea");
					    let dataTable_tbody = $("#dataTable-tbody");
					
					    let data = { page: page };
					    if (psCode != null) data.psCode = psCode;
					    if (propName != null) data.propName = propName;
					    
					    console.log("전송 데이터:", data);
					
					    $.ajax({
					        url: "/hrms/prop/rest/getPropAllList",
					        type: "POST",
					        data: JSON.stringify(data),
					        contentType: "application/json;charset=utf-8",
					        success: function (res) {
					            console.log("응답 데이터:", res);
					
					            let tr = "";
					
					            if (res.propAllList && res.propAllList.length > 0) {
					                res.propAllList.forEach(function(prop, index) {
					                    let rentalButton = prop.propQty > 0 
					                        ? `<button class="btn btn-primary rental-btn"
					                                    data-propno="\${prop.propNo}"
					                                    data-propname="\${prop.propName}"
					                                    data-propcontent="\${prop.propContent}"
					                                    data-fileidentify="\${prop.fileIdentify}">
					                                    대여 신청
					                                </button>`
					                        : `<span class="text-danger">대여 신청 불가</span>`; // propQty == 0이면 "대여 신청 불가" 텍스트 표시
					
					                    tr += `
					                        <tr data-index="\${index}">
					                            
					                            <td class="text-center">\${prop.psCode}</td>
					                            <td class="text-center">\${prop.propName}</td>
					                            <td class="text-center">\${prop.propQty}</td>
					                            <td class="text-center"><div class="dropdown">
					                                <button class="toggle-detail btn btn-primary" data-index="\${index}">더보기</button>
					                                </div>
					                            </td>
					                            <td class="text-center">\${rentalButton}</td> <!-- 조건부 버튼 삽입 -->
					                        </tr>
					                        <tr class="detail-row" data-index="\${index}" style="display: none;">
					                            <td colspan="5">
					                                <div class="detail-card">
					                                    <div class="detail-img">
					                                        <img src="/assets/img/\${prop.fileIdentify}.jpg" 
					                                             alt="물품 이미지"
					                                             onerror="this.onerror=null; this.src='/assets/img/default.jpg';">
					                                    </div>
					                                    <div class="detail-info">
					                                        <h4>\${prop.propName}</h4>
					                                        <p>\${prop.propContent}</p>
					                                    </div>
					                                </div>
					                            </td>
					                        </tr>
					                    `;
					                });
					
					                dataTable_tbody.html(tr);
					            } else {
					                dataTable_tbody.html(`<tr><td colspan="5" class="text-center">데이터가 없습니다.</td></tr>`);
					            }
					
					            pagingArea.html(res.pageVO.pagingHTML);
					        },
					        error: function (error) {
					            console.log("AJAX 요청 실패", error);
					        },
					    });
					}
					$(document).on("click", ".toggle-detail", function() {
					    let index = $(this).data("index");
					    $(`tr.detail-row[data-index='\${index}']`).slideToggle(1);
					});
					</script>
			</div>
			<!-- /Leads List -->
			</div> <!-- content -->
			<!-- Footer -->
			<%@ include file="/WEB-INF/views/theme/footer.jsp" %>
			<!-- /Footer -->
			<!-- 대여 신청 모달 -->
			<div class="modal fade" id="rentalModal" tabindex="-1" aria-labelledby="rentalModalLabel" aria-hidden="true">
    			<div class="modal-dialog">
        			<div class="modal-content">
            			<div class="modal-header">
                			<h5 class="modal-title" id="rentalModalLabel">물품 대여 신청</h5>
                			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            			</div>
            		<div class="modal-body">
		                <form id="rentalForm">
		                    <div class="mb-3">
		                        <label for="rentalPropName" class="form-label">물품명</label>
		                        <input type="text" id="rentalPropName" class="form-control" readonly>
		                    </div>
		                    <div class="mb-3">
		                        <label for="rentalPropContent" class="form-label">설명</label>
		                        <textarea id="rentalPropContent" class="form-control" rows="3" readonly></textarea>
		                    </div>
		                    <div class="mb-3 text-center">
		                        <label class="form-label">물품 사진</label><br>
		                        <img id="rentalImage" src="" alt="이미지 없음" style="max-width: 200px;">
		                    </div>
		                    <div class="mb-3">
		                        <label for="rentalSdate" class="form-label">대여일</label>
		                        <input type="date" id="rentalSdate" class="form-control" readonly>
		                    </div>
		                    <div class="mb-3">
		                        <label for="rentalEdate" class="form-label">반납 예정일</label>
		                        <input type="date" id="rentalEdate" class="form-control" required>
		                    </div>
		                    <input type="hidden" id="rentalPropNo">
		                    <input type="hidden" id="emplNo">
		                </form>
            		</div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">닫기</button>
	                <button type="button" id="rentalSaveBtn" class="btn btn-primary">대여 신청</button>
	            </div>
        </div>
    </div>
</div>
</div>
</div>
<!-- /Main Wrapper -->
		<!-- 모달창들 -->
		<%@ include file="/WEB-INF/views/theme/modal.jsp" %>
		
<script>
document.addEventListener("DOMContentLoaded", function () {
    const rentalButtons = document.querySelectorAll(".rental-btn");
    const rentalSaveBtn = document.getElementById("rentalSaveBtn");

    $(document).on("click", ".rental-btn", function () {
        $("#rentalPropNo").val($(this).data("propno"));
        $("#rentalPropName").val($(this).data("propname"));
        $("#rentalSdate").val(new Date().toISOString().split("T")[0]);
        $("#rentalEdate").val("");  
        $("#rentalPropContent").text($(this).data("propcontent"));
        $("#rentalImage").attr("src", "/assets/img/" + $(this).data("fileidentify") + ".jpg");

        let rentalModal = new bootstrap.Modal(document.getElementById("rentalModal"));
        rentalModal.show();
    });

    rentalSaveBtn.addEventListener("click", function () {
        const rentalData = {
            emplNo: $("#emplNo").val(),
            propNo: $("#rentalPropNo").val(),
            propName: $("#rentalPropName").val(),
            epSdate: $("#rentalSdate").val(),
            epEdate: $("#rentalEdate").val(),
        };

        if (!rentalData.epEdate) {
            showToastMessage("⚠️ 반납 예정일을 선택하세요.", "warning");
            return;
        }

        $.ajax({
            url: '/hrms/prop/rentItem',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(rentalData),
            success: function (response) {
                showToastMessage("✅ 대여에 성공했습니다.", "success");
                let rentalModal = bootstrap.Modal.getInstance(document.getElementById("rentalModal"));
                rentalModal.hide();
                setTimeout(() => location.reload(), 1000);
            },
            error: function (error) {
                showToastMessage("❌ 대여 신청 중 오류가 발생했습니다.", "danger");
            }
        });
    });
});

</script>
</body>


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
	
</html>