<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% String cPath = request.getContextPath(); %>
<html>
<head>
	<title>orderPage_selectAgnt</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/>
		<h2>[발주] 제약회사 선택</h2>
		<br/>

		<table align="center" width="800">
			<tr align="center" height="120%">
				<td width="45%" bgcolor="#D9E5FF" valign="middle">
					<br/><br/>
					<a href="<%=cPath%>/order/orderPage_A.jsp" target="content" onFocus="this.blur();">
					&nbsp;<img width="80%" src="../images/Agnt_A.png" border="0"></a>
					<br/><br/><font size="3"><b>A 제약회사</b></font><br/><br/>
				</td>
				<td width="5%"></td>
				<td width="45%" bgcolor="#D9E5FF" valign="middle">
					<br/><br/>
					<a href="<%=cPath%>/order/orderPage_B.jsp" target="content" onFocus="this.blur();">
					&nbsp;<img width="80%" src="../images/Agnt_B.png" border="0"></a>
					<br/><br/><font size="3"><b>B 제약회사</b></font><br/><br/>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>