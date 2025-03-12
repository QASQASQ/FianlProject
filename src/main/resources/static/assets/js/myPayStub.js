$(function() {
  const payTableBody = $("#myPayTableBody");

  // ✅ 연도 및 월 데이터 초기화
  function initializeDateFilters() {
    const yearSelect = $("#yearSelect");
    const monthSelect = $("#monthSelect");
    const daySelect = $("#daySelect");

    const currentYear = new Date().getFullYear();
    for (let yearr = currentYear; yearr >= currentYear - 10; yearr--) {
        yearSelect.append(`<option value="${yearr}">${yearr}년</option>`);
    }
    for (let monthh = 1; monthh <= 12; monthh++) {
        monthSelect.append(`<option value="${monthh.toString().padStart(2, '0')}">${monthh}월</option>`);
    }
    for (let dayy = 1; dayy <= 31; dayy++) {
        daySelect.append(`<option value="${dayy.toString().padStart(2, '0')}">${dayy}일</option>`);
    }
  }

  // ✅ 로그인한 사용자의 급여 내역 조회
  function loadMyPayStubs(yearr = "", monthh = "", dayy = "") {
    $.ajax({
        url: "/hrms/payStub/mylist",
        type: "GET",
        data: { yearr: yearr, monthh: monthh, dayy: dayy },
        success: function(res) {
            let html = "";
            if (res.length === 0) {
                html = `<tr><td colspan="5">🔍 검색 결과가 없습니다.</td></tr>`;
            } else {
                res.forEach((pay) => {
                    html += `
                        <tr>
                            <td>${pay.payDate}</td>
                            <td>${formatPayDate(pay.payDate)}</td>
                            <td>${pay.totalPayment.toLocaleString()} 원</td>
                            <td>${pay.actualSalary.toLocaleString()} 원</td>
                            <td><button class="btn btn-primary btn-view-my-stub" data-empl-no="${pay.emplNo}" data-paydate="${pay.payDate}">급여 명세서</button></td>
                        </tr>`;
                });
            }
            payTableBody.html(html);
        },
        error: function() {
            showToastMessage("❌ 급여 내역을 불러오는 데 실패했습니다.", "danger");
        }
    });
  }

  // ✅ 검색 버튼 클릭 이벤트
  $("#searchBtn").on("click", function() {
    const yearr = $("#yearSelect").val();
    const monthh = $("#monthSelect").val();
    const dayy = $("#daySelect").val();
    loadMyPayStubs(yearr, monthh, dayy);
  });

  // ✅ 초기화 버튼 클릭 이벤트
  $("#resetBtn").on("click", function() {
    $("#yearSelect, #monthSelect, #daySelect").val("");
    loadMyPayStubs();
  });

  // ✅ 급여 명세서 (모달 재사용)
  $(document).on("click", ".btn-view-my-stub", function() {
      const emplNo = $(this).data("empl-no");

      $.ajax({
          url: `/hrms/payStub/view/${emplNo}`,
          type: "post",
          success: function(data) {
            console.log("data : " , data);
                const safeValue = (value) => value !== null && value !== undefined ? value.toLocaleString() : "0";

                $("#modalEmpName").text(data.EMPL_NM || "-");            
                $("#modalDeptName").text(data.DEPT_NAME || "-");          
                $("#modalPosition").text(data.POSITIONNAME || "-");   
                $("#modalBasicSalary").text(safeValue(data.BASIC_SALARY) + " 원");
                $("#modalOvertimePay").text(safeValue(data.OVERTIME_PAY) + " 원");
                $("#modalMealPay").text(safeValue(data.MEAL_PAY) + " 원");
                $("#modalBonus").text(safeValue(data.PS_BONUS) + " 원");
                $("#modalIncomeTax").text(safeValue(data.INCOME_TAX) + " 원");
                $("#modalLocalTax").text(safeValue(data.LOCAL_TAX) + " 원");
                $("#modalEmploymentInsurance").text(safeValue(data.EMPLOYMENT_INSURANCE) + " 원");
                $("#modalHealthInsurance").text(safeValue(data.HEALTH_INSURANCE) + " 원");
                $("#modalNursingInsurance").text(safeValue(data.NURSING_INSURANCE) + " 원");
                $("#modalNationalPension").text(safeValue(data.NATIONAL_PENSION) + " 원");
                $("#modalTotalPayment").text(safeValue(data.TOTAL_PAYMENT) + " 원");
                $("#modalActualSalary").text(safeValue(data.ACTUAL_SALARY) + " 원");
                $("#modalPayDate").text(data.PAYDATE || "-");

              new bootstrap.Modal(document.getElementById('payStubModal')).show();
          },
          error: function() {
              showToastMessage("❌ 급여 명세서를 불러올 수 없습니다.", "danger");
          }
      });
  });

  initializeDateFilters();
  loadMyPayStubs();
});

$("#downloadPdf").on("click", function () {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF('p', 'mm', 'a4');
  
    // 폰트 등록
    doc.addFileToVFS('malgun.ttf', _fonts);
    doc.addFont('malgun.ttf','malgun', 'normal');
    doc.setFont('malgun', 'normal');
  
    // ✅ 로고 이미지 추가 (좌측 상단)
    doc.addImage(_logo, 'PNG', 10, 3, 30, 30);

    // (1) 지급 예정일에서 연도와 월 추출
    const payDateStr = $("#modalPayDate").text();  // 예: "2023-02-19"
    let titleText = '급여명세서'; // 기본값
    if (payDateStr) {
      // 'YYYY-MM-DD' 구조이므로 split
      const [year, month] = payDateStr.split('-');
      // parseInt로 월 앞의 0 제거 (예: "02" -> 2)
      titleText = `${year}년 ${parseInt(month, 10)}월 급여명세서`;
    }
  
    // (2) 문서 제목
    doc.setFontSize(16);
    // A4 세로 기준, 가로 중앙 = 105
    doc.text(titleText, 105, 20, { align: 'center' });
  
    // (3) 사원 정보 테이블
    const empInfo = [
      ["부서", $("#modalDeptName").text(), "지급 예정일", $("#modalPayDate").text()],
      ["성명", $("#modalEmpName").text(), "직급", $("#modalPosition").text()],
    ];
    doc.autoTable({
      startY: 30,
      head: [['사원 정보', '', '지급 정보', '']],
      body: empInfo,
      theme: 'grid',
      headStyles: {
        fillColor: [30, 144, 255],
        textColor: 255,
      },
      columnStyles: {
        1: { cellWidth: 40 },
        3: { cellWidth: 40 },
      },
      styles: {
        font: 'malgun',
        fontSize: 12,
        lineColor: 200,
        lineWidth: 0.1,
      },
      margin: { left: 15, right: 15 },
    });
  
    // (4) 지급/공제 내역 테이블
    const payData = [
      ["기본급", $("#modalBasicSalary").text(), "소득세", $("#modalIncomeTax").text()],
      ["시간 외 수당", $("#modalOvertimePay").text(), "지방세", $("#modalLocalTax").text()],
      ["식대", $("#modalMealPay").text(), "고용보험", $("#modalEmploymentInsurance").text()],
      ["상여금", $("#modalBonus").text(), "건강보험", $("#modalHealthInsurance").text()],
      ["", "", "장기요양보험", $("#modalNursingInsurance").text()],
      ["", "", "국민연금", $("#modalNationalPension").text()],
    ];
    doc.autoTable({
      startY: doc.autoTable.previous.finalY + 10,
      head: [['지급 항목', '금액 (₩)', '공제 항목', '금액 (₩)']],
      body: payData,
      theme: 'grid',
      headStyles: {
        fillColor: [46, 134, 193],
        textColor: 255
      },
      columnStyles: {
        1: { halign: 'right' },
        3: { halign: 'right' },
      },
      styles: {
        font: 'malgun',
        fontSize: 12,
        lineColor: 200,
        lineWidth: 0.1,
      },
      margin: { left: 15, right: 15 },
    });
  
    // (5) 총 지급액 & 실 지급액 강조
    const yPos = doc.autoTable.previous.finalY + 15;
    doc.setFontSize(12);
    doc.setTextColor(0, 0, 0);
    doc.text(`총 지급액: ${$("#modalTotalPayment").text()}`, 15, yPos);
  
    // 실 지급액 (오른쪽 정렬)
    const pageWidth = doc.internal.pageSize.getWidth();
    doc.setFontSize(15);
    doc.setTextColor(0, 0, 0);
    doc.text(
      `실 지급액: ${$("#modalActualSalary").text()}`,
      pageWidth - 15, // 오른쪽에서 15mm 여백
      yPos,
      { align: 'right' }
    );
  
    // (6) PDF 저장
    doc.save(titleText + '.pdf');
  });
  

  // ✅ 날짜 포맷 변환 함수
function formatPayDate(dateStr) {
    if (!dateStr) return "-";
    const [year, month] = dateStr.split('-');
    return `${year}년 ${parseInt(month, 10)}월 급여명세서`;
}