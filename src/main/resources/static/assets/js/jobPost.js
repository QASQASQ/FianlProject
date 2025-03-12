$(document).ready(function () {

  // 검색 폼 제출 이벤트: 활성 탭에 따라 데이터 로드
  $("#searchForm").on("submit", function (event) {
    event.preventDefault();
    let searchWordValue = $("#searchForm input[name='searchWord']").val();
    console.log("🔎 검색 실행, 검색어:", searchWordValue);
    let activeTab = $('button[data-bs-toggle="tab"].active').attr("data-bs-target");
    if (activeTab === "#ongoing") {
      loadJobPostList(1, searchWordValue, "Y");
    } else if (activeTab === "#completed") {
      loadJobPostList(1, searchWordValue, "N");
    }
  });

  // 탭 전환 이벤트: 탭이 전환될 때 해당 탭의 데이터 로드
  $('button[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
    let target = $(e.target).attr("data-bs-target");
    console.log("탭 전환됨, target:", target);
    let searchWordValue = $("#searchForm input[name='searchWord']").val();
    if (target === "#ongoing") {
      loadJobPostList(1, searchWordValue, "Y");
    } else if (target === "#completed") {
      loadJobPostList(1, searchWordValue, "N");
    }
  });

  // 페이지 로드시 기본 탭(진행중 공고) 데이터 로드
  loadJobPostList(1, "", "Y");

  $("#jobPostForm").on("submit", function (event) {
    event.preventDefault();  // 기본 폼 제출 방지
    console.log("✅ 등록 버튼 클릭됨! 폼이 제출됩니다.");
    postJob();
  });

  // "기술항목 추가" 버튼 클릭 이벤트
  $("#addSortBtn").on("click", function () {
    addSortField();
  });
});

// status: "Y" = 진행중, "N" = 종료/완료 공고
function loadJobPostList(page = 1, searchWord = "", status = "Y") {
  $.ajax({
    url: "/hrms/recruit/jobPost/list",
    type: "POST",
    contentType: "application/json",
    data: JSON.stringify({ page: page, searchWord: searchWord, status: status }),
    dataType: "json",
    success: function (data) {
      // 각 탭 별 테이블 및 페이징 영역 선택
      let tbody, pagingContainer;
      if (status === "Y") {
        tbody = $("#ongoingTableBody");
        pagingContainer = $("#ongoingPagingArea");
      } else {
        tbody = $("#completedTableBody");
        pagingContainer = $("#completedPagingArea");
      }
      tbody.empty();

      if (!data.dataList || data.dataList.length === 0) {
        tbody.append("<tr><td colspan='6'>등록된 채용 공고가 없습니다.</td></tr>");
        pagingContainer.empty();
        return;
      }

      $.each(data.dataList, function (index, job) {
        let row = `
          <tr>
            <td class="text-start">${job.recTitle}</td>
            <td>${formatDate(job.recSdate)} ~ ${formatDate(job.recEdate)}</td>
            <td>${job.deptName}</td>
            <td>${job.positionName}</td>
            <td>${job.usageStatus}</td>
            <td><button class="btn btn-primary view-detail" data-rec-no="${job.recNo}" data-rec-usage="${status}" data-dept-code="${job.deptCode}" data-rec-position="${job.recPosition}">자세히 보기</button></td>
          </tr>
        `;
        tbody.append(row);
      });

      // 페이징 생성 (총 레코드수/10 기준)
      let totalPage = Math.ceil(data.totalRecord / 10);
      pagingContainer.empty();
      let btnHtml = `<ul class="pagination pagination-sm m-0 float-right">`;
      for (let i = 1; i <= totalPage; i++) {
        if (i == data.currentPage) {
          btnHtml += `<li class="page-item active"><span class="page-link" data-page="${i}" data-search-word="${searchWord}">${i}</span></li>`;
        } else {
          btnHtml += `<li class="page-item"><a href="#" class="page-link" data-page="${i}" data-search-word="${searchWord}">${i}</a></li>`;
        }
      }
      btnHtml += `</ul>`;
      pagingContainer.html(btnHtml);

      // 페이징 링크 클릭 이벤트
      pagingContainer.find("a, span.page-link").on("click", function (event) {
        event.preventDefault();
        let pageNo = $(this).data("page");
        loadJobPostList(pageNo, searchWord, status);
      });

      // 지원자 보기 버튼 이벤트
      $(".view-detail").on("click", function () {
        let recNo = $(this).data("rec-no");
        let recUsage = $(this).data("rec-usage");
        let deptCode = $(this).data("dept-code");
        let recPosition = $(this).data("rec-position");
        window.location.href = `/hrms/recruit?recNo=${recNo}&recUsage=${recUsage}&deptCode=${deptCode}&recPosition=${recPosition}`;
      });
    },
    error: function (xhr) {
      console.error("채용 공고 목록 불러오기 실패:", xhr.responseText);
    }
  });
}

function addSortField() {
  let sortList = $("#sortList");
  let newSortField = `
      <div class="input-group mb-2 sort-item">
          <input type="text" class="form-control tech-item" placeholder="기술항목 입력">
          <button type="button" class="btn btn-danger remove-sort-btn">삭제</button>
      </div>
  `;
  sortList.append(newSortField);
}

$(document).on("click", ".remove-sort-btn", function () {
  $(this).closest(".sort-item").remove();
});

function postJob() {
  console.log("✅ postJob 함수 실행됨!"); 
  let jobData = {
    recTitle: $("#recTitle").val(),
    deptCode: $("#deptCode").val(),
    recPosition: $("#recPosition").val(),
    recContent: $("#recContent").val(),
    recReq: $("#recReq").val(),
    recIdeal: $("#recIdeal").val(),
    recSdate: $("#recSdate").val(),
    recEdate: $("#recEdate").val(),
    recTarget: $("#recTarget").val(),
    recExp: $("#recExp").val(),
    recEssential: $("#recEssential").val(),
    recTreatment: $("#recTreatment").val(),
    recUsage: $("#recUsage").val(),
    sortList: []
  };

  $(".tech-item").each(function () {
    let techContent = $(this).val();
    if (techContent) {
      jobData.sortList.push({ sortContent: techContent });
    }
  });

  console.log("📡 서버로 전송할 데이터:", jobData);
  $.ajax({
    url: "/hrms/recruit/jobPost",
    type: "POST",
    contentType: "application/json",
    data: JSON.stringify(jobData),
    success: function () {
      showToastMessage("✅ 채용 공고가 성공적으로 등록되었습니다.", "success");
      $("#jobPostForm")[0].reset();
      $("#createRecruitModal").modal("hide");
      loadJobPostList();
    },
    error: function (xhr) {
      showToastMessage("❌ 채용 공고 등록에 실패 했습니다. ", "danger");
    }
  });
}

function formatDate(dateString) {
  if (!dateString) return "-";
  let date = new Date(dateString);
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}-${String(date.getDate()).padStart(2, "0")}`;
}

function showToastMessage(message, type = "primary") {
  let toast = $("#toastMessage");
  toast.removeClass("bg-primary bg-success bg-danger bg-warning");
  toast.addClass(`bg-${type}`);
  $("#toastBody").text(message);
  let toastInstance = new bootstrap.Toast(toast[0]);
  toastInstance.show();
}
