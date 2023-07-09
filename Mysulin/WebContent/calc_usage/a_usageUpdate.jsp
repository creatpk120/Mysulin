<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Usage_a"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	int numb = Integer.parseInt(request.getParameter("numb"));
	Bean_Usage_a uBean = myMgr.getUsage(numb);
%>

<html>
<head>
	<title>usageUpdate</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#F0F8FF" onLoad="regFrm.usage_date.focus()">
	<div align="center">
		<br/><br/>
		<form name="regFrm" method="post" action="a_usageUpdateProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td bgcolor="#F0F8FF" align="center" valign="middle">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr bgcolor="#6495ED" align="center">
								<td colspan="3"><font color="#FFFFFF"><b>처방 내역 수정</b></font></td>
							</tr>
							<tr>
								<td>레코드번호</td>
								<td><input name="numb" size="15"
									value="<%=uBean.getNumb()%>" readonly></td>
							</tr>
							<tr>
								<td>담당자</td>
								<td><input name="usage_usid" size="15"
									value="<%=uBean.getUsage_usid()%>" readonly></td>
							</tr>
							<tr>
								<td>처방일</td>
								<td><input type="date" name="usage_date" size="15"
									value="<%=uBean.getUsage_date()%>"></td>
							</tr>
							<tr>
								<td>인슐린코드</td>
								<td><input name="usage_code" size="15"
									value="<%=uBean.getUsage_code()%>"></td>
							</tr>
							<tr>
								<td>인슐린이름</td>
								<td><input name="usage_name" size="15"
									value="<%=uBean.getUsage_name()%>"></td>
							</tr>
							<tr>
								<td>처방량</td>
								<td><input name="usage_total" size="15"
									value="<%=uBean.getUsage_total()%>"></td>
							</tr>
							<tr>
								<td>비고</td>
								<td><input name="usage_note" size="15"
									value="<%=uBean.getUsage_note()%>"></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								<input type="submit" value="수정완료"> &nbsp;&nbsp; 
								<input type="button" value="재고삭제" onClick="location.href='a_usageDel.jsp?numb=<%=numb%>'"> &nbsp;&nbsp;
								<input type="button" value="뒤로가기" onClick="history.go(-1)"></td>						
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>

</html>