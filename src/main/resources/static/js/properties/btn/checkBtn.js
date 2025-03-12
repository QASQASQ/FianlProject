/**
 * 
 */

// 체크박스 선택 이벤트
 grid.on('check', (ev) => {
     if (!selectedRows.includes(ev.rowKey)) {
         selectedRows.push(ev.rowKey); // 선택된 rowKey 추가
         console.log(ev.rowKey);
     }
     console.log("현재 선택된 rowKeys:", selectedRows);
 });

	 // 체크박스 해제 이벤트
 grid.on('uncheck', (ev) => {
     selectedRows = selectedRows.filter((key) => key !== ev.rowKey); // 해제된 rowKey 제거
     console.log("현재 선택된 rowKeys:", selectedRows);
 }); 