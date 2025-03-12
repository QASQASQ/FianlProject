$(document).ready(function () {
  $.ajax({
    url: "/session/user",
    type: "GET",
    success: function (userId) {
        console.log("로그인 된 ID:", userId);
        sessionStorage.setItem("userId", userId);  // ✅ 세션 스토리지에 저장
    },
    error: function (xhr, status, error) {
        console.error("❌ 세션 값을 가져오는데 실패:", xhr.responseText);
    }
  });
});