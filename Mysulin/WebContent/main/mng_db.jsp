<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% String cPath = request.getContextPath(); %>
<html>
<head>
	<title>mng_db</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/>
		<h2>데이터 관리</h2>
		<br/>

		<table align="center" width="800">
			<tr align="center" height="120%">
				<td width="32%" bgcolor="#D9E5FF" valign="middle">
					<br/><br/>
					<a href="<%=cPath%>/code/codeList.jsp" target="content" onFocus="this.blur();">
					&nbsp;<img width="80%" src="../images/mng_code.png" border="0"></a>
					<br/><br/><font size="3"><b>코드 데이터</b></font><br/><br/>
				</td>
				<td width="2%"></td>
				<td width="32%" bgcolor="#D9E5FF" valign="middle">
					<br/><br/>
					<a href="<%=cPath%>/calc_stock/a_stock.jsp" target="content" onFocus="this.blur();">
					&nbsp;<img width="80%" src="../images/mng_stock.png" border="0"></a>
					<br/><br/><font size="3"><b>재고 데이터</b></font><br/><br/>
				</td>
				<td width="2%"></td>
				<td width="32%" bgcolor="#D9E5FF" valign="middle">
					<br/><br/>
					<a href="<%=cPath%>/calc_usage/a_usage.jsp" target="content" onFocus="this.blur();">
					&nbsp;<img width="80%" src="../images/mng_usage.png" border="0"></a>
					<br/><br/><font size="3"><b>처방 데이터</b></font><br/><br/>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>