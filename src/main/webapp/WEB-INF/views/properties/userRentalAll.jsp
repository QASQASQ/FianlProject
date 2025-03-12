<%@page import="java.util.Map"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib uri="jakarta.tags.core" prefix="c"  %>
<%@page import="kr.or.ddit.properties.vo.PropertiesVO"%>
<%@ page import="java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
	<meta name="description" content="Smarthr - Bootstrap Admin Template">
	<meta name="keywords" content="admin, estimates, bootstrap, business, html5, responsive, Projects">
	<meta name="author" content="Dreams technologies - Bootstrap Admin Template">
	<meta name="robots" content="noindex, nofollow">
	<title>물품대여</title>
</head>
<body>
<%
	List<Map<String, Object>> userRentalAll = (List<Map<String, Object>>) request.getAttribute("userRentalAll");          
%>
	<div id="global-loader">
		<div class="page-loader"></div>
	</div>
	
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
			</div>
			<!-- /Breadcrumb -->

				<!-- Leads List -->
				<div class="card">
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						<h5>내가 대여한 물품</h5>
						<div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
							<div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="text" class="form-control" placeholder="물품명" style="width: 100px;" id="emplNo">
								</div>
							</div>
							<input type="button" class="btn btn-primary d-flex align-items-center" value="검색" id="searchBtn">
						</div>
					</div>
					<div class="card-body p-0">
						<div class="custom-datatable-filter table-responsive">
							<table class="table datatable">
								<thead class="thead-light">
									<tr>
										<th class="text-center">물품 명</th>
										<th class="text-center">대여일시</th>
										<th class="text-center">반납예정일시</th>
										<th class="text-center">반납일시</th>
										<th class="text-center">반납여부</th>
									</tr>
								</thead>
								<%
								SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 원하는 형식
								%>
								
								<tbody>
								    <% if (userRentalAll != null && !userRentalAll.isEmpty()) { 
								        for (Map<String, Object> prop : userRentalAll) {
								            String epSdate = (prop.get("EP_SDATE") != null) ? sdf.format(prop.get("EP_SDATE")) : "";
								            String epEdate = (prop.get("EP_EDATE") != null) ? sdf.format(prop.get("EP_EDATE")) : "";
								            String epRdate = (prop.get("EP_RDATE") != null) ? sdf.format(prop.get("EP_RDATE")) : null;
								    %>
								    <tr>
								        <td class="text-center"><%= prop.get("PROP_NAME") %></td>
								        <td class="text-center"><%= epSdate %></td>
								        <td class="text-center"><%= epEdate %></td>
								        <td class="text-center">
								            <%= (epRdate != null) ? epRdate : "미반납" %>
								        </td>
								        <td class="text-center">
								            <% if (epRdate == null) { %>
								                <button class="btn btn-primary" onclick="returnItem('<%= prop.get("PROP_NO") %>')">반납하기</button>
								            <% } else { %>
								                반납완료
								            <% } %>
								        </td>
								    </tr>
								    <% 
								        } 
								    } 
								    %>
								</tbody>
							</table>
						</div>
					</div>
					<div id="pagingArea" style="display: flex; justify-content: center; align-items: center; padding:15px;">
					</div>
				</div>
				<!-- /Leads List -->
		</div>
		<!-- Footer -->
		<%@ include file="/WEB-INF/views/theme/footer.jsp" %>
		<!-- /Footer -->
		<!-- /Page Wrapper -->
	</div>
	<!-- /Main Wrapper -->

		<!-- 모달창들 -->
		<%@ include file="/WEB-INF/views/theme/modal.jsp" %>
		<!-- /모달창들 -->

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
	
	<script> 
     cleared[0] = cleared[1] = cleared[2] = 0; 
     function clearField(t){                  
	 	if(! cleared[t.id]) {                      
        	cleared[t.id] = 1;  
	        t.value='';         
	        t.style.color='#fff';
	    }
    }

	function returnItem(propNo) {
		showConfirmModal("정말 반납하시겠습니까?").then((isConfirmed) => {
			if (isConfirmed) {
				$.ajax({
					url: "/hrms/prop/returnItem",
					method: "POST",
					contentType: "application/json",
					data: JSON.stringify({ propNo: propNo }),
					success: function (response) {
						showToastMessage("✅ 반납이 완료되었습니다.", "success");
						setTimeout(() => {
                   			location.reload(); 
                		}, 1000);
					},
					error: function (xhr) {
						showToastMessage("❌ 반납 중 오류가 발생했습니다.", "danger");
					}
				});
			}
		});
	}	
</script>
</body>
</html>