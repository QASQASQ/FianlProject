/**
 * 
 */
document.getElementById('delTeamBtn').addEventListener('click', function () {
    // 팀 코드 가져오기
    const teamCode = document.getElementById('delTeamCode').value.trim();

    // 유효성 검사: 빈 값 확인
    if (!teamCode) {
        alert('팀 코드를 입력해주세요.');
        return;
    }

    // DELETE 요청 전송
    fetch('/deleteTeam', {
        method: 'POST', // Controller에서 @PostMapping 사용 중이므로 DELETE 대신 POST 사용
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ teamCode: teamCode }) // 서버에서 JSON 형태로 받기 때문에 객체로 변환
    })
    .then(response => {
        if (response.ok) {
            alert('팀이 성공적으로 삭제되었습니다.');
            location.reload(); // 페이지 새로고침
        } else {
            return response.text().then(errorMessage => {
                alert(`팀 삭제 실패: ${errorMessage}`);
            });
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('서버와 통신 중 문제가 발생했습니다. 관리자에게 문의하세요.');
    });
});


document.getElementById('delDepartmentBtn').addEventListener('click', function () {
    // 팀 코드 가져오기
    const deptCode = document.getElementById('delDepartmentCode').value.trim();

    // 유효성 검사: 빈 값 확인
    if (!deptCode) {
        alert('부서 코드를 입력해주세요.');
        return;
    }

    // DELETE 요청 전송
    fetch('/deleteDepartment', {
        method: 'POST', // Controller에서 @PostMapping 사용 중이므로 DELETE 대신 POST 사용
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ deptCode: deptCode }) // 서버에서 JSON 형태로 받기 때문에 객체로 변환
    })
    .then(response => {
        if (response.ok) {
            alert('부서가 성공적으로 삭제되었습니다.');
            location.reload(); // 페이지 새로고침
        } else {
            return response.text().then(errorMessage => {
                alert(`부서 삭제 실패: ${errorMessage}`);
            });
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('서버와 통신 중 문제가 발생했습니다. 관리자에게 문의하세요.');
    });
});