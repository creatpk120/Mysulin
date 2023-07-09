<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Order_c"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	Bean_Order_c cBean = myMgr.getOrderCheck(usid);
%>

<html>
<head>
	<title>orderCheckWrite</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function order_inputCheck() {
		if(document.orderFrm.o_y_date.value == "") {
			alert("발주일을 선택해주세요.");
			document.orderFrm.o_y_date.focus();
			return;
		}
		if(document.orderFrm.o_t_date.value == "") {
			alert("배송일을 선택해주세요.");
			document.orderFrm.o_t_date.focus();
			return;
		}
		document.orderFrm.action = "orderCheckWriteProc.jsp";
		document.orderFrm.submit();
	}
</script>
</head>

<body bgcolor="#F0F8FF" onLoad="orderFrm.o_y_date.focus()">
	<div align="center">
		<br/><br/>
		<form name="orderFrm" method="post" action="orderCheckWriteProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td bgcolor="#F0F8FF" align="center" valign="middle">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr bgcolor="#6495ED" align="center">
								<td align="center" colspan="3"><font color="#FFFFFF"><b>발주 내역 등록</b></font></td>
							</tr>
							<tr>
								<td>담당자</td>
								<td><input name="o_usid" size="15" value="<%=usid%>" readonly></td>
							</tr>
							<tr>
								<td>발주일</td>
								<td><input type="date" name="o_y_date" size="15"></td>
							</tr>
							<tr>
								<td>배송일</td>
								<td><input type="date" name="o_t_date" size="15"></td>
							</tr>
							<tr>
								<td>배송여부</td>
								<td><input name="o_check" size="15" value="미배송" readonly></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
									<input type="button" value="내역등록" onClick="order_inputCheck()"> &nbsp;&nbsp;
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