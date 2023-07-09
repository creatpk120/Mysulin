<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid =  request.getParameter("usid");
	String uspw = request.getParameter("uspw");
	String cPath = request.getContextPath();
	String url = cPath + "/index.jsp";
	String msg = "로그인에 실패했습니다.";
	
	boolean result = myMgr.loginMember(usid, uspw);
	if(result) {
		session.setAttribute("idKey", usid);
		msg = "로그인에 성공했습니다.";
	}
%>
<script>
	alert("<%=msg%>");
	top.document.location.reload();
	location.href="<%=url%>";
</script>