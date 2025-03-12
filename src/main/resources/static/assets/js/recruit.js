let globalRecruitList = [];
let globalRecUsage = "";
let globaldeptCode = "";
let globalrecPosition = "";

$(document).ready(function () {
    let searchForm = $("#searchForm");
    let pagingArea = $("#pagingArea");

    // 1) 검색 버튼 클릭 시
    searchForm.on("submit", function (event) {
        event.preventDefault(); 
        let searchWordValue = $("#searchForm input[name='searchWord']").val();
        console.log("🔎 검색 실행, 검색어:", searchWordValue);
        loadApplierList(1, searchWordValue);
    });

    // 2) 페이징 영역의 링크 클릭 시
    pagingArea.on("click", "a", function (event) {
        event.preventDefault();
        let pageNo = $(this).data("page");
        // data-search-word가 있으면 우선 사용, 없으면 폼의 값
        let searchWordValue = $(this).data("search-word") || $("#searchForm input[name='searchWord']").val();

        console.log("✅ 페이지 클릭됨, 페이지 번호:", pageNo, "검색어:", searchWordValue);
        loadApplierList(pageNo, searchWordValue);
    });

    // 페이지 진입 시 초기 목록 로딩 (원하면 추가)
    loadApplierList();


     // 평가와 코멘트 입력 시 평가 완료 버튼 활성화
     $(document).on("input change", "input[name='evaluation'], #evaluationComment", function () {
        let selectedEvaluation = $("input[name='evaluation']:checked").val();
        let comment = $("#evaluationComment").val().trim();

        if (selectedEvaluation && comment) {
            $("#completeEvaluation").prop("disabled", false);
        } else {
            $("#completeEvaluation").prop("disabled", true);
        }
    });

    // 평가 완료 버튼 클릭 시
    $("#completeEvaluation").click(function () {
        let appNo = $("#documentModal").data("appNo");
        let selectedEvaluation = $("input[name='evaluation']:checked").val();
        let comment = $("#evaluationComment").val().trim();

        if (!selectedEvaluation || !comment) {
            showToastMessage("❌ 평가와 코멘트를 모두 입력해주세요.", "danger");
            return;
        }

        let evaluationData = {
            appNo: appNo,
            appComment: comment,
            appValue: selectedEvaluation
        };

        // 평가 데이터 서버 전송
        $.ajax({
            url: "/hrms/recruit/evaluate",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(evaluationData),
            success: function () {
                showToastMessage("✅ 평가가 저장되었습니다.", "success");

                // 평가 후 즉시 비활성화 처리
                $("#evaluationComment").prop("disabled", true);
                $("input[name='evaluation']").prop("disabled", true);
                $("#completeEvaluation").hide();  // 평가 완료 버튼 숨김

                loadApplierList();  // 목록 새로고침
            },
            error: function () {
                showToastMessage("❌ 평가 저장에 실패했습니다.", "danger");
            }
        });
    });

});

function loadApplierList(page = 1, searchWord = "") {
    let urlParams = new URLSearchParams(window.location.search);
    let recNo = urlParams.get("recNo"); // 반드시 recNo가 있어야 함
    globalRecUsage = urlParams.get("recUsage");
    globaldeptCode = urlParams.get("deptCode"); 
    globalrecPosition = urlParams.get("recPosition"); 
    
    $.ajax({
        url: "/hrms/recruit/list", // 입사지원자 목록 조회 URL (매퍼의 id가 getRecruitList 인지 확인)
        type: "GET",
        data: { page: page, searchWord: searchWord, recNo: recNo, recUsage: globalRecUsage, deptCode: globaldeptCode, recPosition: globalrecPosition},
        dataType: "json",
        success: function (data) {
            console.log("입사지원자 응답 데이터:", data);

            if (!data || !data.dataList) {
                console.error("입사지원자 데이터가 없습니다:", data);
                $("#applierTableBody").html("<tr><td colspan='8'>데이터를 불러올 수 없습니다.</td></tr>");
                return;
            }

            renderApplierTable(data.dataList);
            // 페이징 처리도 별도로 진행 (필요하다면)
            renderPagination(data, searchWord); 
        },
        error: function (xhr, status, error) {
            console.error("입사지원자 목록 불러오기 실패:", xhr.responseText);
        }
    });
}

function renderApplierTable(list) {
    let tbody = $("#applierTableBody");
    tbody.empty();

    if (!list || list.length === 0) {
        tbody.append("<tr><td colspan='8'>입사지원자가 없습니다.</td></tr>");
        return;
    }

    $.each(list, function (index, applier) {
        // 조건 1) appAt === 'Y' → 이미 채용된 지원자
        let isHired = (applier.appAt === 'Y');

        // 조건 2) globalRecUsage === 'N' → 공고 자체가 이미 완료
        let isCompleted = (globalRecUsage === 'N');

        let isEvaluated = (applier.appValue !== null && applier.appValue !== "");

        // 버튼 HTML
        let hireButtonHtml = "";
        if (isHired || isCompleted) {
            // 이미 채용되었거나, 공고가 완료된 상태 → 비활성화
            hireButtonHtml = `<button class="btn btn-secondary" disabled>채용</button>`;
        } else if (isEvaluated) {
            hireButtonHtml = `<button class="btn btn-success hire-btn" 
                data-rec-no="${applier.recNo}" 
                data-app-nm="${applier.appNm}" 
                data-app-date="${applier.appDate}"
                data-rec-position="${globalrecPosition}"
                data-dept-code="${globaldeptCode}"
                data-app-email="${applier.appEmail}">
                채용
            </button>`;
        } else {
            hireButtonHtml = `<button class="btn btn-warning" disabled>평가 필요</button>`;
        }


        // "채용 여부" 표시 텍스트
        let appStatusText = (applier.appAt === 'Y') ? '채용' : '미채용';

        let row = `
            <tr>
                <td><input type="checkbox" class="select-row" data-app-no="${applier.appNo}" data-app-nm="${applier.appNm}" data-app-date="${applier.appDate}" /></td>
                <td>${applier.appNm}</td>
                <td>${applier.appDate ? formatDate(applier.appDate) : '-'}</td>
                <td>${applier.appTelno || '-'}</td>
                <td>${applier.appEmail || '-'}</td>
                <td>${appStatusText}</td>
                <td><button class="btn btn-primary view-application" data-app-no="${applier.appNo}">입사지원서</button></td>
                <td>${hireButtonHtml}</td>
            </tr>
        `;
        tbody.append(row);
    });


    // 입사지원서 보기 버튼 이벤트 처리
    $(document).on("click", ".view-application", function () {
        let appNo = $(this).data("app-no");
        console.log("✅ 입사지원서 보기 클릭됨! appNo:", appNo);

        // ⭐ 모달 열기 전 항상 초기화
        resetModalState();

        // ⭐ 모달에 appNo 데이터 저장
        $("#documentModal").data("appNo", appNo);

        // AJAX로 지원서 내용과 평가 데이터를 조회
        $.ajax({
            url: "/hrms/recruit/getApplierDoc",
            type: "GET",
            data: { appNo: appNo },
            success: function (applierData) {
                console.log("📄 지원서 데이터:", applierData);

                // 지원서 내용 표시
                $("#appDocumentContent").html(applierData.appDocument || "내용이 없습니다.");

                // 📌 평가 데이터가 있는 경우 입력란 비활성화
                if (applierData.appComment || applierData.appValue) {
                    $("#evaluationComment").val(applierData.appComment).prop("disabled", true);
                    $(`input[name='evaluation'][value='${applierData.appValue}']`).prop("checked", true).prop("disabled", true);
                    $("#completeEvaluation").hide();  // 평가 완료 버튼 숨김
                } else {
                    // 평가 데이터가 없는 경우 입력 가능 상태 유지
                    $("#evaluationComment").val("").prop("disabled", false);
                    $("input[name='evaluation']").prop("checked", false).prop("disabled", false);
                    $("#completeEvaluation").show().prop("disabled", true);
                }

                $("#documentModal").modal("show");  // 모달 표시
            },
            error: function (xhr) {
                showToastMessage("❌ 입사지원서 조회에 실패했습니다.", "danger");
            }
        });
    });

    // ⭐ 모달 상태 초기화 함수
    function resetModalState() {
        $("#evaluationComment").val("").prop("disabled", false);
        $("input[name='evaluation']").prop("checked", false).prop("disabled", false);
        $("#completeEvaluation").show().prop("disabled", true);
    }


}

function renderPagination(data, searchWord = "") {
    let pagingArea = $("#pagingArea");
    pagingArea.empty();

    // 서버에서 totalRecord를 넘겨준다고 가정
    let totalPage = Math.ceil(data.totalRecord / 10);
	let btn = `<ul class='pagination pagination-sm m-0 float-right'>`;
    for (let i = 1; i <= totalPage; i++) {
		if(i==data.currentPage){
			// 현재페이지가 i 와 같다면 이걸 추가
			btn += `<li class='page-item active'><span class="page-link" data-page="${i}" data-search-word="${searchWord}">${i}</span></li>`;
		}else{
	        // data-search-word 속성에 검색어를 저장
	        btn += `<li class='page-item'><a href="#" class="page-link" data-page="${i}" data-search-word="${searchWord}">${i}</a></li>`;
		}
    }
	btn += `</ul>`;
	pagingArea.html(btn);
}

function formatDate(dateString) {
    if (!dateString) return "-";
    let date = new Date(dateString);
    let year = date.getFullYear();
    let month = String(date.getMonth() + 1).padStart(2, "0");
    let day = String(date.getDate()).padStart(2, "0");
    return `${year}년 ${month}월 ${day}일`;
}

    $(document).on("click", ".hire-btn", function () {
        let recNo = $(this).data("rec-no");
        let appNm = $(this).data("app-nm");
        let appDate= $(this).data("app-date");
        let appEmail= $(this).data("app-email");
        let recPosition= $(this).data("rec-position");
        let deptCode= $(this).data("dept-code");
   

        $("#EMPL_NO").val("");
        $("#EMPL_PWD").val("");
        $("#POSITION").val(recPosition);
        $("#DEPARTMENT").val(deptCode);
        $("#HIRE_DATE").val(new Date().toISOString().split("T")[0]); 
        $(".role-checkbox").prop("checked", false);

        $("#hireModal").modal("show");

        $("#hireSubmit").data("recNo", recNo);
        $("#hireSubmit").data("appNm", appNm);
        $("#hireSubmit").data("appEmail", appEmail);
        $("#hireSubmit").data("appDate", appDate);
    });

    $("#hireSubmit").click(function (e) {
        e.preventDefault();
    
        let modalData = {
            EMPL_NO: $("#EMPL_NO").val(),
            EMPL_PWD: $("#EMPL_PWD").val(),
            POSITION: $("#POSITION").val(),
            DEPARTMENT: $("#DEPARTMENT").val(),
            HIRE_DATE: $("#HIRE_DATE").val(),
            AUTH: []
        };
    
        $(".role-checkbox:checked").each(function() {
            modalData.AUTH.push($(this).val());
        });
    
        let newHireData = {
            recNo: $(this).data("recNo"),
            appNm: $(this).data("appNm"),
            appEmail: $(this).data("appEmail"), 
            emplNo: modalData.EMPL_NO,
            emplPwd: modalData.EMPL_PWD,
            appDate: $(this).data("appDate"),
            POSITION: modalData.POSITION,
            DEPARTMENT: modalData.DEPARTMENT,
            hireDate: modalData.HIRE_DATE,
            auth: modalData.AUTH
        };
    
        let storedData = sessionStorage.getItem("hireData");
        let hireArray = storedData ? JSON.parse(storedData) : [];
    
        hireArray.push({
            이름: $(this).data("appNm"),
            이메일: $(this).data("appEmail"), 
            사원번호: modalData.EMPL_NO,
            비밀번호: modalData.EMPL_PWD,
            생년월일: $(this).data("appDate"),
            직위코드: modalData.POSITION,
            부서코드: modalData.DEPARTMENT,
            입사일자: modalData.HIRE_DATE,
            계정권한: modalData.AUTH
        });
    
        sessionStorage.setItem("hireData", JSON.stringify(hireArray));
    
        // ⭐ 채용 요청 + 합격 메일 전송
        $.ajax({
            url: "/hrms/recruit/hire",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(newHireData),
            success: function () {
                showToastMessage("✅ 채용이 완료되었으며, 합격 메일이 전송되었습니다!", "success");
                $("#hireModal").modal("hide");
                loadApplierList();
            },
            error: function (xhr) {
                showToastMessage("❌ 채용 시스템에 오류가 발생했습니다.", "danger");
            }
        });
    });    

    $("#downloadExcel").click(function (e) {
        e.preventDefault();
    
        let storedData = sessionStorage.getItem("hireData");
        if (!storedData) {
            showToastMessage("❌ 저장된 데이터가 없습니다.", "danger");
            return;
        }
    
        let hireArray = JSON.parse(storedData); // 배열 형태
    
        if (hireArray.length === 0) {
            showToastMessage("❌ 저장된 데이터가 없습니다.", "danger");
            return;
        }
    
        // 엑셀 헤더 (항목 고정)
        let headers = [
            "사원번호", "비밀번호", "사원명", "직위코드", "부서코드", "팀코드", "생년월일",
            "입사일자", "기본급여", "은행코드", "은행직원명", "계좌번호", "사원권한코드"
        ];
    
        // 데이터 정리 (비어 있는 데이터도 포함)
        let formattedData = hireArray.map(item => ({
            사원번호: item.사원번호 || "",  // 비어 있으면 공백 처리
            비밀번호: item.비밀번호 || "",
            사원명: item.이름 || "",
            직위코드: item.직위코드 || "",
            부서코드: item.부서코드 || "",
            팀코드: item.팀코드 || item.부서코드+"001",
            생년월일: item.생년월일 || "",
            입사일자: item.입사일자 || "",
            기본급여: item.기본급여 || "3000000",
            은행코드: item.은행코드 || "",
            은행직원명: item.은행직원명 || "",
            계좌번호: item.계좌번호 || "",
            사원권한코드: Array.isArray(item.계정권한) ? item.계정권한.join(",") : item.계정권한 || ""
        }));
    
        // 엑셀 시트 생성
        let worksheet = XLSX.utils.json_to_sheet(formattedData, { header: headers });
    
        // 스타일 적용 (헤더 Bold)
        let range = XLSX.utils.decode_range(worksheet["!ref"]);
        for (let C = range.s.c; C <= range.e.c; ++C) {
            let cellAddress = XLSX.utils.encode_col(C) + "1"; // 첫 번째 행 (헤더)
            if (worksheet[cellAddress]) {
                worksheet[cellAddress].s = { font: { bold: true } }; // 헤더 Bold 적용
            }
        }
    
        // 컬럼 너비 자동 조정
        worksheet["!cols"] = headers.map(() => ({ wch: 15 }));
    
        // 엑셀 파일 생성 및 다운로드
        let workbook = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(workbook, worksheet, "채용인원");
        XLSX.writeFile(workbook, "채용인원.xlsx");
    
        // 다운로드 후 세션 스토리지 삭제
        sessionStorage.removeItem("hireData");
    });


    // jsp 에 직접 추가하는경우 toast.addClass(`bg-\${type}`);
    // 토스트 메시지 표시 함수 (Bootstrap Toast)
    function showToastMessage(message, type = "primary") {
        let toast = $("#toastMessage");
        toast.removeClass("bg-primary bg-success bg-danger bg-warning");
        toast.addClass(`bg-${type}`);
        $("#toastBody").text(message);
        let toastInstance = new bootstrap.Toast(toast[0]);
        toastInstance.show();
    }