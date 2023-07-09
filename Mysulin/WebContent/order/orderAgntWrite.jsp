<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Order_a"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	Bean_Order_a aBean = myMgr.getOrderAgnt();
%>

<html>
<head>
	<title>orderAgntWrite</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function inputCheck() {
		if(document.regFrm.agnt.value == "") {
			alert("거래처를 입력해주세요.");
			document.regFrm.agnt.focus();
			return;
		}
		if(document.regFrm.name.value == "") {
			alert("담당자를 입력해주세요.");
			document.regFrm.name.focus();
			return;
		}
		document.regFrm.action = "orderAgntWriteProc.jsp";
		document.regFrm.submit();
	}
	
	function zipSearch() {
		url = "orderAgnt_zipSearch.jsp?search=n";
		window.open(url, "ZipCodeSearch", "width=500,height=300,scrollbars=yes");
	}
</script>
</head>

<body bgcolor="#F0F8FF" onLoad="regFrm.agnt.focus()">
	<div align="center">
		<br/><br/>
		<form name="regFrm" method="post" action="orderAgntWriteProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td bgcolor="#F0F8FF" align="center" valign="middle">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr bgcolor="#6495ED" align="center">
								<td align="center" colspan="3"><font color="#FFFFFF"><b>거래처 등록</b></font></td>
							</tr>
							<tr>
								<td>거래처</td>
								<td><input name="agnt" size="15"></td>
							</tr>
							<tr>
								<td>담당자</td>
								<td><input name="name" size="15"></td>
							</tr>
							<tr>
								<td>전화번호</td>
								<td><input name="telp" size="15"> ex) 010-1234-5678</td>
							</tr>
							<tr>
								<td>Email</td>
								<td><input name="mail" size="30"></td>
							</tr>
							<tr>
								<td>우편번호</td>
								<td>
									<input name="post" size="5" readonly>
									<input type="button" value="우편번호찾기" onClick="zipSearch()">
								</td>
							</tr>
							<tr>
								<td>상세주소</td>
								<td><input name="addr" size="45"></td>
							</tr>
							<tr>
								<td>비고</td>
								<td><input name="note" size="45"></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
									<input type="button" value="등록하기" onClick="inputCheck()"> &nbsp;&nbsp;
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