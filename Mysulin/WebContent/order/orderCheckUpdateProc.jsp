<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Order_c"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<jsp:useBean id="myBean" class="mysulin.Bean_Order_c"/>
<jsp:setProperty  name="myBean" property="*"/>
<%
	boolean result = myMgr.updateOrderCheck(myBean);
	if(result) {
%>
<script type = "text/javascript">
		alert("발주 내역을 수정했습니다.");
		location.href = "orderCheck.jsp?numb=0";
</script>
<%	} else { %>
<script type = "text/javascript">
		alert("발주 내역 수정에 실패했습니다.");
		history.back();
</script>
<%	} %>