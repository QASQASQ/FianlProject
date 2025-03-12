	const modal = document.querySelector('.modal');
	const btnOpenModal=document.querySelector('.btn-open-modal');
	const btnCloseModal = document.querySelector('.btn-close-modal');
	
	btnOpenModal.addEventListener("click", ()=>{
	    modal.style.display="flex";
	});
	
	btnCloseModal.addEventListener("click", () => {
		event.preventDefault(); // 버튼 클릭 시 폼 제출 방지
	    modal.style.display = "none";
		document.getElementById("employeeForm").reset();
	});
	
$(function(){
	let bulkSaveBtn = $("#bulkSaveBtn");
	
	bulkSaveBtn.on("click", function(event){
		event.preventDefault();	// 폼 제출 방지
		
		var formData = new FormData($('#bulkEmployeeForm')[0]);
		
		$.ajax({
			url: "/employee/bulkRegister",
			type: "post",
			data: formData,
			processData: false,	// 데이터를 문자열로 변환하지 않음
			contentType: false,	// multipart/form-data 형식으로 전송
			success: function(response) {
				alert("일괄 등록에 성공하였습니다.");
				location.reload(true);
			},
			error: function() {
				alert("일괄 등록에 오류가 발생했습니다.");
			}
		});
		
	});
	
	// 사원 권한 selecbox 목록 조회 시작
	
	$.ajax({
		url: "/employee/getAuthList",
		method: "get",
		dataType: "json",
		success: function(res){
			console.log("권한 목록: ", res);
			
			let authSelect = $(".authSelect");
			
			$.each(res, function(index, item) {
				console.log(`authCode: ${item.authCode}, authName: ${item.authName}`);
				authSelect.append(`<option value="${item.authCode}">${item.authName}</option>`);
            });
			
		},
		error: function(){
			alert("권한을 불러오지 못했습니다.");
		}
	});
	
	// 사원 권한 조회 끝
	
	// 권한 추가 버튼 클릭 시 기능 시작
	
	let addAuthBtn = $("#addAuthBtn");
			
	addAuthBtn.on("click", function(){
		
		event.preventDefault(); // 버튼 클릭 시 폼 제출 방지
		
		// 현재 추가된 select 개수 확인
	    if ($(".auth-wrapper").length >= 2) {
	        alert("최대 3개의 권한만 부여할 수 있습니다.");
	        return; // 추가 방지
	    }
        
		let newAuthWrapper = $("<div class='auth-wrapper input-group mb-2'></div>"); // select와 버튼을 감쌀 div 생성
        let newAuthSelect = $("#authSelect1").clone(); // 기존 select 복제
        newAuthSelect.removeAttr("id"); // 새로운 select의 id 제거 (중복 방지)
        
        let removeBtn = $("<button type='button' class='remove-auth btn btn-danger me-2'>삭제</button>"); // 취소 버튼 생성
        
     	// 취소 버튼 클릭 시 해당 select 제거
        removeBtn.on("click", function() {
            newAuthWrapper.remove();
        });
        
        newAuthWrapper.append(newAuthSelect).append(removeBtn); // div에 select와 버튼 추가
        $("#authContainer").append(newAuthWrapper); // 기존 컨테이너에 추가

	});
	
	// selectbox 직위 목록 조회 시작
	
	let position = "POSITION";
	let data = {position : position};
	console.log("직위 코드: ", position);
	
	let positionSelect = $("#positionSelect1");
	
	$.ajax({
		url: "/employee/getPositionCodes",
		method: "get",
		data: data,
		dataType: "json",
		contentType: "application/json; charset=UTF-8",
		success: function(res){
			console.log("res(직위 목록): ", res);
			
			$.each(res, function(index, item) {
				console.log(`ccCode: ${item.ccCode}, ccName: ${item.ccName}`);
				positionSelect.append(`<option value="${item.ccCode}">${item.ccName}</option>`);
            });
		}
	});
	
	// 직위 목록 조회 끝
	
	// select 박스 부서 목록 조회 시작
	
	$.ajax({
		url: "/employee/getDeptCodes",
		method: "get",
		dataType: "json",
		contentType: "application/json; charset=UTF-8",
		success: function(res){
			console.log("res: ", res);
			
			console.log("First Dept Code:", res[0].deptCode);
			
			let deptSelect = $("#deptCode1");
			
			$.each(res, function(index, item) {
				console.log(`deptCode: ${item.deptCode}, deptName: ${item.deptName}`);
                deptSelect.append(`<option value="${item.deptCode}">${item.deptName}</option>`);
            });
			
			// select 박스 부서 목록 조회 끝
			
			// select 박스에 선택된 부서 코드별로 해당 팀 목록 조회 시작
			
			let teamSelect = $("#teamCode1");
			
			deptSelect.on("change", function(){
				let deptCode = deptSelect.val();
				console.log("deptCode: ", deptCode);
				
				let data = {deptCode : deptCode};
				
				teamSelect.find("option:not(:first)").remove();
				
				$.ajax({
					url: "/employee/getTeamCodes",
					method: "get",
					data: data,
					dataType: "json",
					contentType: "application/json; charset=UTF-8",
					success: function(res){
						console.log("res: ", res);
						
						$.each(res, function(index, item) {
							teamSelect.append(`<option value="${item.teamCode}">${item.teamName}</option>`);
			            });
					}
				});
			});
			// select 박스 팀 목록 조회 끝
		}
	});
	
	// 은행 목록 조회 시작
	let bankSelect = $("#bankCode1");
	let bankCode = "BANKCODE";
	let bankCodedata = {bankCode : bankCode};
	
	$.ajax({
		url: "/employee/getBankCodes",
		method: "get",
		data: bankCodedata,
		dataType: "json",
		success: function(res) {
			console.log("은행 목록: ", res);
			
			$.each(res, function(index, item) {
				console.log(`ccCode: ${item.ccCode}, ccName: ${item.ccName}`);
				bankSelect.append(`<option value="${item.ccCode}">${item.ccName}</option>`);
            });
		}
	});
	
	// 사원 정보 insert 시작
	
	let saveBtn = $("#saveBtn");
	
	saveBtn.on("click", function(){
		
		let emplNo = $("#emplNo1").val();
		let emplPwd = $("#emplPwd1").val();
		let emplNm = $("#emplNm1").val();
		let emplPosition = $("#positionSelect1").val();
		let deptCodeVal = $("#deptCode1").val();
		let teamCodeVal = $("#teamCode1").val();
		let emplBrthdy = $("#emplBrthdy1").val();
		let hireDate = $("#hireDate1").val();
		let basicSalary = Number($("#basicSalary1").val());
		let bankCodeVal = $("#bankCode1").val();
		let bankName = $("#bankName1").val();
		let account = $("#account1").val();
		
		// 사원 권한
		let authVal = $(".authSelect").map(function() {
		    return $(this).val();
		}).get();
		console.log("권한 목록: " ,authVal);
		
		let insertData = {
				emplNo : emplNo,
				emplPwd : emplPwd,
				emplNm : emplNm,
				emplPosition : emplPosition,
				deptCode : deptCodeVal,
				teamCode : teamCodeVal,
				emplBrthdy : emplBrthdy,
				hireDate : hireDate,
				basicSalary : basicSalary,
				bankCode : bankCodeVal,
				bankName : bankName,
				account : account,
				authListStr : authVal
		}
		
		$.ajax({
			url: "/employee/register",
			method: "post",
			data: JSON.stringify(insertData),
			dataType: "json",
			contentType: "application/json; charset=UTF-8",
			success: function(){
				alert("사원이 정상적으로 등록되었습니다.");
				modal.style.display = "none";
				document.getElementById("employeeForm").reset();
				printList(1);
			},
			error: function(){
				alert("사원 등록에 실패하였습니다.");
				modal.style.display = "none";
			}
		});
		
	});
	
});	// $function 종료 영역