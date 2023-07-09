<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="myBean" class="mysulin.Bean_Admin"/>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<jsp:setProperty name="myBean" property="*"/>
<%
	boolean result = myMgr.insertMember(myBean);
	if(result) {
%>
<script type="text/javascript">
	alert("회원가입에 성공했습니다.");
	location.href="../main/main.jsp";
</script>
<%	} else {%>
<script type="text/javascript">
	alert("회원가입에 실패했습니다.");
	history.back();
</script>
<%	}%>