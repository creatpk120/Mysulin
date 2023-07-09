<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Code"%>
<%@ page import="mysulin.Bean_Stock_c"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	Bean_Stock_c cBean = myMgr.getStockC1(usid);
%>

<html>
<head>
	<title>stockCheckWrite</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function stock_inputCheck() {
		if(document.stockFrm.s_date.value == "") {
			alert("재고점검일을 선택해주세요.");
			document.stockFrm.s_date.focus();
			return;
		}
		document.stockFrm.action = "stockCheckWriteProc.jsp";
		document.stockFrm.submit();
	}
</script>
</head>

<body bgcolor="#F0F8FF" onLoad="stockFrm.s_date.focus()">
	<div align="center">
		<br/><br/>
		<form name="stockFrm" method="post" action="stockCheckWriteProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td bgcolor="#F0F8FF" align="center" valign="middle">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr bgcolor="#6495ED" align="center">
								<td align="center" colspan="3"><font color="#FFFFFF"><b>재고 점검 내역 등록</b></font></td>
							</tr>
							<tr>
								<td>담당자</td>
								<td><input name="s_usid" size="15" value="<%=usid%>" readonly></td>
							</tr>
							<tr>
								<td>재고점검일</td>
								<td><input type="date" name="s_date" size="15"></td>
							</tr>
							<tr>
								<td>점검여부</td>
								<td><input name="s_check" size="15" value="미완료" readonly></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
									<input type="button" value="내역등록" onClick="stock_inputCheck()"> &nbsp;&nbsp;
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