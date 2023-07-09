<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String usid = (String)session.getAttribute("idKey");
%>

<html>
<head>
	<title>scheduleWrite</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function schedule_inputCheck() {
		if(document.scheduleFrm.chart_numb.value=="") {
			alert("차트 번호를 입력해주세요.");
			document.scheduleFrm.chart_numb.focus();
			return;
		}
		if(document.scheduleFrm.chart_name.value=="") {
			alert("환자 성명을 입력해주세요.");
			document.scheduleFrm.chart_name.focus();
			return;
		}
		if(document.scheduleFrm.rx_code.value=="") {
			alert("인슐린 코드를 입력해주세요.");
			document.scheduleFrm.rx_code.focus();
			return;
		}
		if(document.scheduleFrm.rx_name.value=="") {
			alert("인슐린 이름을 입력해주세요.");
			document.scheduleFrm.rx_name.focus();
			return;
		}
		if(document.scheduleFrm.rx_amnt.value=="") {
			alert("인슐린 처방량을 입력해주세요.");
			document.scheduleFrm.rx_amnt.focus();
			return;
		}
		if(document.scheduleFrm.rx_date.value=="") {
			alert("처방 일수을 입력해주세요.");
			document.scheduleFrm.rx_date.focus();
			return;
		}
		document.scheduleFrm.action="scheduleWriteProc.jsp";
		document.scheduleFrm.submit();
	}
</script>
</head>

<body bgcolor="#F0F8FF" onLoad="scheduleFrm.chart_numb.focus()">
	<div align="center">
		<br/><br/>
		<form name="scheduleFrm" method="post" action="scheduleWriteProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td bgcolor="#F0F8FF" align="center" valign="middle">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr bgcolor="#6495ED" align="center">
								<td align="center" colspan="3"><font color="#FFFFFF"><b>내원 일정 등록</b></font></td>
							</tr>
							<tr>
								<td>차트 번호</td>
								<td><input name="chart_numb" size="15"></td>
							</tr>
							<tr>
								<td>환자 성명</td>
								<td><input name="chart_name" size="15"></td>
							</tr>
							<tr>
								<td>인슐린 코드</td>
								<td><input name="rx_code" size="15"></td>
							</tr>
							<tr>
								<td>인슐린 이름</td>
								<td><input name="rx_name" size="15"></td>
							</tr>
							<tr>
								<td>인슐린 처방량</td>
								<td><input name="rx_amnt" size="15"></td>
							</tr>
							<tr>
								<td>처방 일수</td>
								<td><input name="rx_date" size="15"></td>
							</tr>
							<tr>
								<td>다음 내원일</td>
								<td><input name="rx_next" size="15"></td>
							</tr>
							<tr>
								<td>비고</td>
								<td><input name="note" size="30"></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
									<input type="button" value="일정등록" onClick="schedule_inputCheck()"> &nbsp;&nbsp;
									<input type="reset" value="다시쓰기"> &nbsp;&nbsp;
									<input type="button" value="뒤로가기" onClick = "history.go(-1)">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>