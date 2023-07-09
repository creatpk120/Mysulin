<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Code"%>
<%@ page import="mysulin.Bean_Stock"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	Bean_Stock cBean = myMgr.getStock_code(usid);
%>

<html>
<head>
	<title>stockWrite</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function stock_inputCheck() {
		if(document.stockFrm.stock_date.value == "") {
			alert("재고점검일을 선택해주세요.");
			document.stockFrm.stock_date.focus();
			return;
		}
		if(document.stockFrm.stock_code.value == "") {
			alert("인슐린코드를 입력해주세요.");
			document.stockFrm.stock_code.focus();
			return;
		}
		if(document.stockFrm.stock_name.value == "") {
			alert("인슐린이름을 입력해주세요.");
			document.stockFrm.stock_name.focus();
			return;
		}
		if(document.stockFrm.stock_exp.value == "") {
			alert("유통기한을 입력해주세요.");
			document.stockFrm.stock_exp.focus();
			return;
		}
		if(document.stockFrm.stock_pack.value == "") {
			alert("박스 수를 입력해주세요.");
			document.stockFrm.stock_pack.focus();
			return;
		}
		if(document.stockFrm.stock_piece.value == "") {
			alert("낱개 수를 입력해주세요.");
			document.stockFrm.stock_piece.focus();
			return;
		}
		document.stockFrm.action = "a_stockWriteProc.jsp";
		document.stockFrm.submit();
	}
</script>
</head>

<body bgcolor="#F0F8FF" onLoad="stockFrm.stock_date.focus()">
	<div align="center">
		<br/><br/>
		<form name="stockFrm" method="post" action="a_stockWriteProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td bgcolor="#F0F8FF" align="center" valign="middle">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr bgcolor="#6495ED" align="center">
								<td align="center" colspan="3"><font color="#FFFFFF"><b>재고 목록 등록</b></font></td>
							</tr>
							<tr>
								<td>담당자</td>
								<td><input name="stock_usid" size="15" value="<%=usid%>" readonly></td>
							</tr>
							<tr>
								<td>재고점검일</td>
								<td><input type="date" name="stock_date" size="15"></td>
							</tr>
							<tr>
								<td>인슐린코드</td>
								<td><input name="stock_code" size="15"></td>
							</tr>
							<tr>
								<td>인슐린이름</td>
								<td><input name="stock_name" size="15"></td>
							</tr>
							<tr>
								<td>유통기한</td>
								<td><input type="date" name="stock_exp" size="15"></td>
							</tr>
							<tr>
								<td>박스</td>
								<td><input name="stock_pack" size="15"></td>
							</tr>
							<tr>
								<td>낱개</td>
								<td><input name="stock_piece" size="15"></td>
							</tr>
							<!-- <tr>
								<td>총량</td>
								<td><input name="stock_total" size="15"></td>
							</tr> -->
							<tr>
								<td>비고</td>
								<td><input name="stock_note" size="30"></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
									<input type="button" value="재고등록" onClick="stock_inputCheck()"> &nbsp;&nbsp;
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