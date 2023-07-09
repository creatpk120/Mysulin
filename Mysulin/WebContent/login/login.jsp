<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="mysulin.Bean_Admin"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	String cPath = request.getContextPath();
	Bean_Admin aBean = myMgr.getMember(usid);		//회원자료 가져오기
%>

<html>
<head>
	<title>login</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function loginCheck() {
			if(document.loginFrm.usid.value == "") {
				alert("아이디를 입력해주세요.");
				document.loginFrm.usid.focus();
				return;
			}
			if(document.loginFrm.uspw.value == "") {
				alert("패스워드를 입력해주세요.");
				document.loginFrm.uspw.focus();
				return;
			}
			document.loginFrm.action="<%=cPath%>/login/loginProc.jsp";
			document.loginFrm.submit();
		}
	
		function memberForm() {
			document.loginFrm.target="content";
			document.loginFrm.action="<%=cPath%>/admin/memberJoin.jsp";
			document.loginFrm.submit();
		}
	</script>
</head>

<body bgcolor="#F0F8FF">
<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
	<td width="17%">&nbsp;</td>
	<td width="53%" align="center">
	<div>
	<%
		if(usid != null) {
	%>
	<br/><br/>
	<b><%=aBean.getName()%></b>[<%=usid%>]
	<b>[<%=aBean.getAuth()%>][<%=aBean.getNumb()%>]</b>님 안녕하세요.
	<p>인슐린 관리 홈페이지입니다.
	<%int numb = aBean.getNumb();%><br/><br/>
	<a href="<%=cPath%>/login/logout.jsp">[로그아웃]</a>
	<%	} else {%>
		<form name="loginFrm" method="post" action="loginProc.jsp">
			<br/><br/>
			<table>
				<tr>
					<td align="center" colspan="2"><h3>로그인</h3></td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><input name="usid" value=""
					onkeypress="if(event.keyCode == 13){loginCheck();}"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="uspw" value=""
					onkeypress="if(event.keyCode == 13){loginCheck();}"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<div align="center">
							<input type="button" value="로그인" onClick="loginCheck()"> &nbsp;
							<input type="button" value="회원가입" onClick="memberForm()">
						</div>
					</td>
				</tr>
			</table>
		</form>
	<%	}%>
	</div>
	<form name="readFrm" method="get">
		<input type="hidden" name="numb">
	</form>
	</td>
	<td width="30%">&nbsp;</td>
	</tr>
</table>
</body>

</html>