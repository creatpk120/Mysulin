<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% String cPath = request.getContextPath(); %>
<html>
<head>
	<title>mng_calc</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/>
		<h2>일일 정산</h2>
		<br/>

		<table align="center" width="800">
			<tr align="center" height="120%">
				<td width="32%" bgcolor="#D9E5FF" valign="middle">
					<br/><br/>
					<a href="<%=cPath%>/calc_stock/stockCheck.jsp?numb=0" target="content" onFocus="this.blur();">
					&nbsp;<img width="80%" src="../images/calc_stock.png" border="0"></a>
					<br/><br/><font size="3"><b>재고 등록</b></font><br/><br/>
				</td>
				<td width="2%"></td>
				<td width="32%" bgcolor="#D9E5FF" valign="middle">
					<br/><br/>
					<a href="<%=cPath%>/calc_usage/usageCheck.jsp?numb=0" target="content" onFocus="this.blur();">
					&nbsp;<img width="80%" src="../images/rx.png" border="0"></a>
					<br/><br/><font size="3"><b>처방 등록</b></font><br/><br/>
				</td>
				<td width="2%"></td>
				<td width="32%" bgcolor="#D9E5FF" valign="middle">
					<br/><br/>
					<a href="<%=cPath%>/calc_mng/mngCheck.jsp?numb=0" target="content" onFocus="this.blur();">
					&nbsp;<img width="80%" src="../images/report.png" border="0"></a>
					<br/><br/><font size="3"><b>정산 확인</b></font><br/><br/>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>