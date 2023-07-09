<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin" />
<%
	String usid = request.getParameter("usid");
	boolean result = myMgr.checkId(usid);
%>
<html>
<head>
	<title>idCheck</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#F0F8FF">
	<div align="center">
		<br/> <b><%=usid%></b>
		<%
			if (result) {
				out.println("는 사용할 수 없는 ID입니다.<p>");
			} else {
				out.println("는 사용 가능합니다.<p>");
			}
		%>
		<a href="#" onClick="self.close()">닫기</a>
	</div>
</body>
</html>