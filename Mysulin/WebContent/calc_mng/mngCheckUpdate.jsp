<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Mng_c"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	int numb = Integer.parseInt(request.getParameter("numb"));
	Bean_Mng_c uBean = myMgr.getMngCheck(numb);
%>

<html>
<head>
	<title>mngCheckUpdate</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#F0F8FF" onLoad="regFrm.m_date.focus()">
	<div align="center">
		<br/><br/>
		<form name="regFrm" method="post" action="mngCheckUpdateProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td bgcolor="#F0F8FF" align="center" valign="middle">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr bgcolor="#6495ED" align="center">
								<td colspan="3"><font color="#FFFFFF"><b>정산 확인 내역 수정</b></font></td>
							</tr>
							<tr>
								<td>레코드번호</td>
								<td><input name="numb" size="15"
									value="<%=uBean.getNumb()%>" readonly></td>
							</tr>
							<tr>
								<td>담당자</td>
								<td><input name="m_usid" size="15"
									value="<%=uBean.getM_usid()%>" readonly></td>
							</tr>
							<tr>
								<td>정산대상일</td>
								<td><input type="date" name="m_y_date" size="15"
									value="<%=uBean.getM_y_date()%>"></td>
							</tr>
							<tr>
								<td>정산실행일</td>
								<td><input type="date" name="m_t_date" size="15"
									value="<%=uBean.getM_t_date()%>"></td>
							</tr>
							<tr>
								<td>확인여부</td>
								<td><input name="m_check" size="15"
									value="<%=uBean.getM_check()%>" readonly></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								<input type="submit" value="수정완료"> &nbsp;&nbsp; 
								<input type="button" value="내역삭제" onClick="location.href='mngCheckDel.jsp?numb=<%=numb%>'"> &nbsp;&nbsp;
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