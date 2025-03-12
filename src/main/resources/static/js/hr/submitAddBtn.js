/**
 * 
 */

    
document.getElementById('submitDepartmentBtn').addEventListener('click', function() {
    const formData = {
        deptCode: document.getElementById('deptCodeDepartment').value,
        dprlr: document.getElementById('dprlr').value,
        deptName: document.getElementById('deptName').value
    };

    fetch('/createDepartment', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(formData)
    })
    .then(response => {
        if (response.ok) {
            alert('부서가 성공적으로 생성되었습니다.');
            location.reload();
        } else {
            alert('부서 생성에 실패했습니다.');
        }
    })
    .catch(error => console.error('Error:', error));
});




document.getElementById('submitTeamBtn').addEventListener('click', function() {
    const formData = {
        teamCode: document.getElementById('teamCode').value,
        deptCode: document.getElementById('deptCodeTeam').value,
        teamHeader: document.getElementById('teamHeader').value,
        teamName: document.getElementById('teamName').value
    };

    fetch('/createTeam', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(formData)
    })
    .then(response => {
        if (response.ok) {
            alert('팀이 성공적으로 생성되었습니다.');
            location.reload();
        } else {
            alert('팀 생성에 실패했습니다.');
        }
    })
    .catch(error => console.error('Error:', error));
});
