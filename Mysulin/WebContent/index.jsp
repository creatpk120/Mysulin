<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	String strTitle = "Mysulin: My Insulin Manager";
	String cPath = request.getContextPath();
%>

<html>
<head>
	<title><%=strTitle%></title>
</head>
<frameset frameborder="0" framespacing="0" border="0" rows="130,*">
	<frame name="head" src="<%=cPath%>/main/head.jsp" frameborder="0" scrolling="NO" noresize>
	<frameset name="body" frameborder="0" framespacing="0" border="0" rows="*,20">
		<frameset name="main" frameborder="0" framespacing="0" border="0" cols="150,*">
			<frame name="left" src="<%=cPath%>/main/left.jsp" marginwidth="0" marginheight="0" frameborder="0" scrolling="NO" resize="NO">
			<frame name="content" src="<%=cPath%>/main/main.jsp" marginwidth="0" marginheight="0" frameborder="0" scrolling="YES" noresize>
		</frameset>
		<frame name="copy" src="<%=cPath%>/main/copy.jsp" marginwidth="0" marginheight="0" frameborder="0" scrolling="NO" noresize>
	</frameset>
</frameset>
</html>