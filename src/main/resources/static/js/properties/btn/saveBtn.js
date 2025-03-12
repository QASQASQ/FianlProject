document.addEventListener("DOMContentLoaded", function() {
    const modal = document.getElementById("dataModal");
    const openModal = document.getElementById("appendBtn");
    const closeModal = document.querySelector(".close");
    const saveBtn = document.getElementById("saveData");

    // 모달 열기 (입력값 초기화)
    openModal.addEventListener("click", function() {
        document.getElementById("propName").value = "";
        document.getElementById("propContent").value = "";
        document.getElementById("propQty").value = "";
        document.getElementById("fileIdentify").value = "";
		document.getElementById("psCode").value = "";
        modal.style.display = "block";
    });

    // 모달 닫기
    closeModal.addEventListener("click", function() {
        modal.style.display = "none";
    });

    // 모달 밖 클릭 시 닫기
    window.addEventListener("click", function(event) {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    });

    // AJAX 저장
    saveBtn.addEventListener("click", function() {
        const data = {
            propNo: '',
            propName: document.getElementById("propName").value,
            propContent: document.getElementById("propContent").value,
            propQty: document.getElementById("propQty").value,
            fileIdentify: document.getElementById("fileIdentify").value,
            psCode: document.getElementById("psCode").value,
        };

        $.ajax({
            url: '/insert',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify([data]),
            success: function(response) {
                setTimeout('location.reload()', 1000);
                alert("새로운 데이터가 저장되었습니다.");
                modal.style.display = "none"; // 모달 닫기
            },
            error: function(error) {
                alert("데이터 저장 중 오류가 발생했습니다.");
            }
        });
    });
});