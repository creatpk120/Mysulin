<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Mng_c"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<jsp:useBean id="myBean" class="mysulin.Bean_Mng_c"/>
<jsp:setProperty  name="myBean" property="*"/>
<%
	boolean result = myMgr.updateMngCheck(myBean);
	if(result) {
%>
<script type = "text/javascript">
		alert("처방 확인 내역을 수정했습니다.");
		location.href = "mngCheck.jsp?numb=0";
</script>
<%	} else { %>
<script type = "text/javascript">
		alert("처방 확인 내역 수정에 실패했습니다.");
		history.back();
</script>
<%	} %>