<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Schedule"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	int numb = Integer.parseInt(request.getParameter("numb"));
	Bean_Schedule sBean = myMgr.getSchedule(numb);	//입력자료 가져오기
%>

<html>
<head>
	<title>scheduleUpdate</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#F0F8FF" onLoad="regFrm.chart_numb.focus()">
	<div align="center">
		<br/><br/>
		<form name="regFrm" method="post" action="scheduleUpdateProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td bgcolor="#F0F8FF" align="center" valign="middle">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr bgcolor="#6495ED" align="center">
								<td colspan="3"><font color="#FFFFFF"><b>내원 일정 수정</b></font></td>
							</tr>
							<tr>
								<td>레코드 번호</td>
								<td><input name="numb" size="15"
									value="<%=sBean.getNumb()%>" readonly></td>
							</tr>
							<tr>
								<td>차트 번호</td>
								<td><input name="chart_numb" size="15"
									value="<%=sBean.getChart_numb()%>"></td>
							</tr>
							<tr>
								<td>환자 성명</td>
								<td><input name="chart_name" size="15"
									value="<%=sBean.getChart_name()%>"></td>
							</tr>
							<tr>
								<td>인슐린 코드</td>
								<td><input name="rx_code" size="15"
									value="<%=sBean.getRx_code()%>"></td>
							</tr>
							<tr>
								<td>인슐린 이름</td>
								<td><input name="rx_name" size="15"
									value="<%=sBean.getRx_name()%>"></td>
							</tr>
							<tr>
								<td>인슐린 처방량</td>
								<td><input name="rx_amnt" size="15"
									value="<%=sBean.getRx_amnt()%>"></td>
							</tr>
							<tr>
								<td>처방 일수</td>
								<td><input name="rx_date" size="15"
									value="<%=sBean.getRx_date()%>"></td>
							</tr>
							<tr>
								<td>다음 내원일</td>
								<td><input type="date" name="rx_next" size="15"
									value="<%=sBean.getRx_next()%>"></td>
							</tr>
							<tr>
								<td>비고</td>
								<td><input name="note" size="30"
									value="<%=sBean.getNote()%>"></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								<input type="submit" value="수정완료"> &nbsp;&nbsp; 
								<input type="reset" value="다시쓰기"> &nbsp;&nbsp; 
								<input type="button" value="일정삭제" onClick="location.href='scheduleDel.jsp?numb=<%=numb%>'"> &nbsp;&nbsp;
								<input type="button" value="신규일정" onClick="location.href='scheduleWrite.jsp'"> &nbsp;&nbsp;
								<input type="button" value="일정목록" onClick="history.go(-1)"></td>						
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>

</html>