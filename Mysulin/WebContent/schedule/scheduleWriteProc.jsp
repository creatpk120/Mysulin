<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="myBean" class="mysulin.Bean_Schedule"/>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<jsp:setProperty  name="myBean" property="*"/>
<%
	boolean result = myMgr.Schedule_Insert(myBean);
	if(result) {
%>
<script type = "text/javascript">
		alert("내원 일정을 등록했습니다.");
		location.href = "scheduleList.jsp?check=S&numb1=0";
</script>
<%	} else {%>
<script type = "text/javascript">
		alert("내원 일정 등록에 실패했습니다.");
		history.back();
</script>
<%	}%>