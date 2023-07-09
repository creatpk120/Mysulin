<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Code"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	int numb = Integer.parseInt(request.getParameter("numb"));
	Bean_Code codeBean = myMgr.getCode1(numb);	//입력자료 가져오기
%>

<html>
<head>
	<title>codeUpdate</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#F0F8FF" onLoad="regFrm.agnt.focus()">
	<div align="center">
		<br/><br/>
		<form name="regFrm" method="post" action="codeUpdateProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td bgcolor="#F0F8FF" align="center" valign="middle">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr bgcolor="#6495ED" align="center">
								<td colspan="3"><font color="#FFFFFF"><b>코드 자료 수정</b></font></td>
							</tr>
							<tr>
								<td>레코드번호</td>
								<td><input name="numb" size="15"
									value="<%=codeBean.getNumb()%>" readonly></td>
							</tr>
							<tr>
								<td>담당자</td>
								<td><input name="usid" size="15"
									value="<%=codeBean.getUsid()%>" readonly></td>
							</tr>
							<tr>
								<td>제약 회사</td>
								<td><input name="agnt" size="15"
									value="<%=codeBean.getAgnt()%>"></td>
							</tr>
							<tr>
								<td>인슐린 코드</td>
								<td><input name="code" size="15"
									value="<%=codeBean.getCode()%>"></td>
							</tr>
							<tr>
								<td>인슐린 이름</td>
								<td><input name="name" size="15"
									value="<%=codeBean.getName()%>"></td>
							</tr>
							<tr>
								<td>비고</td>
								<td><input name="note" size="30"
									value="<%=codeBean.getNote()%>"></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								<input type="submit" value="수정완료"> &nbsp;&nbsp; 
								<input type="reset" value="다시쓰기"> &nbsp;&nbsp; 
								<input type="button" value="자료삭제" onClick="location.href='codeDel.jsp?numb=<%=numb%>'"> &nbsp;&nbsp;
								<input type="button" value="신규자료" onClick="location.href='codeWrite.jsp'"> &nbsp;&nbsp;
								<input type="button" value="코드목록" onClick="history.go(-1)"></td>						
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>

</html>