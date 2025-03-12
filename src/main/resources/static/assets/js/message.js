/**
 * Messaging System Script
 *
 * 주요 기능:
 * 1. 쪽지 목록 로드 및 개수 업데이트 (받은쪽지, 보낸쪽지, 휴지통)
 * 2. 메시지 필터링 (내용, 날짜, 연도, 월별)
 * 3. 사원 검색 및 선택(쪽지 작성 시 수신자 지정)
 * 4. 쪽지 전송, 읽음 처리, 휴지통 이동, 복원, 삭제(개별 및 일괄)
 * 5. 모달 관련 UI 스타일 및 토스트 메시지 표시
 *
 * ※ 모든 DOM 관련 초기화 및 이벤트 바인딩은 하나의 $(document).ready() 내부에서 처리됨.
 */

// 사용자 ID (세션 스토리지에서 가져옴)
const userId = sessionStorage.getItem("userId");

$(document).ready(function () {
  /****************************
   * [초기 로드 및 필터링 설정]
   ****************************/
  
  // 기본 쪽지 목록(받은 쪽지) 로드 및 쪽지 개수 업데이트
  loadMessages("received");
  loadMessageCounts();

  // 전역 변수: 현재 필터 기준 (기본값: "content" - 내용 검색)
  let currentFilter = "content";

  // 기본: 내용 검색 컨테이너만 보이고, 날짜/연도/월 입력 컨테이너는 숨김 처리
  $("#contentSearchContainer").show();
  $("#datePickerContainer, #yearSelectContainer, #monthSelectContainer").hide();

  /****************************
   * [필터 관련 초기화]
   ****************************/

  // 1. 날짜 선택을 위한 datepicker 초기화
  $("#datePickerInput").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true,
    todayHighlight: true,
    language: 'ko'
  });

  // 2. 연도 선택을 위한 select 박스 구성 (현재 연도부터 10년 전까지)
  let currentYear = new Date().getFullYear();
  let startYear = currentYear - 10;
  $("#yearSelect").empty();
  for (let y = currentYear; y >= startYear; y--) {
    $("#yearSelect").append($("<option>", {
      value: y,
      text: y
    }));
  }
  $("#yearSelect").val(currentYear);

  // 3. 월 선택을 위한 select 박스 구성 (1월 ~ 12월)
  let currentMonth = new Date().getMonth() + 1; // getMonth()는 0부터 시작
  $("#monthSelect").empty();
  for (let m = 1; m <= 12; m++) {
    $("#monthSelect").append($("<option>", {
      value: m,
      text: m + "월"
    }));
  }
  $("#monthSelect").val(currentMonth);

  // 4. 필터 옵션 클릭 이벤트 (내용, 날짜, 연도, 월)
  $(".filter-option").on("click", function (e) {
    e.preventDefault();
    currentFilter = $(this).data("filter");

    // 선택된 필터에 따라 active 클래스 갱신
    $(".filter-option").removeClass("active");
    $(this).addClass("active");

    // 모든 입력 컨테이너 숨김 후, 선택한 필터에 맞는 컨테이너 표시
    $("#contentSearchContainer, #datePickerContainer, #yearSelectContainer, #monthSelectContainer").hide();
    if (currentFilter === "content") {
      $("#contentSearchContainer").show();
    } else if (currentFilter === "date") {
      $("#datePickerContainer").show();
    } else if (currentFilter === "year") {
      $("#yearSelectContainer").show();
    } else if (currentFilter === "month") {
      $("#monthSelectContainer").show();
    }
    // 필터 변경 시 현재 입력값으로 필터링 적용
    filterMessages();
  });

  // 5. 입력/선택 이벤트에 따른 필터링 실행
  $("#searchInput").on("input", function () {
    if (currentFilter === "content") filterMessages();
  });
  $("#datePickerInput").on("change", function () {
    if (currentFilter === "date") filterMessages();
  });
  $("#yearSelect").on("change", function () {
    if (currentFilter === "year") filterMessages();
  });
  $("#monthSelect").on("change", function () {
    if (currentFilter === "month") filterMessages();
  });

  // 6. 새로고침 버튼 클릭 시 모든 입력값 초기화 및 기본 필터(내용)로 전환
  $("#resetButton").on("click", function () {
    $("#searchInput").val("");
    $("#datePickerInput").val("");
    $("#yearSelect").val(currentYear);
    $("#monthSelect").val(currentMonth);

    $(".filter-option").removeClass("active");
    $('.filter-option[data-filter="content"]').addClass("active");
    currentFilter = "content";

    $("#contentSearchContainer").show();
    $("#datePickerContainer, #yearSelectContainer, #monthSelectContainer").hide();

    filterMessages();
  });

  // 7. 메시지 필터링 함수
  function filterMessages() {
    if (currentFilter === "content") {
      // 내용별 필터: 제목(h6)과 본문(p)에 검색어가 포함되어 있는지 확인
      let search = $("#searchInput").val().trim().toLowerCase();
      $(".emails-list .list-group-item").each(function () {
        let text = $(this).find("h6, p").text().toLowerCase();
        $(this).toggle(search === "" || text.indexOf(search) !== -1);
      });
    } else if (currentFilter === "date") {
      // 날짜별 필터: 메시지의 data-date (날짜 부분)와 선택한 날짜 비교
      let chosenDate = $("#datePickerInput").val().trim();
      $(".emails-list .list-group-item").each(function () {
        let msgDate = $(this).data("date");
        let msgDatePart = msgDate ? msgDate.toString().split("T")[0] : "";
        $(this).toggle(chosenDate === "" || msgDatePart === chosenDate);
      });
    } else if (currentFilter === "year") {
      // 연도별 필터: 메시지의 data-year와 선택한 연도 비교
      let chosenYear = $("#yearSelect").val();
      $(".emails-list .list-group-item").each(function () {
        let msgYear = $(this).data("year") ? $(this).data("year").toString() : "";
        $(this).toggle(chosenYear === "" || msgYear === chosenYear);
      });
    } else if (currentFilter === "month") {
      // 월별 필터: 메시지의 data-date에서 월 정보를 추출하여 비교
      let chosenMonth = $("#monthSelect").val();
      $(".emails-list .list-group-item").each(function () {
        let msgDate = $(this).data("date");
        if (!msgDate) {
          $(this).show();
        } else {
          let month = new Date(msgDate).getMonth() + 1;
          $(this).toggle(chosenMonth === "" || month == chosenMonth);
        }
      });
    }
  }

  /****************************
   * [쪽지 작성 & 사원 검색 관련]
   ****************************/

  // tagsinput 초기화 (수신자 입력 필드)
  $("#inputBox").tagsinput({
    confirmKeys: [13, 44], // 엔터(13)와 콤마(44) 입력 시 확정
    trimValue: true
  });

  // "추가" 버튼 클릭 시 사원 검색 모달 표시
  $("#openEmployeeSearch").on("click", function () {
    $("#employeeSelectionModal").modal("show");
    // ✅ 모든 체크박스 해제
    $("#employeeSelectionList input[type='checkbox']").prop("checked", false);
    
    // ✅ "전체 선택" 체크박스도 해제
    $("#selectAllEmployees").prop("checked", false);

    // 모달 백드롭 스타일 조정 (모달 위에 클릭 가능하도록)
    setTimeout(function () {
      $(".modal-backdrop").css({
        "z-index": "1049",
        "opacity": "0.5"
      });
      $("#employeeSelectionModal").css({
        "z-index": "1060",
        "pointer-events": "auto"
      });
    }, 200);
  });

  // 사원 검색 input에 입력 시 AJAX로 사원 목록 검색
  $("#searchEmployeeInput").on("input", function () {
    let query = $(this).val().trim();
    if (query === "") return;

    $.ajax({
      url: "/message/search",
      type: "GET",
      data: { query: query },
      success: function (data) {
        let $list = $("#employeeSelectionList");
        $list.empty();

        let currentReceivers = $("#receiverInput").val().split(",").filter(v => v.trim() !== "");

        if (data.length === 0) {
          $list.append("<tr><td colspan='4' class='text-center'>해당하는 사원이 없습니다.</td></tr>");
        } else {
          data.forEach(function (emp) {
            if (emp.emplNo === userId) return; // 자신의 정보는 제외

            let currentReceivers = $("#receiverInput").val().split(",").filter(v => v.trim() !== "");
            let isAlreadyAdded = currentReceivers.includes(emp.emplNo);
            let rowClass = isAlreadyAdded ? "text-muted bg-light disabled" : "";
            let cursorStyle = isAlreadyAdded ? "pointer-events: none;" : "cursor: pointer;";

            let row = `
              <tr class="employee-row ${rowClass}" style="${cursorStyle}" 
                  data-empl-no="${emp.emplNo}" 
                  data-empl-name="${emp.emplNm}">
                <td>
                 <input type="checkbox" class="form-check-input select-employee">
                </td>
                <td>${emp.deptName}</td>
                <td>${emp.emplNm}</td>
                <td>${emp.ccName}</td>
                <td>${emp.emplNo}</td>
              </tr>
            `;
            $list.append(row);
          });
        }
      },
      error: function () {
        showToastMessage("❌ 사원 검색 중 오류가 발생했습니다.", "danger");
      }
    });
  });

    // 사원 행 클릭 시 수신자 목록(tagsinput 및 숨겨진 input)에 추가
    $(document).on("click", ".employee-row:not(.disabled)", function (e) {
        // 체크박스 자체를 클릭한 경우에는 토글하지 않도록 처리
        if ($(e.target).is("input[type='checkbox']")) return;
        let checkbox = $(this).find(".select-employee");
        checkbox.prop("checked", !checkbox.prop("checked"));
    });
  

  // tagsinput에서 항목이 제거되면 숨겨진 수신자 input 업데이트
  $("#inputBox").on("itemRemoved", function (event) {
    let removedTag = event.item;
    let removedNo = removedTag.match(/\((\d+)\)$/)[1]; // 괄호 안의 사원번호 추출

    let receiverInput = $("#receiverInput");
    let currentReceivers = receiverInput.val().split(",").filter(v => v.trim() !== "");
    let updatedReceivers = currentReceivers.filter(no => no !== removedNo);
    receiverInput.val(updatedReceivers.join(","));
  });

  // 사원 검색 모달이 닫힐 때: 백드롭, 입력 필드, 리스트 초기화
  $("#employeeSelectionModal").on("hidden.bs.modal", function () {

     // ✅ 모든 체크박스 해제
     $("#employeeSelectionList input[type='checkbox']").prop("checked", false);
    
     // ✅ "전체 선택" 체크박스도 해제
     $("#selectAllEmployees").prop("checked", false);

    if (!$(".modal-backdrop").length) {
      $("<div class='modal-backdrop fade show'></div>").appendTo(document.body);
    }
    $("#compose-view").css("z-index", "1050");
    $("#searchEmployeeInput").val("");
    $("#employeeSelectionList").empty();
    // Bootstrap 모달 관련 스타일 초기화
    $("body").removeClass("modal-open");
    $(".modal-backdrop").remove();
  });

  // 여러 명 선택 후 추가 버튼 이벤트 (모달 내 체크박스 활용)
  $("#addSelectedEmployees").on("click", function () {
    let selectedEmployees = $(".select-employee:checked").closest(".employee-row");

    if (selectedEmployees.length === 0) {
      showToastMessage("⚠️ 추가할 사원을 선택하세요.", "warning");
      return;
    }

    let inputBox = $("#inputBox");
    let receiverInput = $("#receiverInput");
    let currentReceivers = receiverInput.val().split(",").filter(v => v.trim() !== "");

    selectedEmployees.each(function () {
      let emplNo = $(this).data("empl-no");
      let emplName = $(this).data("empl-name");

      if (!currentReceivers.includes(emplNo)) {
        inputBox.tagsinput("add", `${emplName} (${emplNo})`);
        currentReceivers.push(emplNo);
      }
    });

    receiverInput.val(currentReceivers.join(","));
    $("#employeeSelectionModal").modal("hide");
  });

  // "전체 선택" 체크박스 (사원 검색 모달 내)
  $("#selectAllEmployees").on("change", function () {
    $(".select-employee").prop("checked", this.checked);
  });

  // 쪽지 작성 모달 닫을 때, 사원 검색 모달도 함께 닫기 및 백드롭 제거
  $("#compose-close").click(function () {
    $("#compose-view").hide();
    $("#employeeSelectionModal").modal("hide");
    removeModalBackdrop();
  });

  /****************************
   * [쪽지 작성 모달 UI 조정]
   ****************************/

  // 쪽지 작성 버튼 클릭 시 모달 표시 및 하단 고정 스타일 적용
  $("#compose_mail").on("click", function () {
    var modal = new bootstrap.Modal(document.getElementById("compose-view"));
    modal.show();
  });

  $("#compose-view").on("show.bs.modal", function () {
    $(this).find(".modal-dialog").css({
        "position": "fixed",
        "bottom": "0",
        "left": "50%",
        "right": "auto",
        "top": "auto",
        "transform": "translateX(-50%) translateY(100%)",
        "opacity": "0",
        "width": "90%",        // 너비 설정
        "max-width": "600px",  // 최대 너비 설정
        "min-height": "200px"  // 최소 높이 설정
    });

    setTimeout(() => {
        $(this).find(".modal-dialog").css({
            "transform": "translateX(-50%) translateY(0)",
            "opacity": "1"
        });
    }, 10);
  });


  // 모달 닫힐 때 dialog 스타일 초기화
  $("#compose-view").on("hidden.bs.modal", function () {
     // ✅ 수신자 목록 초기화
     $("#inputBox").tagsinput("removeAll");
     $("#receiverInput").val(""); 
 
     // ✅ 입력 필드 초기화
     $("#messageContent").val("");
  });

  /****************************
   * [키보드, 체크박스, 일괄 처리]
   ****************************/

  // Esc 키 누를 시 모달 백드롭 제거
  $(document).on("keydown", function (e) {
    if (e.key === "Escape") {
      removeModalBackdrop();
    }
  });

  // 쪽지 목록 내 체크박스 선택 시 상단 일괄 처리 버튼 표시
  $(document).on("change", ".form-check-input", function () {
    let checkedCount = $(".form-check-input:checked").length;
    if (checkedCount > 0) {
      $(".bulk-actions-container").show();
    } else {
      $(".bulk-actions-container").hide();
    }
  });

  // 일괄 처리 버튼 클릭 시 (휴지통 이동, 복원, 삭제)
  $(document).on("click", ".bulk-action", function () {
    let actionType = $(this).data("action");
    let selectedMessages = getSelectedMessages();

    if (selectedMessages.length === 0) {
      showToastMessage("⚠️ 선택된 쪽지가 없습니다.", "warning");
      return;
    }

    let url = "";
    let method = "POST";
    let successMessage = "";
    let messageType = "";

    if (actionType === "delete") {
      url = "/message/bulk-delete";
      method = "DELETE";
      successMessage = "🗑 선택한 쪽지가 삭제되었습니다.";
      messageType = "danger";
    } else if (actionType === "restore") {
      url = "/message/bulk-restore";
      successMessage = "✅ 선택한 쪽지가 복원되었습니다.";
      messageType = "success";
    } else if (actionType === "trash") {
      url = "/message/bulk-trash";
      successMessage = "📌 선택한 쪽지가 휴지통으로 이동되었습니다.";
      messageType = "danger";
    }

    $.ajax({
      url: url,
      type: method,
      contentType: "application/json",
      data: JSON.stringify({ msgNos: selectedMessages, userId: userId }),
      success: function () {
        showToastMessage(successMessage, messageType);
        if (actionType === "delete") {
          loadMessages("trash");
        } else if (actionType === "restore") {
          loadMessages("received");
        } else {
          loadMessages("trash");
        }
        loadMessageCounts();
      },
      error: function () {
        showToastMessage("⚠️ 작업 중 오류가 발생했습니다.", "warning");
      }
    });
  });
});

/****************************
 * [쪽지 관련 기능 외부 함수]
 ****************************/

// 쪽지 개수 업데이트 (받은/보낸/휴지통)
function loadMessageCounts() {
  $.ajax({
    url: `/message/count/${userId}`,
    type: "GET",
    success: function (data) {
      $(".received-count").text(data.receivedCount);
      $(".sent-count").text(data.sentCount);
      $(".trash-count").text(data.trashCount);

      // 헤더 업데이트 (예: 받은쪽지함 제목 및 개수)
      updateHeader("received", data.receivedCount, data.receivedCount);
    },
    error: function () {
      console.error("❌ 쪽지 개수를 불러오는 중 오류 발생");
    }
  });
}

// 메시지 목록 로드 (type: received, sent, trash)
function loadMessages(type) {
  let url =
    type === "received"
      ? `/message/received/${userId}`
      : type === "sent"
      ? `/message/sent/${userId}`
      : `/message/trash/${userId}`;

  $.ajax({
    url: url,
    type: "GET",
    success: function (messages) {
      $(".emails-list").empty(); // 기존 목록 초기화

      let total = messages.length;
      let count =
        type === "received"
          ? messages.filter((msg) => !msg.readStatus).length
          : total;

      updateHeader(type, total, count);

      messages.forEach((msg) => {
        let senderName = msg.senderName || "알 수 없음";
        let receiverName = msg.receiverName || "알 수 없음";
        let displayName = type === "received" ? senderName : receiverName;
        let isSender = type === "sent" || (type === "trash" && msg.msgSender === userId);
        let year = new Date(msg.msgDate).getFullYear();
      
        // 복원 버튼은 휴지통에 있을 때만 보이도록 설정
        let restoreButtonStyle = type === "trash" ? "" : "style='display: none;'";

        // 내용 간략화
        let shortContent = msg.msgContent.length > 50 
            ? msg.msgContent.substring(0, 50) + "..." 
            : msg.msgContent;
      
        let item = `
          <div class="list-group-item border-bottom p-3" 
               data-msg-no="${msg.msgNo}" 
               data-type="${type}" 
               data-is-sender="${isSender}"
               data-date="${msg.msgDate}"
               data-year="${year}">
            <div class="d-flex align-items-center mb-2">
              <div class="form-check form-check-md d-flex align-items-center flex-shrink-0 me-2">
                <input class="form-check-input" type="checkbox">
              </div>
              <div class="d-flex align-items-center flex-wrap row-gap-2 flex-fill">
                <a href="javascript:void(0);" class="avatar bg-purple avatar-rounded me-2">
                  <span class="avatar-title">${displayName.charAt(0)}</span>
                </a>
                <div class="flex-fill">
                  <div class="d-flex align-items-start justify-content-between">
                    <div>
                      <h6 class="mb-1"><a href="javascript:void(0);">${displayName}</a></h6>
                      <span class="fw-semibold"><a href="javascript:void(0);">${shortContent}</a></span>
                    </div>
                    <div class="d-flex align-items-center">
                      <div class="dropdown">
                        <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        더보기
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end p-3">
                          <li><a class="dropdown-item rounded-1 open-message" href="javascript:void(0);">쪽지 열기</a></li>
                          <li><a class="dropdown-item rounded-1 move-to-trash" href="javascript:void(0);">휴지통으로 이동</a></li>
                          <li ${restoreButtonStyle}><a class="dropdown-item rounded-1 restore-message" href="javascript:void(0);">복원</a></li>
                          <li><a class="dropdown-item rounded-1 delete-message" href="javascript:void(0);">삭제</a></li>
                        </ul>
                      </div>
                      <span>&nbsp;&nbsp;${formatDateTime(msg.msgDate)}</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>`;
      
        $(".emails-list").append(item);
      });
      

      // 현재 선택된 탭에 active 클래스 추가
      $(".email-tags a").removeClass("active");
      $(".email-tags a:contains('" +
        (type === "received" ? "받은쪽지함" : type === "sent" ? "보낸쪽지함" : "휴지통") +
        "')").addClass("active");
    },
    error: function () {
      console.error(`❌ ${type} 쪽지 목록을 불러오는 중 오류 발생`);
    }
  });
}

// 받은쪽지함, 보낸쪽지함, 휴지통 탭 클릭 이벤트
$(document).on("click", ".email-tags a:contains('받은쪽지함')", function () {
  $(".email-tags a").removeClass("active");
  $(this).addClass("active");
  loadMessages("received");
});
$(document).on("click", ".email-tags a:contains('보낸쪽지함')", function () {
  $(".email-tags a").removeClass("active");
  $(this).addClass("active");
  loadMessages("sent");
});
$(document).on("click", ".email-tags a:contains('휴지통')", function () {
  $(".email-tags a").removeClass("active");
  $(this).addClass("active");
  loadMessages("trash");
});

// 휴지통으로 이동 처리
$(document).on("click", ".move-to-trash", function () {
  let messageElement = $(this).closest(".list-group-item");
  let msgNo = messageElement.data("msg-no");
  let type = messageElement.data("type");
  let isSender = type === "sent";

  $.ajax({
    url: `/message/${msgNo}/trash`,
    type: "POST",
    contentType: "application/json",
    data: JSON.stringify({ isSender: isSender }),
    success: function () {
      showToastMessage("📌 쪽지가 휴지통으로 이동되었습니다.", "warning");
      loadMessages("trash");
      loadMessageCounts();
    },
    error: function () {
      showToastMessage("⚠️ 휴지통 이동에 실패했습니다.", "danger");
    }
  });
});

// 쪽지 전송
$("#sendMessageBtn").click(function () {
  const receiverIds = $("#receiverInput").val();
  const msgContent = $("#messageContent").val().trim();

  if (!msgContent) {
    showToastMessage("⚠️ 쪽지 내용을 입력하세요.", "warning");
    return;
  }

  $.ajax({
    url: "/message/send",
    type: "POST",
    contentType: "application/json",
    data: JSON.stringify({
      msgSender: userId,
      receiverId: receiverIds,
      msgContent: msgContent
    }),
    success: function () {
      showToastMessage("✅ 쪽지가 전송되었습니다.", "success");
      $("#compose-view").modal("hide");

      setTimeout(() => {
        removeModalBackdrop();
      }, 300);

      loadMessageCounts();
    },
    error: function () {
      showToastMessage("⚠️ 쪽지 전송에 실패했습니다.", "danger");
      $("#compose-view").modal("hide");

      setTimeout(() => {
        removeModalBackdrop();
      }, 300);
    }
  });
});

// 모달 닫기 버튼 클릭 시 처리
$("#compose-close").click(function () {
  var modal = bootstrap.Modal.getInstance(document.getElementById("compose-view"));
  if (modal) {
    modal.hide();
  }
  removeModalBackdrop();
});

// 삭제된 쪽지 복원 처리
$(document).on("click", ".restore-message", function () {
  let messageElement = $(this).closest(".list-group-item");
  let msgNo = messageElement.data("msg-no");
  let isSender = messageElement.data("is-sender") === true;

  $.ajax({
    url: `/message/${msgNo}/restore`,
    type: "POST",
    contentType: "application/json",
    data: JSON.stringify({ isSender: isSender, userId: userId }),
    success: function () {
      showToastMessage("✅ 선택한 쪽지가 복원되었습니다.", "success");
      if (isSender) {
        loadMessages("sent");
      } else {
        loadMessages("received");
      }
      loadMessageCounts();
    },
    error: function () {
      showToastMessage("⚠️ 선택한 쪽지 복원에 실패했습니다.", "danger");
    }
  });
});

// 쪽지 삭제 관련 (삭제 확인 모달 사용)
let deleteMsgNo = null;
$(document).on("click", ".delete-message", function () {
  deleteMsgNo = $(this).closest(".list-group-item").data("msg-no");
  $("#deleteConfirmModal").modal("show");
});
$("#confirmDeleteBtn").click(function () {
  if (deleteMsgNo !== null) {
    $.ajax({
      url: `/message/${deleteMsgNo}/delete`,
      type: "DELETE",
      success: function () {
        showToastMessage("🗑 선택한 쪽지가 삭제되었습니다.", "danger");
        loadMessageCounts();
        $("#deleteConfirmModal").modal("hide");
      },
      error: function () {
        showToastMessage("⚠️ 선택한 쪽지 삭제에 실패했습니다.", "danger");
      }
    });
  }
});

// 헤더 업데이트 (쪽지함 제목, 총 개수, 안읽은 개수 등)
function updateHeader(type, total, count) {
  let title = type === "received" ? "받은 쪽지함" : type === "sent" ? "보낸 쪽지함" : "휴지통";

  $(".total-messages").text(total);
  $(".unread-messages").text(`받은 쪽지 ${count}`);

  let countText =
    type === "received"
      ? `받은 쪽지 ${count}`
      : type === "sent"
      ? `보낸 쪽지 ${total}개`
      : `휴지통 ${total}개`;

  let headerElement = $("h5.mb-1");
  headerElement.html(`
    <div class="d-flex justify-content-between align-items-center">
      <span>${title}</span>
      <div class="dropdown ms-2 bulk-actions-container" style="display: none;">
        <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown">
          <i class="ti ti-dots"></i>
        </button>
        <ul class="dropdown-menu dropdown-menu-end p-3">
          <li><a class="dropdown-item rounded-1 bulk-action" href="javascript:void(0);" data-action="trash">선택한 메시지 휴지통 이동</a></li>
          <li><a class="dropdown-item rounded-1 bulk-action" href="javascript:void(0);" data-action="restore">선택한 메시지 복원</a></li>
          <li><a class="dropdown-item rounded-1 bulk-action" href="javascript:void(0);" data-action="delete">선택한 메시지 삭제</a></li>
        </ul>
      </div>
    </div>
  `);

  $(".unread-messages").text(countText);
}

// 날짜/시간 포맷 (12시간제, AM/PM)
function formatDateTime(dateTime) {
  const date = new Date(dateTime);
  let hours = date.getHours();
  const minutes = date.getMinutes().toString().padStart(2, "0");
  const ampm = hours >= 12 ? "PM" : "AM";
  hours = hours % 12 || 12;
  return `${date.getFullYear()}년 ${date.getMonth() + 1}월 ${date.getDate()}일 ${ampm} ${hours}:${minutes}`;
}

// 더보기(dropdown) 버튼 클릭 시 부모 클릭 이벤트 전파 방지
$(document).on("click", ".dropdown-toggle", function (e) {
  e.stopPropagation();
});

// '쪽지 열기' 버튼 클릭 시 상세 모달 표시 및 읽음 처리
$(document).on("click", ".open-message", function (e) {
  e.stopPropagation();
  let msgNo = $(this).closest(".list-group-item").data("msg-no");
  $.ajax({
    url: `/message/${msgNo}/detail`,
    type: "GET",
    success: function (message) {
      let formattedContent = message.msgContent.replace(/\n/g, "<br>"); // ✅ 개행 처리
      $("#messageDetailModal #messageSender").text("보낸 사람: " + message.msgSender);
      $("#messageDetailModal #messageContent").text("내용: " + formattedContent);
      $("#messageDetailModal #messageDate").text("보낸 날짜: " + formatDateTime(message.msgDate));
      $("#messageDetailModal").modal("show");
      // 읽음 처리
      markMessageAsRead(msgNo);
    },
    error: function () {
      showToastMessage("❌ 쪽지 정보를 불러오는 데 실패했습니다.", "danger");
    }
  });
});

// 쪽지 항목 클릭 시 상세 모달 표시 (단, 체크박스나 드롭다운 버튼 등은 제외)
$(document).on("click", ".list-group-item", function (e) {
  if ($(e.target).closest(".dropdown-toggle, .move-to-trash, .restore-message, .delete-message").length) return;
  if ($(e.target).is(".form-check-input")) return;
  let msgNo = $(this).data("msg-no");
  $.ajax({
    url: `/message/${msgNo}/detail`,
    type: "GET",
    success: function (message) {
      $("#messageDetailModal .modal-title").text("쪽지 상세보기");
      $("#messageDetailModal #messageSender").text("보낸 사람: " + message.msgSender);
      $("#messageDetailModal #messageDate").text("보낸 날짜: " + formatDateTime(message.msgDate));
      $("#messageDetailModal #messageContent").text("내용: " + message.msgContent);
      $("#messageDetailModal").modal("show");
      markMessageAsRead(msgNo);
    },
    error: function () {
      showToastMessage("❌ 쪽지 정보를 불러오는 데 실패했습니다.", "danger");
    }
  });
});

// 쪽지 읽음 처리 함수
function markMessageAsRead(msgNo) {
  $.ajax({
    url: `/message/${msgNo}/read`,
    type: "POST",
    success: function () {
      loadMessageCounts();
      loadMessages("received");
    },
    error: function () {}
  });
}

// 모달 닫힐 때 modal-backdrop 제거 및 스크롤 복구 함수
function removeModalBackdrop() {
  if ($(".modal.show").length === 0) {
    $(".modal-backdrop").remove();
    $("body").removeClass("modal-open").css("overflow", "auto");
  }
}

// 토스트 메시지 표시 함수 (Bootstrap Toast)
function showToastMessage(message, type = "primary") {
  let toast = $("#toastMessage");
  toast.removeClass("bg-primary bg-success bg-danger bg-warning");
  toast.addClass(`bg-${type}`);
  $("#toastBody").text(message);
  let toastInstance = new bootstrap.Toast(toast[0]);
  toastInstance.show();
}

// 체크된 쪽지의 번호 배열 반환 (일괄 처리용)
function getSelectedMessages() {
  let selectedMsgNos = $(".form-check-input:checked")
    .map(function () {
      return $(this).closest(".list-group-item").data("msg-no");
    })
    .get();
  return selectedMsgNos;
}
