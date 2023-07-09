<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Order_c"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	int numb = Integer.parseInt(request.getParameter("numb"));
	Bean_Order_c uBean = myMgr.getOrderCheck1(numb);
%>

<html>
<head>
	<title>orderCheckUpdate</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#F0F8FF" onLoad="regFrm.o_y_date.focus()">
	<div align="center">
		<br/><br/>
		<form name="regFrm" method="post" action="orderCheckUpdateProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td bgcolor="#F0F8FF" align="center" valign="middle">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr bgcolor="#6495ED" align="center">
								<td colspan="3"><font color="#FFFFFF"><b>발주 내역 수정</b></font></td>
							</tr>
							<tr>
								<td>레코드번호</td>
								<td><input name="numb" size="15"
									value="<%=uBean.getNumb()%>" readonly></td>
							</tr>
							<tr>
								<td>담당자</td>
								<td><input name="o_usid" size="15"
									value="<%=uBean.getO_usid()%>" readonly></td>
							</tr>
							<tr>
								<td>발주일</td>
								<td><input type="date" name="o_y_date" size="15"
									value="<%=uBean.getO_y_date()%>"></td>
							</tr>
							<tr>
								<td>배송일</td>
								<td><input type="date" name="o_t_date" size="15"
									value="<%=uBean.getO_t_date()%>"></td>
							</tr>
							<tr>
								<td>배송여부</td>
								<td><input name="o_check" size="15"
									value="<%=uBean.getO_check()%>" readonly></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								<input type="submit" value="수정완료"> &nbsp;&nbsp; 
								<input type="button" value="내역삭제" onClick="location.href='orderCheckDel.jsp?numb=<%=numb%>'"> &nbsp;&nbsp;
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