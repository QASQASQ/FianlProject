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
						<a href="/hrms/sanction/requestedApvDocuments" class="back-icon d-flex align-items-center fs-15 fw-medium mb-3 d-inline-flex">
							<span class=" d-flex justify-content-center align-items-center rounded-circle me-2">
								<i class="ti ti-arrow-left"></i>
							</span>
							목록으로 돌아가기
						</a>
						<div class="card">
							<div class="card-header">
								<h5 class="card-title">결재 문서</h5> <br/>
								
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
										<td class="sort">결재 선</td>
										<td id="sanctionLine" class="text-start"></td>
										<td class="sort">결재 일시(본인)</td>
										<td id="sanctnDate" class="text-start"></td>
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
					
					<div class="col-md-12" id="buttonDiv">
						<div class="card">
							<div class="card-header">
								<div>
									<button class="btn btn-primary" id="allowBtn">승인</button>
									<button class="btn btn-secondary" id="rejectBtn">반려</button>
									<button class="btn btn-primary" id="proxyBtn" style="display: none;">전결</button>
								</div>
								
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
			
			<a href="/hrms/sanction/requestedApvDocuments">
				<button class="btn btn-primary" style="float: right; margin-bottom: 30px; margin-right: 25px;">목록으로 돌아가기</button>
			</a>
			
		</div>
	</div>
	
	<!-- 커스텀 결재선 저장 Modal -->
	<div class="modal fade" id="opinionModal" tabindex="-1" aria-labelledby="previewModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-sm"> <!-- modal-xl: 큰 모달 -->
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="previewModalLabel">의견 작성</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
	      </div>
	      <div class="modal-body">
	      	의견을 작성해 주세요.
	      	<textarea rows="5" cols="30" class="form-control" id="opinionText"></textarea>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button> &nbsp;
	        <button type="button" class="btn btn-primary" id="saveOpinion">작성 완료</button>
	      </div>
	    </div>
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

//세션에서 userId 가져오기
const userId = sessionStorage.getItem("userId");
console.log("userId: ", userId);

// URL의 쿼리스트링에서 문서번호(docNo) 추출
const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);
const docNo = urlParams.get('docNo');
console.log("docNo: ", docNo);

let userIdData = { userId: userId };
let docNoData = { docNo: docNo };
let docApv = "";
let dcrbAllow = "";
let dcrbRight = "";
let dsCode = "";

let thisData = {
    sanctnerNo: userId,
    docNo: docNo
};

// 현재 사용자의 직위 정보를 저장할 변수
let myEmplPosition = "";

$(function(){
    
    
    // 현재 내 직위 조회
    $.ajax({
        url: "/sanction/nowEmplInfo",
        method: "get",
        data: userIdData,
        dataType: 'json',
        success: function(res){
            console.log("현재 내 직위코드: ", res.emplPosition);
            myEmplPosition = res.emplPosition;
            
            // 현재 문서에서 내 결재 상태 조회
            $.ajax({
                url: "/sanction/thisDocApvStatus",
                method: "get",
                data: thisData,
                dataType: 'json',
                success: function(res){
                    console.log("현재 문서의 내 결재상태: ", res);
                    let sanctnDate = res.sanctnDate;
                    let nowSanctnSt = res.sanctnStatus;
                    console.log("nowSanctnSt", nowSanctnSt);
                    let nowSanctnFlow = res.sanctnFlow;
                    
                    if(nowSanctnSt == 03 || nowSanctnSt == 04 || nowSanctnSt == 05 || nowSanctnSt == 06) {
                        $("#buttonDiv").hide();
                    }
                    
                    // 결재자 서명 조회
                    $.ajax({
                        url: "/sanction/getSanctnerSign",
                        method: "get",
                        data: userIdData,
                        dataType: 'json',
                        success: function(res){
                            console.log("결제자 서명: ", res);
                            let emplSignature = res.emplSignature;
                            
                            // 초기 문서 상세정보 로드
                            loadDocDetail();
                            
                            // 승인 버튼 클릭 이벤트
                            $("#allowBtn").on("click", function(){
                                let allowUpdateData = {
                                    userId: userId,
                                    docNo: docNo
                                };
                                console.log("allowUpdate: ", allowUpdateData);
                                
                                $.ajax({
                                    url: "/sanction/allowUpdate",
                                    method: "post",
                                    data: allowUpdateData,
                                    dataType: 'json',
                                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                                    success: function(res){
                                        if(res == 1) {
                                            // 결재 서명 업데이트
                                            var imgHtml = '<img src="data:image/png;base64,' + emplSignature + '" alt="Signature" />';
                                            $("#"+userId).html(imgHtml);
                                            
                                            // 전체 결재 박스의 서명 완료 여부 확인 후 최종 승인 처리
                                            var totalSignBoxCount = $(".signBox").length;
                                            var signedBoxCount = $(".signBox img").length;
                                            console.log("전체 결재 박스 수: ", totalSignBoxCount);
                                            console.log("서명된 결재 박스 수: ", signedBoxCount);
                                            
                                            // 모든 결재자가 승인 처리를 했을 때
                                            if(signedBoxCount === totalSignBoxCount) {
                                                console.log("모든 결재자가 서명을 마쳤습니다.");
                                                $.ajax({
                                                    url: "/sanction/allowFinalStatus",
                                                    method: "post",
                                                    data: docNoData,
                                                    dataType: 'json',
                                                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                                                    success: function(res){
                                                        if(res === 1) {
                                                            console.log("최종 승인 처리가 완료되었습니다.");
                                                            
                                                            // 연차일 때 히스토리 테이블 INSERT
                                                            if(dsCode == '01') {
                                                            	insertVacation();
                                                            }
                                                            
                                                            // 연장근무, 야간근무 결재시 히스토리 테이블 인서트
                                                            insertHistory(docNoData);
                                                            
                                                            // 사원 평가일 때
                                                            if(dsCode == '99') {
                                                            	let emplNoValue = $("#emplNoValue").text();
                                                            	let evalScore = $("#totalScore").text();
                                                            	let evalScoreStr = evalScore.split("점")[0];
                                                            	let evalSbj = $("#emplNo").text();
                                                            	
                                                        		let evalData = {
                                                        				evalSbj: evalSbj,
                                                        				emplObj: emplNoValue,
                                                        				evalScore: evalScoreStr,
                                                        		};
                                                        		console.log("evalData: ", evalData);
                                                        		insertEvaluation(evalData);
                                                        	}
                                                            
                                                        } else {
                                                            showToastMessage("최종 승인 처리 중 오류가 발생했습니다.", "danger");
                                                        }
                                                    },
                                                    error: function(){
                                                        showToastMessage("최종 승인 과정 중 오류가 발생했습니다.", "danger");
                                                    }
                                                });
                                            }
                                            
                                            // 서명이 반영된 문서 내용 업데이트
                                            let docContentHtml = $("#docContent").html();
                                            console.log("docContentHtml: ", docContentHtml);
                                            
                                            let signUpdateData = {
                                                docContent: docContentHtml,
                                                docNo: docNo
                                            };
                                            
                                            $.ajax({
                                                url: "/sanction/docSignUpdate",
                                                method: "post",
                                                data: signUpdateData,
                                                dataType: 'json',
                                                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                                                success: function(res){
                                                    if(res == 1) {
                                                        $("#buttonDiv").hide();
                                                        // 전체 페이지 새로고침 대신 loadDocDetail() 호출
                                                        loadDocDetail();
                                                    } else {
                                                        showToastMessage("문서 업데이트에 실패했습니다.", "danger");
                                                    }
                                                }
                                            });
                                        } else {
                                            showToastMessage("승인 처리 중 오류가 발생했습니다.", "danger");
                                        }
                                    }
                                });
                            }); // 승인 버튼 클릭 이벤트 종료
                            
                            // 전결 버튼 클릭 이벤트
                            $("#proxyBtn").on("click", function(){
                            	
                            	$("#buttonDiv").hide();
                            	
                                let proxyData = {
                                    docNo: docNo,
                                    sanctnFlow: nowSanctnFlow
                                };
                                
                                // 내 결재 정보는 05(전결)로, 이후 결재자들은 06(위임전결)로 업데이트
                                $.ajax({
                                    url: "/sanction/proxyUpdate",
                                    method: "post",
                                    data: proxyData,
                                    dataType: 'json',
                                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                                    success: function(proxyRes){
                                        console.log("proxy update res: ", proxyRes);
                                        
                                        // 본인 칸에 전결 도장 표시
                                        $("#"+userId).html('<img src="${pageContext.request.contextPath }/assets/img/etcsign/proxySign.png" alt="Signature" />');
                                        
                                        // 본인 외 다른 결재자 칸에 위임전결 도장 표시
                                        $(".signBox").each(function(){
                                            var boxId = $(this).attr("id");
                                            // 내 사원번호랑 태그 id 다른 칸들에 표시
                                            if (boxId != userId && $(this).find("img").length === 0) {
        								        $(this).html('<img src="${pageContext.request.contextPath }/assets/img/etcsign/delegateSign.png" alt="Signature" />');
        								    }
                                        });
                                        
                                        // 연차일 때 히스토리 테이블 INSERT 및 휴가 일 수 가감
                                        if(dsCode == '01') {
                             				insertVacation();
                                        }
                                        
                                     	// 사원 평가일 때
                                        if(dsCode == '99') {
                                        	let emplNoValue = $("#emplNoValue").text();
                                        	let evalScore = $("#totalScore").text();
                                        	let evalScoreStr = evalScore.split("점")[0];
                                        	let evalSbj = $("#emplNo").text();
                                        	
                                    		let evalData = {
                                    				evalSbj: evalSbj,
                                    				emplObj: emplNoValue,
                                    				evalScore: evalScoreStr,
                                    		};
                                    		console.log("evalData: ", evalData);
                                    		insertEvaluation(evalData);
                                    		
                                    		
                                    	}
                                        
                                        // 문서 상태 업데이트
                                        $.ajax({
                                            url: "/sanction/updateDocStatus",
                                            method: "post",
                                            data: docNoData,
                                            dataType: 'json',
                                            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                                            success: function(statusRes){
                                                if(statusRes == 1) {
                                                    let proxyDocContentUpdate = $("#docContent").html();
                                                    let proxyDocContentData = {
                                                        docNo: docNo,
                                                        docContent: proxyDocContentUpdate
                                                    };
                                                    $.ajax({
                                                        url: "/sanction/updateProxyDocContent",
                                                        method: "post",
                                                        data: proxyDocContentData,
                                                        dataType: 'json',
                                                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                                                        success: function(proxyContentRes){
                                                            // 전결 처리 후 변경된 정보를 다시 불러옴
                                                            loadDocDetail();
                                                        },
                                                        error: function(error){
                                                            showToastMessage("전결 후 문서 교체에 실패했습니다.", "danger");
                                                        }
                                                    });
                                                } else {
                                                    showToastMessage("문서 상태 최종업데이트 중 문제가 발생했습니다.", "danger");
                                                }
                                            }
                                        });
                                    },
                                    error: function(error){
                                        showToastMessage("전결 처리 중 오류가 발생했습니다.", "danger");
                                    }
                                });
                            }); // 전결 버튼 클릭 이벤트 종료
                            
                            // 반려 버튼 클릭 이벤트
                            $("#rejectBtn").on("click", function(){
                            	
                            	// 버튼 div 숨겨주기
                            	$("#buttonDiv").hide();
                            	
                            	// 본인 칸에 반려 도장 표시
                                $("#"+userId).html('<img src="${pageContext.request.contextPath }/assets/img/etcsign/rejectSign.png" alt="Signature" />');
                                console.log("반려버튼 userId: ", userId);
                                // 본인 외 다른 결재자 칸에 무효 도장 표시
                                $(".signBox").each(function(){
                                    var boxId = $(this).attr("id");
                                    // 내 사원번호랑 태그 id 다른 칸들에 표시
                                    if (boxId != userId && $(this).find("img").length === 0) {
								        $(this).html('<img src="${pageContext.request.contextPath }/assets/img/etcsign/afterReject.png" alt="Signature" />');
								    }
                                });
                            	
                            	// 결재자 상태 04(반려)로 업데이트
                            	let rejectData = {
                                        docNo: docNo,
                                        sanctnFlow: nowSanctnFlow
                                    };
                            	rejectEvent(rejectData);
                            	
                            });
                            
                        },
                        error: function(error){
                            showToastMessage("결제자 서명 조회에 오류가 발생했습니다.", "danger");
                        }
                    });
                }
            });
        }
    });
});

// 연장, 야간 히스토리 insert
function insertHistory(docNoData) {
	
	// 연장근무 신청서 등 dsCode에 따른 히스토리 테이블 삽입
    if(dsCode == '03' || dsCode == '04') {
        $.ajax({
            url: "/sanction/getWriterNo",
            method: "get",
            data: docNoData,
            dataType: 'json',
            success: function(writerRes) {
                console.log("기안자 사원번호: ", writerRes.writerNo);
                let writerNo = writerRes.writerNo;
                let hisType = (dsCode == '03') ? "01" : "02";
                
                // 일자, 시간 값 추출 (해당 요소의 id가 dateValue, timeValue)
                let dateRange = $("#dateValue").text();
                let timeRange = $("#timeValue").text();
                let [startDate, endDate] = dateRange.split(" - ");
                let [startTime, endTime] = timeRange.split(" - ");
                
                let overTimeData = {
                    emplNo: writerNo,
                    hisType: hisType,
                    hisSdate: startDate,
                    hisEdate: endDate,
                    hisStime: startTime,
                    hisEtime: endTime
                };
                console.log("overTimeData: ", overTimeData);
                
                $.ajax({
                    url: "/sanction/historyInsert",
                    method: "post",
                    data: JSON.stringify(overTimeData),
                    dataType: "json",
                    contentType: "application/json; charset=UTF-8",
                    success: function(histRes){
                        console.log("히스토리 테이블 인서트 res: ", histRes);
                        if(histRes == 1) {
                            console.log("히스토리 테이블 인서트 완료");
                        }
                    },
                    error: function(error) {
                        console.error("히스토리 테이블 인서트 실패:", error);
                        showToastMessage("히스토리 테이블 인서트 중 오류 발생", "danger");
                    }
                });
            }
        });
    }
	
} // insertHistory 종료 영역

// 사원 평가 시 데이터 인서트
function insertEvaluation(evalData) {
	$.ajax({
		url: "/sanction/insertEvaluation",
		method: "post",
		data: JSON.stringify(evalData),
		dataType: "json",
        contentType: "application/json; charset=UTF-8",
        success: function(evalRes) {
        	console.log("evalRes: ", evalRes);
        	if(evalRes == 1) {
        		console.log("사원 평가 데이터 삽입 성공");
        	} else {
        		showToastMessage("사원 평가 데이터 삽입 실패", "danger");
        	}
        }
	});
}

function insertVacation() {
	
	let emplNoForVac = $("#emplNo").text();
	let hisTypeForVac = '03';
	// 일자값 추출 (해당 요소의 id가 dateValue)
    let dateRange = $("#dateValue").text();
    let [startDate, endDate] = dateRange.split(" - ");
	
	let vacationData = {
			emplNo: emplNoForVac,
			hisType: hisTypeForVac,
			hisSdate: startDate,
            hisEdate: endDate,
	};
	
	console.log("vacationData: ", vacationData);
	
	$.ajax({
		url: "/sanction/insertVacationHistory",
		method: "post",
		data: JSON.stringify(vacationData),
		dataType: 'json',
		contentType: "application/json; charset=UTF-8",
		success: function(vacRes) {
			console.log("vacRes: " ,vacRes);
			
			if(vacRes == 1) {
				console.log("휴가 신청 히스토리 인서트 완료");
				// 일 수 가감 메소드 실행
				minusVacation(startDate, endDate);
			} else {
				showToastMessage("휴가 신청 히스토리 인서트 에러", "danger");
			}
		}
	});
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

// 휴가 결재 시 일 수 가감
function minusVacation(startDate, endDate) {
	// vacationData 객체에서 시작일과 종료일을 가져옴
	let startDateObj = new Date(startDate);
	let endDateObj = new Date(endDate);

	// 두 날짜의 차이를 밀리초 단위로 계산
	let diffTime = endDateObj - startDateObj;

	// 밀리초를 일(day) 단위로 변환 (1일 = 1000 * 60 * 60 * 24 밀리초)
	let diffDays = diffTime / (1000 * 60 * 60 * 24);

	console.log("diffDays: " + diffDays);  // 예시: 2가 출력됨
	
	let diffDaysInclusive = diffDays + 1;
	console.log("diffDaysInclusive: ", diffDaysInclusive);  // 예시: 3일이 출력됨
	
	let emplNoForVac = $("#emplNo").text();
	let dayCount = parseInt(diffDaysInclusive);
	
	let vacCountData = {
			emplNo: emplNoForVac,
			count: dayCount
	};
	
	$.ajax({
		url: "/sanction/calVacCount",
		method: "post",
		data: JSON.stringify(vacCountData),
		dataType: 'json',
		contentType: "application/json; charset=UTF-8",
		success: function(countRes) {
			console.log("countRes: ", countRes);
			if(countRes == 1) {
				console.log("연차 수 차감이 반영되었습니다.");
			} else {
				showToastMessage("연차 수 차감에 오류가 발생했습니다.", "danger");
			}
		}
	});
}

// 반려 버튼 클릭 이벤트
function rejectEvent(rejectData) {
	
	// 나와 나 이후의 결재자들의 결재상태를 반려로 업데이트
	$.ajax({
		url: "/sanction/rejectUpdate",
		method: "post",
		data: JSON.stringify(rejectData),
		dataType: 'json',
		contentType: "application/json; charset=UTF-8",
		success: function(res) {
			console.log("반려처리 res: ", res);
			
			// 문서 상태 03(반려)으로 업데이트
        	let rejectStatus = '03';
        	let rejectUpdtData = {
        			docNo: docNo,
        			status: rejectStatus
        	};
        	updtDocStatus(rejectUpdtData);
		}
	});
}

// 문서 상태 업데이트
function updtDocStatus(data) {
	
    $.ajax({
        url: "/sanction/updtDocStatus",
        method: "post",
        data: data,
        dataType: 'json',
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function(statusRes){
            if(statusRes == 1) {
            	console.log("statusRes: ", statusRes);
            	console.log("문서 상태가 업데이트 되었습니다.");
            	
            	// 문서 html 교체
            	let docContentUpdate = $("#docContent").html();
                let docContentData = {
                    docNo: docNo,
                    docContent: docContentUpdate
                };
            	replaceDocHtml(docContentData);
            	
            } else {
                showToastMessage("문서 상태(반려) 최종업데이트 중 문제가 발생했습니다.", "danger");
            }
        }
    });
}

// 문서 교체 업데이트
function replaceDocHtml(data) {
    
    $.ajax({
        url: "/sanction/replaceDocHtml",
        method: "post",
        data: data,
        dataType: 'json',
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function(res){
            if(res == 1) {
            	console.log("문서 교체가 완료되었습니다.");
            	
            	// 문서 교체 처리 후 변경된 정보를 다시 불러옴
                loadDocDetail();
                askForOpinion();
            	
            } else {
            	showToastMessage("문서 교체에 실패했습니다.", "danger");
            }
        },
        error: function(error){
            showToastMessage("문서 교체에 실패했습니다.", "danger");
        }
    });
}

// 문서 초기 로드
// 문서 상세 정보 조회 함수
function loadDocDetail() {
	
	// 참조자 영역 비워주기
	$("#refLine").empty();
	
    $.ajax({
        url: "/sanction/getApvDocDetail",
        method: 'get',
        data: docNoData,
        dataType: 'json',
        success: function(res){
            console.log("문서 상세 정보: ", res);
            
         	// 양식 코드 담기
			dsCode = res.dsCode;
            
            // 문서 기본정보 업데이트
            $("#docNo").html(res.docNo);
            $("#writer").html(res.writerNo);
            $("#docTitle").html(res.docTitle);
            
            if(res.docApv == '01') {
                docApv = "결재 중";
            } else if(res.docApv == '02') {
                docApv = "승인";
            } else if(res.docApv == '03') {
                docApv = "반려";
            }
            $("#docStatus").html(docApv);
            
            $("#submitDate").html(res.sanctnRqstdt);
            $("#expiredDate").html(res.docPeriod);
            
            if(res.dcrbAllow == 'Y') {
                dcrbAllow = "허용";
            } else if(res.dcrbAllow == 'N') {
                dcrbAllow = "불허";
            }
            
            if(dcrbAllow == "허용") {
            	$("#allowAt").html(`<span class=' badge badge-success-transparent'>\${dcrbAllow}</span>`);
            } else {
            	$("#allowAt").html(`<span class=' badge badge-pink-transparent'>\${dcrbAllow}</span>`);
            }
            
            // 사용자의 전결권 보유 여부 업데이트
            if(myEmplPosition != '01') {
                dcrbRight = "보유";
            } else {
                dcrbRight = "미보유";
            }
            
            if(dcrbAllow == '허용' && dcrbRight == '보유') {
            	if(res.aprRefList && res.aprRefList.length > 0) {
                    let lastApprover = res.aprRefList[res.aprRefList.length - 1];
                    console.log("lastApprover: ", lastApprover);
                    console.log("lastApprover.sanctnerRealNo: ", lastApprover.sanctnerRealNo);
                    console.log("userId###: ", userId);
                    
                    // 현재 결재자가 마지막 결재자가 아니면 전결 버튼을 보여줌
                    if(lastApprover.sanctnerRealNo !== userId) {
                        $("#proxyBtn").show();
                    } else {
                        $("#proxyBtn").hide(); // 마지막 결재자라면 전결 버튼 숨김
                    }
                }
			}
            
            if(dcrbRight == "보유") {
            	$("#myAllow").html(`<span class=' badge badge-success-transparent'>\${dcrbRight}</span>`);
            } else {
            	$("#myAllow").html(`<span class=' badge badge-pink-transparent'>\${dcrbRight}</span>`);
            }
            
            
            // 결재 선 출력
            if (res.aprRefList && res.aprRefList.length > 0) {
                var sanctionHtml = "";
                $.each(res.aprRefList, function(index, approver) {
                	
                	if(approver.sanctnStatus == '승인') {
                		sanctionHtml += "<div>(" + approver.sanctnerPosition + ") " + approver.sanctnerNo + " <span class=' badge badge-success-transparent'>" + approver.sanctnStatus + "</span></div>";
                	} else if(approver.sanctnStatus == '전결') {
                		sanctionHtml += "<div>(" + approver.sanctnerPosition + ") " + approver.sanctnerNo + " <span class=' badge badge-purple-transparent'>" + approver.sanctnStatus + "</span></div>";
                	} else if(approver.sanctnStatus == '열람') {
                		sanctionHtml += "<div>(" + approver.sanctnerPosition + ") " + approver.sanctnerNo + " <span class=' badge badge-info-transparent'>" + approver.sanctnStatus + "</span></div>";
                	} else if(approver.sanctnStatus == '위임 전결') {
             		sanctionHtml += "<div>(" + approver.sanctnerPosition + ") " + approver.sanctnerNo + " <span class=' badge badge-secondary-transparent'>" + approver.sanctnStatus + "</span></div>";
	             	} else if(approver.sanctnStatus == '결재 대기') {
	             		sanctionHtml += "<div>(" + approver.sanctnerPosition + ") " + approver.sanctnerNo + " <span class=' badge badge-dark-transparent'>" + approver.sanctnStatus + "</span></div>";
	             	} else if(approver.sanctnStatus == '반려') {
	             		sanctionHtml += "<div>(" + approver.sanctnerPosition + ") " + approver.sanctnerNo + " <span class=' badge badge-pink-transparent'>" + approver.sanctnStatus + "</span></div>";
	             	}
                	
                });
                $("#sanctionLine").html(sanctionHtml);
            }
            
            // 결재 일시
            let mySanctnDate = null;
            if (res.aprRefList && res.aprRefList.length > 0) {
              $.each(res.aprRefList, function(index, approver) {
                if (approver.sanctnerRealNo === userId) {
                  mySanctnDate = approver.sanctnDate;
                  return false; // 조건에 맞는 항목을 찾았으므로 반복 종료
                }
              });
            }
            console.log("내 sanctnDate:", mySanctnDate);
            
            if(mySanctnDate != null) {
            	$("#sanctnDate").html(mySanctnDate);
            } else {
            	$("#sanctnDate").html("결재 이전 상태입니다.");
            }
            
            
            
            // 참조자 출력
            renderReference(docNo);
            
            // 첨부 파일 출력
            let fileHtml = "";
            
            if(res.fileList != null && res.fileList.length > 0) {
            	for(let i = 0; i < res.fileList.length; i++){
            		fileHtml += `
                		<div><a href="/downloadFile?fileIdentify=\${res.fileList[i].fileIdentify}&fileNo=\${res.fileList[i].fileNo}">\${res.fileList[i].fileName}</a></div>
               		`;
           		}
            } else {
            	fileHtml = "첨부된 파일이 없습니다.";
            }
            
        	$("#docFileView").html(fileHtml);
            
            // 문서 내용 출력
            $("#docContent").html(res.docContent);
            
            if($("#docNoView").text() == "문서 번호:") {
            	$("#docNoView").append(" " + res.docNo);
            }
            
         	// 문서 상세 정보 업데이트 후, 결재자들의 처리 상태 확인
            if (res.aprRefList && res.aprRefList.length > 0) {
                var currentUserIndex = -1;
                // 현재 사용자의 결재자 목록에서의 인덱스 찾기 (예: sanctnerRealNo가 실제 사번)
                $.each(res.aprRefList, function(index, approver) {
                    if (approver.sanctnerRealNo === userId) {
                        currentUserIndex = index;
                        return false; // 찾으면 반복문 종료
                    }
                });
                
                // 만약 현재 사용자가 목록의 첫번째가 아니라면(즉, 이전 결재자가 있다면)
                if (currentUserIndex > 0) {
                    var allPreviousProcessed = true;
                    // 현재 사용자의 앞에 있는 결재자들의 상태 확인
                    for (var i = 0; i < currentUserIndex; i++) {
                        var status = res.aprRefList[i].sanctnStatus;
                        // 최종 처리된 상태는 '승인', '반려', '전결', '위임 전결'이라고 가정
                        if (status !== "승인" && status !== "반려" && status !== "전결" && status !== "위임 전결") {
                            allPreviousProcessed = false;
                            break;
                        }
                    }
                    // 이전 결재자 중 한 명이라도 처리되지 않았다면 버튼 영역을 숨김
                    if (!allPreviousProcessed) {
                        $("#buttonDiv").hide();
                    }
                }
            }
            
        },
        error: function(error){
            showToastMessage("문서 상세정보 호출에 오류가 발생했습니다.", "danger");
        }
    });
}

// 결재 의견 작성 체크 함수
function askForOpinion() {
  if (confirm("의견을 작성하시겠습니까?")) {
    // 확인을 클릭한 경우
    console.log("사용자가 의견 작성에 동의했습니다.");
    $("#opinionModal").modal("show");
    return true;
  } else {
    // 취소를 클릭한 경우
    console.log("사용자가 의견 작성을 취소했습니다.");
    return false;
  }
}

// 의견 작성 시 업데이트
$("#saveOpinion").on("click", function(){
	let opinionText = $("#opinionText").val();
	let opinionData = {
			userId : userId,
			docNo : docNo,
			sanctnOpinion : opinionText
	};
	console.log("opinionData: ", opinionData);
	
	$.ajax({
		url: '/sanction/updateOpinion',
		method: 'post',
		data: JSON.stringify(opinionData),
		contentType: "application/json; charset=UTF-8",
		success: function(res) {
			console.log("의견 작성 res: ", res);
			if(res > 0) {
				showToastMessage("의견 작성이 완료되었습니다.", "success");
				$("#opinionModal").modal("hide");
			} else {
				showToastMessage("의견 작성 중 오류가 발생했습니다.", "danger");
			}
		}
	});
});
</script>
</html>