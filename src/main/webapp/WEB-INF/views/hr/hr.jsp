<%@page import="kr.or.ddit.hr.vo.EmployeeVO"%>
<%@page import="kr.or.ddit.hr.vo.TeamVO"%>
<%@page import="kr.or.ddit.hr.vo.DepartmentVO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
	<meta name="description" content="Smarthr - Bootstrap Admin Template">
	<meta name="keywords" content="admin, estimates, bootstrap, business, html5, responsive, Projects">
	<meta name="author" content="Dreams technologies - Bootstrap Admin Template">
	<meta name="robots" content="noindex, nofollow">
	<title>조직도</title>
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	
	<!-- 조직도 관련 땡겨와야 하는 것 2개.  -->
	<script src="https://uicdn.toast.com/tui-tree/latest/tui-tree.js"></script>
	<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui-tree/latest/tui-tree.css" />
	</head>

	<body>
		<div id="global-loader">
			<div class="page-loader"></div>
		</div>
	
		<script type="text/javascript">
		// 서버에서 데이터 불러오기
		const initialData = [
		    <% 
		    List<DepartmentVO> departments = (List<DepartmentVO>) request.getAttribute("departments");
	
		    for (DepartmentVO department : departments) { 
		    %>
		    {
		        text: '<%= department.getDeptName() %>',
		        children: [
		            <% for (TeamVO team : department.getTeams()) { %>
		            {
		                text: '<%= team.getTeamName() %>',
		            },
		            <% } %>
		        ]
		    },
		    <% 
		    } 
		    %>
		];
		</script>
		<!-- 부서 및 팀 관리 모달 : 해당없음 -->
		
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
				<div class="content p-0">
					<div class="d-md-flex">
						<div class="email-sidebar border-end border-bottom" style="width: 450px;">
							<div class="active slimscroll h-100">
								<div class="slimscroll-active-sidebar">					
									<div class="p-3">
										<!-- 해당없음 : 버튼 -->
										<div class="shadow-md bg-white rounded p-2 mb-4"">
											<div id="tree" class="tui-tree-wrap" style="background-color: white; width: 100%;">	
												<script>
											    // Toast UI Tree 초기화
											    var tree = new tui.Tree('#tree', {
											        data: initialData,
											        nodeDefaultState: 'opened',
											        showCheckbox: true,
											        template: {
											            internalNode:
											                '<div class="tui-tree-content-wrapper" style="padding-left: {{indent}}px">' +
											                    '<button type="button" class="tui-tree-toggle-btn tui-js-tree-toggle-btn">' +
											                        '<span class="tui-ico-tree"></span>' +
											                    '</button>' +
											                    '<span class="tui-tree-text tui-js-tree-text ">' +
											                        '<span class="tui-tree-ico tui-ico-folder"></span>' +
											                        '<span >{{text}}</span>' +
											                    '</span>' +
											                '</div>' +
											                '<ul class="tui-tree-subtree tui-js-tree-subtree" >{{children}}</ul>',
											
											            leafNode:
											                '<div class="tui-tree-content-wrapper" style="padding-left: {{indent}}px">' +
											                    '<span class="tui-tree-text tui-js-tree-text">' +
											                        '<span class="tui-tree-ico tui-ico-file"></span>' +
											                        '{{text}}' +
											                    '</span>' +
											                '</div>'
											        }
											    }).enableFeature('Selectable', {
											        selectedClassName: 'tui-tree-selected'
											    }).enableFeature('Checkbox', {
											        checkboxClassName: 'tui-tree-checkbox'
											    }).enableFeature('Editable', {
											        dataKey: 'text'
											    });
	    										</script>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="bg-white flex-fill border-end border-bottom mail-notifications">
							<div class="active slimscroll h-100">
								<div class="slimscroll-active-sidebar">	
									<div class="p-3">
										<div class="d-flex align-items-center justify-content-between flex-wrap row-gap-3">
											<div>
												<br/>
												<h3 class="mb-1" style="font-family: Pretendard-Regular; font-size: 25px; ">부서별 정보조회</h3>
												<br/>
												<div class="d-flex align-items-center">
													<span>팀 명 정보<input type="text" id="selectedValue" readonly class="form-control form-control-sm"/></span>
													<% session.setAttribute("selectedValue", request.getParameter("selectedValue")); %>
												</div>
											</div>
										</div>
									</div>
									<div class="bg-white flex-fill border-end border-bottom mail-notifications" style="width: 100%;">
									<!-- 리스트들 -->
									<script>
									<%
								    String selectedValue = request.getParameter("selectedValue");
								    if (selectedValue != null) {
								        session.setAttribute("selectedValue", selectedValue);
								    }
								%>
								</script>
								<!-- 부서 정보 표시 -->
								<p style="display: none;">선택된 부서: <strong id="selectedDepartment"><%= selectedValue != null ? selectedValue : "부서 없음" %></strong></p>

								<!-- 팀원 목록을 표시할 div 추가 -->
								<!-- 팀원 목록을 표시할 테이블 -->
								<section class="card-body p-0">
								    <div class="card-header border border-bottom-0 text-center">
								    </div>
								        <div class="col-md-12">
								            <div class="table datatable">
								                <table class="table table-bordered mb-0" style="text-align:center;">
								                    <thead class="thead-light">
								                        <tr>
								                            <th>사원명<br>( 사번 )</th>
								                            <th>부서</th>
								                            <th>팀</th>
								                            <th>직급</th>
								                            <th>이메일</th>
								                            <th>전화번호</th>
								                            <th>근무상태</th>
								                            <th>쪽지 발신</th>
								                        </tr>
								                    </thead>
								                    <tbody id="teamMemberTableBody">
								                        <tr>
								                            <td colspan="8" class="text-center">팀원을 선택하면 여기에 리스트가 표시됩니다.</td>
								                        </tr>
								                    </tbody>
								                </table>
								            </div>
								        </div>
								</section>
								<script>
								tree.on('select', function(eventData) {
								    var nodeData = tree.getNodeData(eventData.nodeId);
								    selectedValue.value = nodeData.text;

								    document.getElementById("selectedDepartment").innerText = nodeData.text;

								    var xhr = new XMLHttpRequest();
								    xhr.open("POST", "/hrms/hr/saveSelectedValue", true);
								    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
								    xhr.send("selectedValue=" + encodeURIComponent(nodeData.text));

								    fetchTeamMembers(nodeData.text);
								});
								</script>
								<script>
								function fetchTeamMembers(teamName) {
								    var xhr = new XMLHttpRequest();
								    xhr.open("GET", "/hrms/hr/members?teamName=" + encodeURIComponent(teamName), true);
								    xhr.setRequestHeader("Content-Type", "application/json");

								    xhr.onreadystatechange = function() {
								        if (xhr.readyState === XMLHttpRequest.DONE) {
								            if (xhr.status === 200) {
								                var teamMembers = JSON.parse(xhr.responseText);
								                console.log("받은 팀원 데이터:", teamMembers);
								                renderTeamMembers(teamMembers);
								            } else {
								                console.error("Error Team members:", xhr.status);
								            }
								        }
								    };
								    xhr.send();
								}
								</script>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- Footer -->
			<%@ include file="/WEB-INF/views/theme/footer.jsp" %>
			<!-- /Footer -->
		</div>
	</div>
	<!-- /Page Wrapper -->
	<!-- /Main Wrapper -->
	</body>
	<script>
	var util = {
	    addEventListener: function(element, eventName, handler) {
	        if (element.addEventListener) {
	            element.addEventListener(eventName, handler, false);
	        } else {
	            element.attachEvent('on' + eventName, handler);
	        }
	    }
	};
	</script>
	
	<script>
	var customInternalNode =
	    '<div class="tui-tree-content-wrapper tui-tree-root-btn" style="padding-left: {{indent}}px">' +
	        '<button type="button" class="tui-tree-toggle-btn tui-js-tree-toggle-btn">' +
	            '<span class="tui-ico-tree"></span>' +
	            '{{stateLabel}}' +
	        '</button>' +
	        '<span class="tui-tree-text tui-js-tree-text">' +
	            '{{text}}' +
	        '</span>' +
	    '</div>' +
	    '<ul class="tui-tree-subtree tui-js-tree-subtree">' +
	        '{{{children}}}' + // Mustache's format
	    '</ul>';

	var customLeafNode =
	    '<div class="tui-tree-content-wrapper tui-tree-root-btn" style="padding-left: {{indent}}px">' +
	        '<span class="tui-tree-text tui-js-tree-text">' +
	            '{{text}}' +
	        '</span>' +
	    '</div>';
	</script>
	<script>
	    var selectedValue = document.getElementById('selectedValue');
	    var rootNodeId = tree.getRootNodeId();
	    var firstChildId = tree.getChildIds(rootNodeId)[0];
	
	    tree.on('select', function(eventData) {
	        var nodeData = tree.getNodeData(eventData.nodeId);
	        selectedValue.value = '' + nodeData.text;
	
	        saveSelectedValueToSession(nodeData.text);
	    });
	
	    function saveSelectedValueToSession(selectedValue) {
	        var xhr = new XMLHttpRequest();
	        xhr.open("POST", "/saveSelectedValue", true);
	        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	        xhr.send("selectedValue=" + encodeURIComponent(selectedValue));
	    }
	
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function () {
		    let actionType = "";
		    
		    document.querySelectorAll("[data-action]").forEach(button => {
		        button.addEventListener("click", function () {
		            actionType = this.dataset.action;
		            document.querySelectorAll("#modalForm > div").forEach(div => div.style.display = "none");
		            
		            if (actionType === "addDepartment") {
		                document.getElementById("departmentForm").style.display = "block";
		                document.getElementById("departmentTeamModalLabel").textContent = "부서 추가";
		            } else if (actionType === "addTeam") {
		                document.getElementById("teamForm").style.display = "block";
		                document.getElementById("departmentTeamModalLabel").textContent = "팀 추가";
		            } else if (actionType === "delDepartment") {
		                document.getElementById("delDepartmentForm").style.display = "block";
		                document.getElementById("departmentTeamModalLabel").textContent = "부서 삭제";
		            } else if (actionType === "delTeam") {
		                document.getElementById("delTeamForm").style.display = "block";
		                document.getElementById("departmentTeamModalLabel").textContent = "팀 삭제";
		            }
		            
		            var modal = new bootstrap.Modal(document.getElementById("departmentTeamModal"));
		            modal.show();
		        });
		    });
		
		    document.getElementById("saveChangesBtn").addEventListener("click", function () {
		        let url = "";
		        let data = {};
		        
		        if (actionType === "addDepartment") {
		            url = "/hrms/hr/createDepartment";
		            data = {
		                deptCode: document.getElementById("deptCodeDepartment").value,
		                dprlr: document.getElementById("dprlr").value,
		                deptName: document.getElementById("deptName").value
		            };
		        } else if (actionType === "addTeam") {
		            url = "/hrms/hr/createTeam";
		            data = {
		                teamCode: document.getElementById("teamCode").value,
		                deptCode: document.getElementById("deptCodeTeam").value,
		                teamHeader: document.getElementById("teamHeader").value,
		                teamName: document.getElementById("teamName").value
		            };
		        } else if (actionType === "delDepartment") {
		            url = "/hrms/hr/deleteDepartment";
		            data = { deptCode: document.getElementById("delDepartmentCode").value };
		        } else if (actionType === "delTeam") {
		            url = "/hrms/hr/deleteTeam";
		            data = { teamCode: document.getElementById("delTeamCode").value };
		        }
		        
		        fetch(url, {
		            method: "POST",
		            headers: { "Content-Type": "application/json" },
		            body: JSON.stringify(data)
		        })
		        .then(response => {
		            if (response.ok) {
		                alert("작업이 성공적으로 완료되었습니다.");
		                location.reload();
		            } else {
		                alert("작업 실패");
		            }
		        })
		        .catch(error => console.error("Error:", error));
		    });
		});
	</script>
	
	<!-- 팀원 목록을 표시 -->
	<script>
	function renderTeamMembers(members) {
	    var tableBody = document.getElementById("teamMemberTableBody");
	    tableBody.innerHTML = ""; // 기존 데이터 초기화
	
	    if (members.length === 0) {
	        tableBody.innerHTML = `<tr><td colspan="8" class="text-center">해당 팀에 팀원이 없습니다.</td></tr>`;
	        return;
	    }
	
	    members.forEach(function(member) {
	        console.log("member.emplNm 이름:", member.emplNm);
	        console.log("member.emplPosition 포지션:", member.emplPosition);
	        console.log("member.emplNo 사번:", member.emplNo);
	        console.log("member.emplTelno :", member.emplTelno);
	        console.log("member.dclzType :", member.dclzType);
	        console.log("member:", member);
	
	        var row = `
	            <tr>
	                <td>\${member.emplNm} <br> ( \${member.emplNo} )</td>
	                <td>\${member.deptName || ''}</td>
	                <td>\${member.teamName || ''}</td>
	                <td>\${member.ccName || ''}</td>
	                <td>\${member.emplEmail || ''}</td>
	                <td>\${member.emplTelno || ''}</td>
	                <td>\${member.dclzType || ''}</td>
	                <td>
	                    <button class="btn btn-primary btn-sm me-2" onclick="sendMessage('\${member.emplNo}', '\${member.emplNm}')">
	                        쪽지 보내기
	                    </button>
	                </td>
	            </tr>
	        `;
	        tableBody.innerHTML += row;
	    });
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