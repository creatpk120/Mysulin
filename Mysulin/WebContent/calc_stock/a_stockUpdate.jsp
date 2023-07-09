<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Code"%>
<%@ page import="mysulin.Bean_Stock"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	int numb = Integer.parseInt(request.getParameter("numb"));
	Bean_Stock cBean = myMgr.getStock(numb);
%>

<html>
<head>
	<title>stockUpdate</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#F0F8FF" onLoad="regFrm.stock_date.focus()">
	<div align="center">
		<br/><br/>
		<form name="regFrm" method="post" action="a_stockUpdateProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td bgcolor="#F0F8FF" align="center" valign="middle">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr bgcolor="#6495ED" align="center">
								<td colspan="3"><font color="#FFFFFF"><b>재고 점검 내역 수정</b></font></td>
							</tr>
							<tr>
								<td>레코드번호</td>
								<td><input name="numb" size="15"
									value="<%=cBean.getNumb()%>" readonly></td>
							</tr>
							<tr>
								<td>담당자</td>
								<td><input name="stock_usid" size="15"
									value="<%=cBean.getStock_usid()%>" readonly></td>
							</tr>
							<tr>
								<td>재고점검일</td>
								<td><input type="date" name="stock_date" size="15"
									value="<%=cBean.getStock_date()%>"></td>
							</tr>
							<tr>
								<td>인슐린코드</td>
								<td><input name="stock_code" size="15"
									value="<%=cBean.getStock_code()%>"></td>
							</tr>
							<tr>
								<td>인슐린이름</td>
								<td><input name="stock_name" size="15"
									value="<%=cBean.getStock_name()%>"></td>
							</tr>
							<tr>
								<td>유통기한</td>
								<td><input type="date" name="stock_exp" size="15"
									value="<%=cBean.getStock_exp()%>"></td>
							</tr>
							<tr>
								<td>박스</td>
								<td><input name="stock_pack" size="15"
									value="<%=cBean.getStock_pack()%>"></td>
							</tr>
							<tr>
								<td>낱개</td>
								<td><input name="stock_piece" size="15"
									value="<%=cBean.getStock_piece()%>"></td>
							</tr>
							<%-- <tr>
								<td>총량</td>
								<td><input name="stock_total" size="15"
									value="<%=cBean.getStock_total()%>"></td>
							</tr> --%>
							<tr>
								<td>비고</td>
								<td><input name="stock_note" size="30"
									value="<%=cBean.getStock_note()%>"></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								<input type="submit" value="수정완료"> &nbsp;&nbsp; 
								<input type="button" value="재고삭제" onClick="location.href='a_stockDel.jsp?numb=<%=numb%>'"> &nbsp;&nbsp;
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