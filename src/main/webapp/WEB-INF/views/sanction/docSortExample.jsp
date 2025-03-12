<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
.info{
  font-weight: bold;
  width: 150px;
}
#detail{
  height: 300px;
}
td{
  height: 50px;
  text-align: center;
}
#remark{
  text-align: left;
}

.container {
            width: 300px;
            height: 400px;
            position: relative;
            border: 2px solid black;
        }
     
/* 실선 역할을 할 div */
.line {
    position: absolute;
    top: 33%;
    left: 5%;
    width: 100%;
    height: 1px;
    background-color: black;
}

</style>
<body>
<!-- 연차 신청 -->
<table border="1" cellpadding="1" cellspacing="1" style="width: 1000px; display: none;">
	<tbody>
		<tr>
			<td class="info" id="dept">부서</td>
			<td></td>
			<td class="info" id="emplPosition">직위</td>
			<td></td>
		</tr>
		<tr>
			<td class="info" id="emplNm">성명</td>
			<td></td>
			<td class="info" id="emplNo">사원번호</td>
			<td></td>
		</tr>
	</tbody>
</table> <br/>

<table border="1" cellpadding="1" cellspacing="1" style="width: 1000px;">
	<tbody>
		<tr>
			<td class="info" style="display: none">기간</td>
			<td style="display: none"></td>
		</tr>
		<tr>
			<td class="info">대체자 성명</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td class="info">사유</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td class="info" id="detail">세부 사항</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2">
			<p>&nbsp;</p>

			<p>상기한 사유로 휴가를 신청합니다.</p>

			<p>&nbsp;</p>

			<p>20 년 월 일</p>

			<p>&nbsp;</p>

			<p>신청자:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(인)</p>

			<p>&nbsp;</p>
			</td>
		</tr>
		<tr>
			<td colspan="2" id="remark">
			<p>&lt;비고&gt;</p>

			<p>&nbsp;</p>

			<p>&nbsp;</p>

			<p>&nbsp;</p>
			</td>
		</tr>
	</tbody>
</table>

<p>&nbsp;</p>


<div class="container">
	<div class="line"></div>
</div>

<table style="border-collapse:collapse;" border="2px" width="130px">
	<tr>
		<td id="forName"></td>
	</tr>
	<tr height="100px">
		<td id="forEmpNo"></td>
	</tr>
</table>

<table border="1">
	<tr>
		<td>문서 번호</td>
		<td>문서 번호링</td>
	</tr>
	<tr>
		<td>문서 번호</td>
		<td>문서 번호링</td>
	</tr>
</table>

<h1 style="display: none; font-size: 40px;">실적 보고서 평가</h1></hr>
<p style="display: none; margin-left: 54px;"></p>
<div id="aprDiv"></div>
<div>
<table border="1" cellpadding="1" cellspacing="1" style="width: 1000px; display: none;">
	<tbody>
		<tr>
			<td class="info">소속</td>
			<td id="dept"></td>
			<td class="info">직위</td>
			<td id="emplPosition" style="width: 230px;"></td>
		</tr>
		<tr>
			<td class="info">성명</td>
			<td id="emplNm"></td>
			<td class="info">사원번호</td>
			<td id="emplNo"></td>
		</tr>
	</tbody>
</table>
</div>

<p>&nbsp;</p>

<table border="1" cellpadding="1" cellspacing="1" style="width: 1000px; display: none;">
	<tbody>
		<tr>
			<td class="info" id="objEmplNo">대상자 사원번호</td>
			<td id="emplNoValue"></td>
			<td class="info" id="dateInfo">대상자 성명</td>
			<td id="emplNmValue"></td>
		</tr>
	</tbody>
</table>
<br/>
<table border="1" cellpadding="1" cellspacing="1" style="width: 1000px;">
	<tbody>
		<tr>
			<th>항목</th>
			<th>평가</th>
		</tr>
		<tr>
			<td class="evalSort">
				<div style="margin-left: 200px; text-align: left;">
			   <br/>1. 목표 달성도 (Achievement of Goals)<br/><br/>
				    ✅ 프로젝트가 초기 설정된 목표를 얼마나 달성했는가?<br/>
				    ✅ 정량적/정성적 성과 지표(KPI)와 비교하여 목표를 충족했는가?<br/>
				    ✅ 예상과 실제 결과 간의 차이는 무엇인가?<br/><br/>
			    </div>
			</td>
			<td class="evalScore" style="width: 100px;">우수</td>
		</tr>
		<tr>
			<td class="evalSort">
				<div style="margin-left: 200px; text-align: left;">
			   <br/>2. 데이터 정확성 및 신뢰성 (Data Accuracy &amp; Reliability)<br/><br/>
				    ✅ 보고서의 수치 및 데이터가 정확하고 신뢰할 수 있는 출처를 기반으로 작성되었는가?<br/>
				    ✅ 보고된 실적이 객관적인 자료(재무 데이터, 성과 지표 등)에 근거했는가?<br/>
				    ✅ 오류나 모호한 정보 없이 명확한 근거를 포함하고 있는가?<br/><br/>
			    </div>
			</td>
			<td class="evalScore" style="width: 100px;">우수</td>
		</tr>
		<tr>
			<td class="evalSort">
				<div style="margin-left: 200px; text-align: left;">
			   <br/>3. 데이터 정확성 및 신뢰성 (Data Accuracy &amp; Reliability)<br/><br/>
				    ✅ 보고서가 일관된 형식과 논리적 흐름을 갖추었는가?<br/>
				    ✅ 내용이 이해하기 쉽게 구성되었으며, 핵심 내용이 명확히 전달되는가?<br/>
				    ✅ 그래프, 표, 도표 등 시각적 자료가 적절하게 사용되었는가?<br/><br/>
			    </div>
			</td>
			<td class="evalScore" style="width: 100px;">우수</td>
		</tr>
		<tr>
			<td class="evalSort">
				<div style="margin-left: 200px; text-align: left;">
			   <br/>4. 문제 분석 및 해결방안 (Issue Analysis &amp; Solutions)<br/><br/>
				    ✅ 프로젝트 진행 중 발생한 문제점이 명확하게 기술되었는가?<br/>
				    ✅ 문제 발생 원인과 이에 대한 대응 조치가 적절하게 설명되었는가?<br/>
				    ✅ 향후 유사한 문제 발생을 방지할 방안이 포함되었는가?<br/><br/>
			    </div>
			</td>
			<td class="evalScore" style="width: 100px;">우수</td>
		</tr>
		<tr>
			<td class="evalSort">
				<div style="margin-left: 200px; text-align: left;">
				    <br/>5. 향후 개선점 및 제안 (Future Improvements &amp; Recommendations)<br/><br/>
				    ✅ 프로젝트를 기반으로 향후 개선할 사항이 명확히 도출되었는가?<br/>
				    ✅ 다음 프로젝트 진행 시 참고할 수 있는 실질적인 제언이 포함되었는가?<br/>
				    ✅ 성과를 극대화하기 위한 추가적인 전략이 제시되었는가?<br/><br/>
			    </div>
			</td>
			<td class="evalScore" style="width: 100px;">우수</td>
		</tr>
		<tr>
			<td colspan="2" id="remark" style="text-align: center;">
			<p style="font-weight: bold;">&lt;총점&gt;</p>

			<p>&nbsp;</p>

			<p id="totalScore">&nbsp;</p>

			<p>&nbsp;</p>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			<p>&nbsp;</p>

			<p>&nbsp;</p>

			<p>상기한 대상자의 평가를 승인 요청합니다.</p>

			<p id="submitDate"></p>

			<p>&nbsp;</p>

			<p>&nbsp;</p>

			</td>
		</tr>
	</tbody>
</table>
</body>
</html>