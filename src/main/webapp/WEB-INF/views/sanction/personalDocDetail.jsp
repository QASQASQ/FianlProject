<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
	<meta name="description" content="Smarthr - Bootstrap Admin Template">
	<meta name="keywords"content="admin, estimates, bootstrap, business, corporate, creative, management, minimal, modern,  html5, responsive">
	<meta name="author" content="Dreamstechnologies - Bootstrap Admin Template">
	<meta name="robots" content="noindex, nofollow">
	<title>전자 결재 페이지</title>



</head>
<style>
#docContent table { /* 이 부분 건드리면 소속,직위,성명,사원번호 든 table만 제외하고 작동함 */
    border: 2px solid;
    margin: auto;
}

#docContent table td, 
#docContent table th {
    border: 2px solid;
}

#docContent .info{
  font-weight: bold;
  width: 180px;
  background-color: #E8E8E8;
}

#docContent #detail{
  height: 300px;
}

#docContent td{
  height: 50px;
  text-align: center;
}

#docContent #remark{
  text-align: left;
}

#docContent h1{
  text-align: center;
}

#docContent .info{
	margin-left: 1000px;
}

.sort {
 font-weight: bold;
 background-color: rgb(232, 232, 232) !important;
}

#aprDiv{
 margin-right: 288px !important;
}

#docNoView {
 margin-left: 288px !important;
}

</style>
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

		<div class="page-wrapper cardhead">
			<div class="content ">

				<!-- Page Header -->
				<div class="page-header">
					<div class="row">
						<div class="col-sm-12">
							<h3 class="page-title">전자 결재</h3>
						</div>
					</div>
				</div>
				<!-- /Page Header -->

				<div class="row">

					<!-- 문서 자체 정보 -->
					<div class="col-md-12">
					
						<a href="/hrms/sanction/personalDocuments" class="back-icon d-flex align-items-center fs-15 fw-medium mb-3 d-inline-flex">
							<span class=" d-flex justify-content-center align-items-center rounded-circle me-2">
								<i class="ti ti-arrow-left"></i>
							</span>
							목록으로 돌아가기
						</a>
						<div class="card">
							<div class="card-header">
								<h5 class="card-title">기안 문서</h5> <br/>
								
								<table class="table datatable text-center">
									<tr>
										<td class="sort">문서 번호</td>
										<td id="docNo" class="text-start"></td>
										<td class="sort">기안자</td>
										<td id="writer" class="text-start"></td>
									</tr>
									<tr>
										<td class="sort">문서 제목</td>
										<td id="docTitle" class="text-start"></td>
										<td class="sort">문서 상태</td>
										<td id="docStatus" class="text-start"></td>
									</tr>
									<tr>
										<td class="sort">기안 일시</td>
										<td id="submitDate" class="text-start"></td>
										<td class="sort">보존 기한</td>
										<td id="expiredDate" class="text-start"></td>
									</tr>
									<tr>
										<td class="sort">문서 전결 허용 여부</td>
										<td id="allowAt" class="text-start"></td>
										<td class="sort">전결권 보유 여부(본인)</td>
										<td id="myAllow" class="text-start"></td>
									</tr>
									<tr>
										<td class="sort">결재 선(내림차순)</td>
										<td id="sanctionLine" class="text-start"></td>
										<td class="sort">결재 확정 일시</td>
										<td id="finalDate" class="text-start"></td>
									</tr>
									<tr>
										<td class="sort">참조자</td>
										<td id="refLine" colspan="3" class="text-start"></td>
									</tr>
									<tr>
										<td class="sort">첨부 파일</td>
										<td id="docFileView" colspan="3" class="text-start"></td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					
					<div id="rejectResnDiv" class="col-md-12" style="display: none;">
						<div class="card">
							<div class="card-header">
								<span style="font-weight: bold;">결재 의견:</span>
								<span id="rejectResn">
									
								</span>
							</div>
						</div>
					</div>
					
					<div class="col-md-12">
						<div class="card">
							<div class="card-header">
								<div id="docContent">
								
								</div>
							</div>
						</div>
					</div>
					
				</div>
				
			</div>

			<a href="/hrms/sanction/personalDocuments">
				<button class="btn btn-primary" style="float: right; margin-bottom: 30px; margin-right: 25px;">목록으로 돌아가기</button>
			</a>
			
		</div>
	</div>

	<!-- /Main Wrapper -->

	<!-- 헤더, 사이드바에서 사용하는 스크립트-->
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
<script>
$(function() {
    initPage();  // 초기화 함수 호출
});

/** ✅ 페이지 초기화 함수 */
function initPage() {
    const userId = sessionStorage.getItem("userId");
    console.log("userId: ", userId);

    const docNo = getQueryParam('docNo');
    console.log("docNo: ", docNo);

    getUserPosition(userId, function(myEmplPosition) {
        getDocumentDetail(docNo, myEmplPosition);
    });
}

/** ✅ URL 파라미터 가져오기 */
function getQueryParam(param) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(param);
}

/** ✅ 사용자 직위 정보 호출 */
function getUserPosition(userId, callback) {
    $.ajax({
        url: "/sanction/nowEmplInfo",
        method: "get",
        data: { userId: userId },
        dataType: 'json',
        success: function(res) {
            console.log("현재 내 직위코드: ", res.emplPosition);
            if (callback) callback(res.emplPosition);
        },
        error: function() {
        	showToastMessage("사용자 직위 정보를 가져오는 중 오류가 발생했습니다.", "danger");
        }
    });
}

/** ✅ 문서 상세 정보 호출 및 렌더링 */
function getDocumentDetail(docNo, myEmplPosition) {
    $.ajax({
        url: "/sanction/getApvDocDetail",
        method: 'get',
        data: { docNo: docNo },
        dataType: 'json',
        success: function(res) {
            console.log("문서 상세 정보: ", res);
            renderDocumentDetail(res, myEmplPosition);
            renderReference(docNo);
        },
        error: function() {
        	showToastMessage("문서 상세정보 호출에 오류가 발생했습니다.", "danger");
        }
    });
}

/** ✅ 문서 상세 정보 화면 출력 */
function renderDocumentDetail(data, myEmplPosition) {
    const docStatusMap = { '01': '결재 중', '02': '승인', '03': '반려' };
    const dcrbAllowMap = { 'Y': '허용', 'N': '불허' };
    const dcrbAllow = dcrbAllowMap[data.dcrbAllow];
    const dcrbRight = myEmplPosition !== '01' ? "보유" : "미보유";

    $("#docNo").text(data.docNo);
    $("#writer").text(data.writerNo);
    $("#docTitle").text(data.docTitle);
    $("#docStatus").text(docStatusMap[data.docApv] || "알 수 없음");
    $("#submitDate").text(data.sanctnRqstdt);
    $("#expiredDate").text(data.docPeriod);
    
    if(dcrbAllow == "허용") {
    	$("#allowAt").html(`<span class=' badge badge-success-transparent'>\${dcrbAllow}</span>`);
    } else {
    	$("#allowAt").html(`<span class=' badge badge-pink-transparent'>\${dcrbAllow}</span>`);
    }
    
    if(dcrbRight == "보유") {
    	$("#myAllow").html(`<span class=' badge badge-success-transparent'>\${dcrbRight}</span>`);
    } else {
    	$("#myAllow").html(`<span class=' badge badge-pink-transparent'>\${dcrbRight}</span>`);
    }

    if (data.dcrbAllow === 'Y' && dcrbRight === '보유') {
        $("#proxyBtn").show();
    }

    if (data.aprRefList && data.aprRefList.length > 0) {
    	// 결재자 리스트 렌더링(결재선)
        renderApprovers(data.aprRefList);
    }
    
    // 결재 확정 일시
    if(data.finalDate != null) {
    	$("#finalDate").text(data.finalDate);
    } else {
    	$("#finalDate").text("결재 이전 상태입니다.");
    }
    
    // 첨부 파일 출력
    let fileHtml = "";
    if(data.fileList != null && data.fileList.length > 0) {
    	for(let i = 0; i < data.fileList.length; i++){
        	fileHtml += `
        		<div><a href="/downloadFile?fileIdentify=\${data.fileList[i].fileIdentify}&fileNo=\${data.fileList[i].fileNo}">\${data.fileList[i].fileName}</a></div>
       		`;
        }
    } else {
    	fileHtml = "첨부된 파일이 없습니다.";
    }
    
	$("#docFileView").html(fileHtml);
	
    $("#docContent").html(data.docContent);
    if($("#docNoView").text() == "문서 번호:") {
    	$("#docNoView").append(" " + data.docNo);
    }
    
    // 반려 사유 출력
 	// aprRefList 배열에서 sanctnOpinion이 null이 아닌 항목을 찾습니다.
    let validApprover = data.aprRefList.find(approver => approver.sanctnOpinion !== null);

    // 찾은 항목이 있으면 해당 sanctnOpinion 값을 변수에 담고, 없으면 null 처리합니다.
    let sanctnOpinion = validApprover ? validApprover.sanctnOpinion : null;
    
    if(sanctnOpinion != null) {
    	$("#rejectResnDiv").show();
    	$("#rejectResn").text(sanctnOpinion);
    }
}

/** ✅ 결재자 리스트 렌더링 */
function renderApprovers(approverList) {
    let sanctionHtml = approverList.map(approver => {
        if (approver.sanctnStatus == '승인') {
            return `<div>(\${approver.sanctnerPosition}) \${approver.sanctnerNo} <span class="badge badge-success-transparent">\${approver.sanctnStatus}</span></div>`;
        } else if (approver.sanctnStatus == '열람') {
            return `<div>(\${approver.sanctnerPosition}) \${approver.sanctnerNo} <span class="badge badge-info-transparent">\${approver.sanctnStatus}</span></div>`;
        } else if(approver.sanctnStatus == '전결') {
            return `<div>(\${approver.sanctnerPosition}) \${approver.sanctnerNo} <span class="badge badge-purple-transparent">\${approver.sanctnStatus}</span></div>`;
        } else if(approver.sanctnStatus == '결재 대기') {
            return `<div>(\${approver.sanctnerPosition}) \${approver.sanctnerNo} <span class="badge badge-dark-transparent">\${approver.sanctnStatus}</span></div>`;
        } else if(approver.sanctnStatus == '위임 전결') {
            return `<div>(\${approver.sanctnerPosition}) \${approver.sanctnerNo} <span class="badge badge-secondary-transparent">\${approver.sanctnStatus}</span></div>`;
        } else if(approver.sanctnStatus == '반려') {
            return `<div>(\${approver.sanctnerPosition}) \${approver.sanctnerNo} <span class="badge badge-pink-transparent">\${approver.sanctnStatus}</span></div>`;
        }
    }).join("");
    $("#sanctionLine").html(sanctionHtml);
}

/** ✅ 참조자 리스트 렌더링 */
function renderReference(docNo) {
	$.ajax({
		url: "/sanction/getRefList",
		method: "get",
		data: { docNo: docNo },
		dataType: 'json',
		success: function(refRes) {
			console.log("refRes: ", refRes);
			
			let readTxt = "";
			
			if(refRes.length > 0) {
				$.each(refRes, function(index, item){
					if(refRes[index].refRead == 'N') {
						readTxt = "안읽음";
					} else {
						readTxt = "읽음";
					}
					
					if(readTxt == "읽음") {
						$("#refLine").append(`<div>(\${item.refPosition}) \${item.refNo} <span class=' badge badge-info-transparent'>\${readTxt}</span></div>`);
					} else {
						$("#refLine").append(`<div>(\${item.refPosition}) \${item.refNo} <span class=' badge badge-pink-transparent'>\${readTxt}</span></div>`);
					}
				});
			} else {
				$("#refLine").append("지정된 참조자가 없습니다.");
			}
			
		}
	});
}

</script>
</html>