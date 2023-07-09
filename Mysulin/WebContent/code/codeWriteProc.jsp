<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="myBean" class="mysulin.Bean_Code"/>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<jsp:setProperty  name="myBean" property="*"/>
<%
	boolean result = myMgr.Code_Insert(myBean);
	if(result) {
%>
<script type = "text/javascript">
		alert("코드를 등록했습니다.");
		location.href = "codeList.jsp";
</script>
<%	} else {%>
<script type = "text/javascript">
		alert("코드 등록에 실패했습니다.");
		history.back();
</script>
<%	}%>