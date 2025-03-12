/**
 * 
 */

//폼 표시 숨기기 버튼 이벤트 추가
document.getElementById('toggleDepartmentFormBtn').addEventListener('click', function() {
    const form = document.getElementById('createDepartmentForm');
    if (form.style.display === 'none') {
        form.style.display = 'block'; // 폼 표시
    } else {
        form.style.display = 'none'; // 폼 숨기기
    }
});

//폼 표시 숨기기 버튼 이벤트 추가
document.getElementById('toggleTeamFormBtn').addEventListener('click', function() {
    const form = document.getElementById('createTeamForm');
    if (form.style.display === 'none') {
        form.style.display = 'block'; // 폼 표시
    } else {
        form.style.display = 'none'; // 폼 숨기기
    }
});


// 삭제

//폼 표시 숨기기 버튼 이벤트 추가
document.getElementById('toggleTeamDelFormBtn').addEventListener('click', function() {
    const form = document.getElementById('delTeamForm');
    if (form.style.display === 'none') {
        form.style.display = 'block'; // 폼 표시
    } else {
        form.style.display = 'none'; // 폼 숨기기
    }
});


//폼 표시 숨기기 버튼 이벤트 추가
document.getElementById('toggleDepartmentDelFormBtn').addEventListener('click', function() {
    const form = document.getElementById('delDepartmentForm');
    if (form.style.display === 'none') {
        form.style.display = 'block'; // 폼 표시
    } else {
        form.style.display = 'none'; // 폼 숨기기
    }
});