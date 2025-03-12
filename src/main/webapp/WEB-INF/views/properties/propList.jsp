<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib uri="jakarta.tags.core" prefix="c"  %>
<%@page import="kr.or.ddit.properties.vo.PropertiesVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
	<meta name="description" content="Smarthr - Bootstrap Admin Template">
	<meta name="keywords" content="admin, estimates, bootstrap, business, html5, responsive, Projects">
	<meta name="author" content="Dreams technologies - Bootstrap Admin Template">
	<meta name="robots" content="noindex, nofollow">
	<title>물품대여</title>
	
<style>
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
}
.modal-content {
    background-color: #fff;
    margin: 15% auto;
    padding: 20px;
    border-radius: 8px;
    width: 50%;
    text-align: center;
    border: 2px solid orange;
}
.close {
    color: orange;
    float: right;
    font-size: 28px;
    cursor: pointer;
}
.close:hover {
    color: darkorange;
}
.btn-warning {
    background-color: orange;
    color: white;
    border: none;
    cursor: pointer;
    margin-top: 10px;
}
.btn-warning:hover {
    background-color: darkorange;
}

.modal-footer {
    display: flex;
    justify-content: flex-end;
    gap: 8px; /* 버튼 간격 조절 */
}

.btn-group {
    display: flex;
    gap: 8px;
    justify-content: center; 
}
</style>
</head>

<body>
	<br/><br/>
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
	<div class="page-wrapper">
		<div class="content">
			<div class="d-md-flex d-block align-items-center justify-content-between page-breadcrumb mb-3">
				<div class="my-auto mb-2">
					<h2 class="mb-1">대여지원 물품 조회</h2>
				</div>
			</div>
		    <div class="mb-3">
		        <button id="openModal" class="btn btn-primary">물품추가</button>
		        <button id="psCodeBtn" class="btn btn-primary">물품분류추가</button>
		        <button id="viewPsCode" class="btn btn-primary">물품분류목록</button>
		    </div>
		    <table class="table table-bordered">
		        <thead class="table-light">
		            <tr>
		                <th class="text-center">분류코드</th>
		                <th class="text-center">물품명</th>
		                <th class="text-center">수량</th>
		                <th class="text-center">파일 코드</th>
		                <th class="text-center">내용</th>
		                <th class="text-center">관리</th>
		            </tr>
		        </thead>
		       	<tbody id="propertyTableBody">
				    <c:forEach var="prop" items="${propList}">
				        <tr>
				            <td class="text-center">${prop.psCode}</td>
				            <td class="text-center">${prop.propName}</td>
				            <td class="text-center">${prop.propQty}</td>
				            <td class="text-center">${prop.fileIdentify}</td>
				            <td>
				                <c:choose>
				                    <c:when test="${fn:length(prop.propContent) <= 40}">
				                        ${prop.propContent}
				                    </c:when>
				                    <c:otherwise>
				                        <div class="dropdown">
				                            <span class="content-short">${fn:substring(prop.propContent, 0, 40)}...</span>
				                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
				                                더보기
				                            </button>
				                            <ul class="dropdown-menu">
				                                <li class="dropdown-item">${prop.propContent}</li>
				                            </ul>
				                        </div>
				                    </c:otherwise>
				                </c:choose>
				            </td>
				            <td class="text-center">
							        <button class="btn btn-primary delete-btn me-2" data-id="${prop.propNo}">삭제</button>
							        <button class="btn btn-primary edit-btn" data-id="${prop.propNo}">수정</button>
							</td>
				        </tr>
				    </c:forEach>
				</tbody>
		    </table>
		</div> <!-- content -->
		<!-- 물품 수정 모달 -->
		<div class="modal fade" id="editPropModal">
		    <div class="modal-dialog modal-dialog-centered">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h4 class="modal-title">물품 수정</h4>
		                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		            </div>
		            <form id="editPropForm">
		                <div class="modal-body">
		                    <input type="hidden" id="editPropNo">
		                    <div class="mb-3">
		                        <label class="form-label">물품명</label>
		                        <input type="text" id="editPropName" class="form-control">
		                    </div>
		                    <div class="mb-3">
		                        <label class="form-label">수량</label>
		                        <input type="number" id="editPropQty" class="form-control">
		                    </div>
		                    <div class="mb-3">
		                        <label class="form-label">물품설명</label>
		                        <input type="text" id="editPropContent" class="form-control">
		                    </div>
		                    <div class="mb-3">
		                        <label class="form-label">파일 코드</label>
		                        <input type="text" id="editFileIdentify" class="form-control">
		                    </div>
		                </div>
		                <div class="modal-footer">
		                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		                    <button type="button" id="saveEditProp" class="btn btn-primary">수정</button>
		                </div>
		            </form>
		        </div>
		    </div>
		</div>
		<!-- 물품 삭제 모달 -->
		<div class="modal fade" id="delPropModal">
		    <div class="modal-dialog modal-dialog-centered">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h4 class="modal-title">물품 삭제</h4>
		                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		            </div>
		            <div class="modal-body">
		                <p>정말로 이 물품을 삭제하시겠습니까?</p>
		                <input type="hidden" id="deletePropNo">
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		                <button type="button" id="confirmDeleteProp" class="btn btn-danger">삭제</button>
		            </div>
		        </div>
		    </div>
		</div>
		<!-- 물품 추가 모달 -->
		<div class="modal fade" id="addTrainingModal">
		    <div class="modal-dialog modal-dialog-centered modal-lg">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h4 class="modal-title">물품 추가</h4>
		                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		            </div>
		            <form id="dataForm">
		                <div class="modal-body">
		                    <div class="mb-3">
		                        <label class="form-label">물품 분류 선택</label>
		                        <select id="psCodeSelect" class="form-select">
		                            <option value="">선택하세요</option>
		                        </select>
		                    </div>
		                    <div class="mb-3">
		                        <label class="form-label">물품명</label>
		                        <input type="text" id="propName" class="form-control">
		                    </div>
		                    <div class="mb-3">
		                        <label class="form-label">수량</label>
		                        <input type="number" id="propQty" class="form-control">
		                    </div>
		                    <div class="mb-3">
		                        <label class="form-label">파일 코드</label>
		                        <input type="text" id="fileIdentify" class="form-control">
		                    </div>
		                    <div class="mb-3">
		                        <label class="form-label">물품 내용</label>
		                        <textarea id="propContent" class="form-control"></textarea>
		                    </div>
		                </div>
		                <div class="modal-footer">
												<button type="button" id="exampleButton2" class="btn btn-success me-2">예시</button>
		                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		                    <button type="button" id="saveData" class="btn btn-primary">저장</button>
		                </div>
		            </form>
		        </div>
		    </div>
		</div>
		<!-- 물품 분류 추가 모달 -->
		<div class="modal fade" id="psCodeModal">
		    <div class="modal-dialog modal-dialog-centered">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h4 class="modal-title">물품 분류 추가</h4>
		                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		            </div>
		            <form id="psCodeForm">
		                <div class="modal-body">
		                    <div class="mb-3">
		                        <label class="form-label">물품 분류 번호</label>
		                        <input type="text" id="psCodeInput" class="form-control">
		                    </div>
		                    <div class="mb-3">
		                        <label class="form-label">대분류</label>
		                        <input type="text" id="psLarge" class="form-control">
		                    </div>
		                    <div class="mb-3">
		                        <label class="form-label">소분류</label>
		                        <input type="text" id="psSmall" class="form-control">
		                    </div>
		                </div>
		                <div class="modal-footer">
											<button type="button" id="exampleButton" class="btn btn-success me-2">예시</button>
		                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		                    <button type="button" id="savePsData" class="btn btn-primary">저장</button>
		                </div>
		            </form>
		        </div>
		    </div>
		</div>
		<!-- 물품 분류 보기 모달 -->
		<div class="modal fade" id="viewCodeModal">
		    <div class="modal-dialog modal-dialog-centered">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h4 class="modal-title">물품 분류 목록</h4>
		                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		            </div>
		            <div class="modal-body">
		                <table class="table table-bordered">
		                    <thead>
		                        <tr>
		                            <th>물품 분류 번호</th>
		                            <th>대분류</th>
		                            <th>소분류</th>
		                        </tr>
		                    </thead>
		                    <tbody id="viewCodeTableBody">
		                        <!-- Ajax로 데이터가 동적으로 추가됨 -->
		                    </tbody>
		                </table>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		            </div>
		        </div>
		    </div>
		</div>
	</div> <!-- page-wrapper -->
</div> <!-- Main Wrapper -->
</body>
<script>
$(document).ready(function () {
	$("#exampleButton").click(function () {
		// 랜덤한 PSXXXX 형식의 분류 번호 생성
		function generateRandomPSNumber() {
				return "PS" + Math.floor(1000 + Math.random() * 9000); // PS1000 ~ PS9999 범위
		}

		// 대분류 및 소분류 임의 값 리스트
		const mainCategories = ["전자기기", "사무용품", "연구", "기타"];
		const subCategories = {
				"전자기기": ["노트북", "데스크탑", "마우스", "키보드"],
				"사무용품": ["의자", "책상", "화이트보드", "펜"],
				"연구": ["실험도구", "현미경", "연구노트", "측정기기"],
				"기타": ["보관함", "기록지", "기타물품"]
		};

		// 랜덤한 대분류 선택
		let randomMainCategory = mainCategories[Math.floor(Math.random() * mainCategories.length)];
		// 랜덤한 소분류 선택
		let randomSubCategory = subCategories[randomMainCategory][Math.floor(Math.random() * subCategories[randomMainCategory].length)];

		// 입력 필드에 값 자동 채우기
		$("#psCodeInput").val(generateRandomPSNumber()); // 물품 분류 번호
		$("#psLarge").val(randomMainCategory); // 대분류
		$("#psSmall").val(randomSubCategory); // 소분류
	});

	$("#exampleButton2").click(function () {
		// 물품 분류 코드 리스트 (목록처럼 선택되도록)
		const categoryCodes = ["PS1005", "PS2003", "PS1001", "PS1002", "PS1012", "PS2002", "PS9005", "PS1006", "PS1004"];
		const itemNames = ["프로젝터", "모니터", "노트북", "데스크탑", "키보드", "의자", "펜", "볼펜", "마우스"];
		const itemQuantities = [5, 10, 15, 20, 25, 30, 35, 40, 50];
		const fileCodes = ["file001", "file002", "file003", "file004", "file005", "file006", "file007", "file008", "file009"];
		const itemDescriptions = [
				"고해상도 프로젝터",
				"27인치 모니터",
				"최신형 노트북",
				"사무용 데스크탑",
				"기계식 키보드",
				"편안한 사무용 의자",
				"부드러운 필기감의 펜",
				"고급 볼펜",
				"무선 마우스"
		];

		// 랜덤한 값 선택
		let randomIndex = Math.floor(Math.random() * categoryCodes.length);

		// 값 자동 입력
		$("#psCodeSelect").val(categoryCodes[randomIndex]); // 물품 분류 코드
		$("#propName").val(itemNames[randomIndex]); // 물품명
		$("#propQty").val(itemQuantities[randomIndex]); // 수량
		$("#fileIdentify").val(fileCodes[randomIndex]); // 파일 코드
		$("#propContent").val(itemDescriptions[randomIndex]); // 물품 내용
});

    $.ajax({
        url: '/hrms/prop/getPropertyCodes',              
        type: 'GET',
        dataType: 'json',
        success: function (data) {
            console.log("받은 데이터:", data);
            let selectBox = $("#psCodeSelect");
            data.forEach(function (item) {
                selectBox.append(`<option value="\${item.psCode}">\${item.psCode} - \${item.psLarge} / \${item.psSmall}</option>`);
            });
        },
        error: function (xhr, status, error) {
            console.error("물품 분류코드 가져오기 오류:", error);
        }
    });
    $("#openModal").click(function () {
        $("#addTrainingModal").modal("show");        
    });
    $("#saveData").click(function () {
        const data = {
            propNo: '',
            propName: $("#propName").val().trim(),
            propContent: $("#propContent").val().trim(),
            propQty: $("#propQty").val().trim(),
            fileIdentify: $("#fileIdentify").val().trim(),
            psCode: $("#psCodeSelect").val()  
        };
        if (!data.propName || !data.psCode) {
            showToastMessage("필수 정보를 입력하세요.", "warning");
            return;
        }
        $.ajax({
            url: '/hrms/prop/insert',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify([data]), 
            success: function (response) {
                showToastMessage("새로운 데이터가 저장되었습니다.", "success");
                setTimeout(() => location.reload(), 1000);
            },
            error: function (xhr, status, error) {
                console.error("데이터 저장 중 오류 발생:", xhr.responseText);
                showToastMessage("데이터 저장 중 오류가 발생했습니다.", "danger");
            }
        });
    });
    $("#psCodeSelect").change(function () {
        console.log("선택된 psCode:", $(this).val());
    });
});
</script>
<script>
$(document).ready(function () {
	
	$(document).ready(function () {
	    // 수정 버튼 클릭 시 모달 열기
	    $(document).on("click", ".edit-btn", function () {
	        let propNo = $(this).data("id"); // 클릭한 버튼의 propNo 가져오기
	        $.ajax({
	            url: `/hrms/prop/getProperty/\${propNo}`,
	            type: "GET",
	            dataType: "json",
	            success: function (data) {
	                console.log("받은 데이터:", data);
	                $("#editPropNo").val(data.propNo);
	                $("#editPropName").val(data.propName);
	                $("#editPropQty").val(data.propQty);
	                $("#editFileIdentify").val(data.fileIdentify);
	                $("#editPropContent").val(data.propContent);
	                $("#editPropModal").modal("show");
	            },
	            error: function (xhr, status, error) {
	                console.error("수정 데이터 불러오기 오류:", error);
	                alert("데이터를 불러오는 중 오류가 발생했습니다.");
	            }
	        });
	    });

	    // 수정 저장 버튼 클릭 시
	    $("#saveEditProp").click(function () {
	        let updatedData = {
	            propNo: $("#editPropNo").val(),
	            propName: $("#editPropName").val().trim(),
	            propQty: $("#editPropQty").val().trim(),
	            propContent: $("#editPropContent").val().trim(),
	            fileIdentify: $("#editFileIdentify").val().trim()
	        };

	        console.log("전송할 데이터:", updatedData);
	        $.ajax({
	            url: "/hrms/prop/updateProperty",
	            type: "PUT",
	            contentType: "application/json",
	            data: JSON.stringify(updatedData),
	            success: function (response) {
	                alert("수정되었습니다.");
	                $("#editPropModal").modal("hide");
	                setTimeout(() => location.reload(), 1000);
	            },
	            error: function (xhr, status, error) {
	                console.error("수정 오류:", xhr.responseText);
	                alert("수정 중 오류가 발생했습니다.");
	            }
	        });
	    });

	    // 삭제 버튼 클릭 시 모달 열기
	    $(document).on("click", ".delete-btn", function () {
	        let propNo = $(this).data("id");
	        $("#deletePropNo").val(propNo);
	        $("#delPropModal").modal("show");
	    });

	    // 삭제 확인버튼 클릭
	    $("#confirmDeleteProp").click(function () {
	        let propNo = $("#deletePropNo").val();
	        $.ajax({
	            url: `/hrms/prop/deleteProperty/\${propNo}`,
	            type: "POST",  
	            data: { _method: "DELETE" },  
	            success: function (response) {
	                alert("삭제되었습니다.");
	                $("#delPropModal").modal("hide");
	                setTimeout(() => location.reload(), 1000);
	            },
	            error: function (xhr, status, error) {
	                console.error("삭제 오류:", xhr.responseText);
	                alert("삭제 중 오류가 발생했습니다.");
	            }
	        });
	    });
	});
	
    $("#openModal").click(function () {
        $("#addTrainingModal").modal("show");
    });

    $("#psCodeBtn").click(function () {
        $("#psCodeModal").modal("show");
    });
    
    $("#viewPsCode").click(function () {
        $.ajax({
            url: '/hrms/prop/getPropertyCodes', 
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                console.log("받은 데이터:", data);
                let tableBody = $("#viewCodeTableBody");
                tableBody.empty(); 
                if (data.length === 0) {
                    tableBody.append('<tr><td colspan="3" class="text-center">데이터가 없습니다.</td></tr>');
                } else {
                    data.forEach(function (item) {
                        let row = `
                            <tr>
                                <td>\${item.psCode}</td>
                                <td>\${item.psLarge}</td>
                                <td>\${item.psSmall}</td>
                            </tr>
                        `;
                        tableBody.append(row);
                    });
                }
                $("#viewCodeModal").modal("show");
            },
            error: function (xhr, status, error) {
                console.error("물품 분류 목록 가져오기 오류:", error);
                alert("데이터를 불러오는 중 오류가 발생했습니다.");
            }
        });
    });

    $("#savePsData").click(function () {
        const data = [{
            psCode: $("#psCodeInput").val().trim(),
            psLarge: $("#psLarge").val().trim(),
            psSmall: $("#psSmall").val().trim()
        }];

        if (!data[0].psCode || !data[0].psLarge || !data[0].psSmall) {
            showToastMessage("모든 필드를 입력하세요.", "danger");
            return;
        }
        $.ajax({
            url: '/hrms/prop/insertPs',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),  
            success: function (response) {
                showToastMessage("새로운 분류코드가 저장되었습니다.", "success");
                $("#psCodeModal").modal("hide");
                setTimeout(() => location.reload(), 1000);
            },
            error: function (xhr, status, error) {
                console.error("분류코드 저장 중 오류 발생:", xhr.responseText);
								showToastMessage("데이터 저장 중 오류가 발생했습니다.", "danger");
            }
        });
    });
});

	// jsp 에 직접 추가하는경우 toast.addClass(`bg-\${type}`);
	// 토스트 메시지 표시 함수 (Bootstrap Toast)
	function showToastMessage(message, type = "primary") {
	  let toast = $("#toastMessage");
	  toast.removeClass("bg-primary bg-success bg-danger bg-warning");
	  toast.addClass(`bg-\${type}`);
	  $("#toastBody").text(message);
	  let toastInstance = new bootstrap.Toast(toast[0]);
	  toastInstance.show();
	}
</script>

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
</html>