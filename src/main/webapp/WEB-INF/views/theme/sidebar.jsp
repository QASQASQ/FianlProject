<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:set var="admin" value="false"/>
<c:set var="manager" value="false"/>

<c:forEach var="empAuthVO" items="${emp.authList }">
	<c:if test="${empAuthVO.authCode eq 'ROLE_ADMIN' }">
		<c:set var="admin" value="true"/>
	</c:if>
	<c:if test="${empAuthVO.authCode eq 'ROLE_MANAGER' }">
		<c:set var="manager" value="true"/>
	</c:if>
</c:forEach>
<div class="sidebar" id="sidebar">
	<!-- Logo -->
	<div class="sidebar-logo">
		<a href="/hrms/cmm/index">
			<img src="/assets/img/logoStart.png" width="200px" height="100px" alt="Logo">
		</a>
	</div>
	<!-- /Logo -->
	<div class="sidebar-inner slimscroll" style="margin-top:20px;">
		<div id="sidebar-menu" class="sidebar-menu">
			
			<!-- 결재중, 기안중문서 표시하는곳 -->
			<div class="bg-white rounded p-2 mb-4 border">
			<ul style="list-style: none; padding: 0; margin: 0;">
			    <li id="sanLi" style="font-size: 15px; width: 160px; display: flex; align-items: center; justify-content: space-between; cursor:pointer;">
			        <span style="display: flex; align-items: center; gap: 5px;">
			            <i class="ti ti-calendar-star"></i>결재
			            <span id="mySancCount"></span>
			        </span>
			    </li>
			    <li id="docLi" style="font-size: 15px; width: 160px; display: flex; align-items: center; justify-content: space-between; cursor:pointer;">
			        <span style="display: flex; align-items: center; gap: 5px;">
			            <i class="ti ti-calendar-up"></i>기안
			            <span id="myDocCount"></span>
			        </span>
			    </li>
			</ul>
			</div>
			<!-- 결재중, 기안중문서 표시하는곳 -->
			<ul>
				<li>
					<ul>
						<%-- <li>
							${emp.authList[0].authCode }<br>
							${emp.authList[1].authCode }<br>
							${emp.authList[2].authCode }<br>
							${admin }가 트루면 어드민권한있음<br>
							${manager }가 트루면 매니저권한있음<br>
						</li> --%>
						<li class="submenu">
							<a href="javascript:void(0);">
								<i class="ti ti-file-time"></i><span>&nbsp;근태</span>
								<span class="menu-arrow"></span>
							</a>
							<ul>
								<li><a href="/hrms/attendance/page">출퇴근</a></li>
								<li><a href="/hrms/dclz/overtime/employee">연장근무</a></li>
								<li><a href="#">야간근무</a></li>
							</ul>
						</li>
						<li class="submenu">
							<a href="javascript:void(0);">
								<i class="ti ti-edit"></i><span>&nbsp;결재문서함</span>
								<span class="menu-arrow"></span>
							</a>
							<ul>
								<li><a href="/hrms/sanction/personalDocuments">기안문서</a></li>
								<li><a href="/hrms/sanction/requestedApvDocuments">결재문서</a></li>
								<li><a href="/hrms/sanction/referenceDocuments">참조문서</a></li>
							</ul>
						</li>
						<li>
							<a href="/hrms/payStub/myPage">
								<i class="ti ti-cash"></i><span>&nbsp;급여</span>
							</a>
						</li>
						<li class="submenu">
							<a href="javascript:void(0);">
								<i class="ti ti-hierarchy-3"></i><span>&nbsp;인사조직</span>
								<span class="menu-arrow"></span>
							</a>
							<ul>
								<li>
									<a href="/hrms/hr/hr">조직도</a>
								</li>
								<c:if test="${admin eq true }">
									<li>
										<a href="/hrms/hr/hrAdmin">조직도 관리</a>
									</li>
								</c:if>
								<li>
									<a href="/hrms/employee/employeeInfo">나의 인사카드 관리</a>
								</li>
							</ul>
						</li>
						<li class="submenu">
							<a href="javascript:void(0);">
								<i class="ti ti-heart-handshake"></i><span>&nbsp;대여</span>
								<span class="menu-arrow"></span>
							</a>
							<ul>
								<li>
									<a href="/hrms/prop/userProp">사내 물품대여</a>
								</li>
								<li>
									<a href="/hrms/prop/userRentalAll">나의 대여물품조회</a>
								</li>
								<c:if test="${admin eq true }">
									<li>
										<a href="/hrms/prop/propList">전체 물품관리</a>
									</li>
								</c:if>
							</ul>
						</li>
						<li class="submenu">
							<a href="javascript:void(0);">
								<i class="ti ti-school"></i><span>&nbsp;교육</span>
								<span class="menu-arrow"></span>
							</a>
							<ul>
								<li><a href="/hrms/education/user/userAllTrainingListSearch">사내교육 수강신청</a></li>
								<li><a href="/hrms/education/user/userMyTraining">수강중인 사내교육</a></li>
								<c:if test="${admin eq true }">
									<li><a href="/hrms/education/admin/adminAllTrainingListSearch">사내교육목록 관리</a></li>
								</c:if>
								<c:if test="${admin eq true }">
									<li><a href="/hrms/education/admin/adminAllTrainingApplication">교육신청자 관리</a></li>
								</c:if>
							</ul>
						</li>
						<li>
							<a href="/hrms/cal/viewCalendar">
								<i class="ti ti-layout-navbar"></i><span>&nbsp;일정관리</span>
							</a>
						</li>
						<li>
							<a href="/hrms/vacation/page">
								<i class="ti ti-calendar-event"></i><span>&nbsp;휴가</span>
							</a>
						</li>
						
						<li class="submenu">
							<a href="javascript:void(0);">
								<i class="ti ti-speakerphone"></i><span>&nbsp;사내게시판</span>
								<span class="menu-arrow"></span>
							</a>
							<ul>
								<li><a href="/hrms/notice/noticeList">공지사항</a></li>
								<li><a href="/hrms/board/boardList">건의사항</a></li>
							</ul>
						</li>
						<li class="submenu">
							<a href="javascript:void(0);">
								<i class="ti ti-message-2"></i><span>&nbsp;커뮤니티</span>
								<span class="menu-arrow"></span>
							</a>
							<ul>
								<li><a href="/hrms/message">쪽지</a></li>
								<li><a href="/hrms/chat">채팅</a></li>
							</ul>
						</li>
						
						<!-- 인사권자 전용메뉴 -->
						<c:if test="${manager eq true }">
							<li class="submenu">
								<a href="javascript:void(0);">
									<i class="ti ti-users"></i><span>&nbsp;부서원 기록</span>
									<span class="menu-arrow"></span>
								</a>
								<ul>
									<li><a href="/hrms/attendance/authorityPage">출퇴근 기록</a></li>
									<li><a href="/hrms/dclz/overtime/authorityPage">초과근무 기록</a></li>
									<li><a href="/hrms/vacation/authorityPage">휴가 기록</a></li>
								</ul>
							</li>
						</c:if>
						
						<!-- 관리자 전용메뉴 -->
						<c:if test="${admin eq true }">
							<li class="submenu">
								<a href="javascript:void(0);">
									<i class="ti ti-layout-navbar"></i><span>&nbsp;관리자 메뉴</span>
									<span class="menu-arrow"></span>
								</a>
								<ul>
									<li><a href="/hrms/admin/employeeList">사원관리</a></li>
									<li><a href="/hrms/payStub">급여관리</a></li>
									<li><a href="/hrms/job">채용관리</a></li>
									<li><a href="/hrms/prom/promotion">승진관리</a></li>
									<li><a href="/hrms/admin/analytics">애널리틱스</a></li>
								</ul>
							</li>
						</c:if>
					</ul>
				</li>
				
				
			</ul>
		</div>
	</div>
</div>
<script>
let myDocCount = $("#myDocCount");
let mySancCount = $("#mySancCount");
let docLi = $("#docLi");
let sanLi = $("#sanLi");


$(function(){
	getDocumentCount();
	//setInterval(getDocumentCount, 10000); // 이거 주석풀어야 실시간으로 문서개수 가져옴
	
	docLi.on("click", function(){
		location.href="/hrms/sanction/personalDocuments";
	});
	sanLi.on("click", function(){
		location.href="/hrms/sanction/requestedApvDocuments";
	});
});

// 결재, 기안문서 가져오기
function getDocumentCount(){
	$.ajax({
		url : "/cmm/getDocumentCount",
		type : "post",
		data : JSON.stringify({emplNo:user}),
		contentType: "application/json;charset=utf-8",
		success : function(res){
			console.log("문서 가져오기 실행됨");
			myDocCount.text(res.doc);
			mySancCount.text(res.sanc);
		},
		error : function(error){}
	});
	
}

</script>