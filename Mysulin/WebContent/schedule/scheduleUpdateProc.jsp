<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Schedule"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<jsp:useBean id="sBean" class="mysulin.Bean_Schedule"/>
<jsp:setProperty  name="sBean" property="*"/>
<%
	boolean result = myMgr.updateSchedule(sBean);
	if(result) {
%>
<script type = "text/javascript">
		alert("내원 일정을 수정했습니다.");
		location.href = "scheduleList.jsp?check=S&numb1=0";
</script>
<%	} else { %>
<script type = "text/javascript">
		alert("내원 일정 수정에 실패했습니다.");
		history.back();
</script>
<%	} %>