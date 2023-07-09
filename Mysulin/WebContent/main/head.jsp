<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="mysulin.Bean_Admin"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	Bean_Admin aBean = myMgr.getMember(usid);		//회원자료 가져오기
	String auth = null;
	String name = "";
	if(usid != null) {
		auth = aBean.getAuth();
		name = aBean.getName() + "님 ";
	}

	String cPath = request.getContextPath();
	String logurl = "로그아웃";
	if(usid == null) logurl = "로그인";
%>


<html>
<head>
	<title>head</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function loginForm() {
			document.loginFrm.target="content";
			document.loginFrm.action="<%=cPath%>/login/login.jsp";
			document.loginFrm.submit();
		}
	
		function memberForm() {
			document.loginFrm.target="content";
			document.loginFrm.action="<%=cPath%>/admin/memberJoin.jsp";
			document.loginFrm.submit();
		}
	</script>
</head>

<body bgcolor="#FFFFFF">
	<table width="100%" cellpadding="0" cellspacing="0">
		<%
			if(usid != null) {
		%>
		<tr>
			<td width="30%" align="left">
				<a href="<%=cPath%>/index.jsp" target="_parent" onFocus="this.blur();">
				&nbsp;<img width="30%" src="../images/mysulin_logo.jpg" border="0"></a>
			</td>
			<td width="35%" align="center" valign="bottom"></td>
			<td width="35%" align="right" valign="top">
				<form name="loginFrm">
					&nbsp;
					<input type="button" value="<%=name + logurl%>" onClick="loginForm()">
				</form>
			</td>
		</tr>
		<%	} else { %>
		<tr>
			<td width="30%" align="left">
				<a href="<%=cPath%>/index.jsp" target="_parent" onFocus="this.blur();">
				&nbsp;<img width="30%" src="../images/mysulin_logo.jpg" border="0"></a>
			</td>
			<td width="35%" align="center" valign="middle"></td>
			<td width="35%" align="right" valign="top">
				<form name="loginFrm">
					&nbsp;
					<input type="button" value="<%=name + logurl%>" onClick="loginForm()">
					<input type="button" value="회원가입" onClick="memberForm()">
				</form>
			</td>
		</tr>
		<%	} %>
	</table>
</body>

</html>