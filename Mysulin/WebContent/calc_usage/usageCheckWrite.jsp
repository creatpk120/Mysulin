<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Usage_c"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	Bean_Usage_c cBean = myMgr.getUsageCheck1(usid);
%>

<html>
<head>
	<title>usageCheckWrite</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function usage_inputCheck() {
		if(document.usageFrm.u_date.value == "") {
			alert("재고점검일을 선택해주세요.");
			document.usageFrm.u_date.focus();
			return;
		}
		document.usageFrm.action = "usageCheckWriteProc.jsp";
		document.usageFrm.submit();
	}
</script>
</head>

<body bgcolor="#F0F8FF" onLoad="usageFrm.u_date.focus()">
	<div align="center">
		<br/><br/>
		<form name="usageFrm" method="post" action="usageCheckWriteProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td bgcolor="#F0F8FF" align="center" valign="middle">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr bgcolor="#6495ED" align="center">
								<td align="center" colspan="3"><font color="#FFFFFF"><b>처방 확인 내역 등록</b></font></td>
							</tr>
							<tr>
								<td>담당자</td>
								<td><input name="u_usid" size="15" value="<%=usid%>" readonly></td>
							</tr>
							<tr>
								<td>처방일</td>
								<td><input type="date" name="u_date" size="15"></td>
							</tr>
							<tr>
								<td>확인여부</td>
								<td><input name="u_check" size="15" value="미완료" readonly></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
									<input type="button" value="내역등록" onClick="usage_inputCheck()"> &nbsp;&nbsp;
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