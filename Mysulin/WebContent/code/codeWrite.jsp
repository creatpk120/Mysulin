<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String usid = (String)session.getAttribute("idKey");
%>

<html>
<head>
	<title>codeWrite</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function code_inputCheck() {
		if(document.codeFrm.agnt.value=="") {
			alert("제약회사를 입력해주세요.");
			document.codeFrm.agnt.focus();
			return;
		}
		if(document.codeFrm.code.value=="") {
			alert("인슐린 코드를 입력해주세요.");
			document.codeFrm.code.focus();
			return;
		}
		if(document.codeFrm.name.value=="") {
			alert("인슐린 이름을 입력해주세요.");
			document.codeFrm.name.focus();
			return;
		}
		document.codeFrm.action="codeWriteProc.jsp";
		document.codeFrm.submit();
	}
</script>
</head>

<body bgcolor="#F0F8FF" onLoad="codeFrm.agnt.focus()">
	<div align="center">
		<br/><br/>
		<form name="codeFrm" method="post" action="codeWriteProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td bgcolor="#F0F8FF" align="center" valign="middle">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr bgcolor="#6495ED" align="center">
								<td align="center" colspan="3"><font color="#FFFFFF"><b>코드 등록</b></font></td>
							</tr>
							<tr>
								<td>담당자</td>
								<td><input name="usid" size="15" value="<%=usid%>" readonly></td>
								<td>입력, 수정 불가</td>
							</tr>
							<tr>
								<td>제약 회사</td>
								<td><input name="agnt" size="15"></td>
								<td>제약 회사를 입력해주세요.</td>
							</tr>
							<tr>
								<td>인슐린 코드</td>
								<td><input name="code" size="15"></td>
								<td>인슐린 코드를 입력해주세요.</td>
							</tr>
							<tr>
								<td>인슐린 이름</td>
								<td><input name="name" size="15"></td>
								<td>인슐린 이름을 입력해주세요.</td>
							</tr>
							<tr>
								<td>비고</td>
								<td><input name="note" size="30"></td>
								<td>비고를 입력해주세요.</td>
							</tr>
							<tr>
								<td colspan="3" align="center">
									<input type="button" value="코드등록" onClick="code_inputCheck()"> &nbsp;&nbsp;
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