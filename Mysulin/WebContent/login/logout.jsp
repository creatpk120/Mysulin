<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	String cPath = request.getContextPath();
	session.invalidate();
%>
<script>
	alert("로그아웃 되었습니다.");
	top.document.location.reload();
	location.href="<%=cPath%>/index.jsp";
</script>