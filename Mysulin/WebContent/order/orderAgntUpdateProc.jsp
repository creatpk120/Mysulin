<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Order_a"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<jsp:useBean id="myBean" class="mysulin.Bean_Order_a"/>
<jsp:setProperty  name="myBean" property="*"/>
<%
	boolean result = myMgr.updateOrderAgnt(myBean);
	if(result) {
%>
<script type = "text/javascript">
		alert("거래처 정보를 수정했습니다.");
		location.href = "orderAgnt.jsp?numb=0";
</script>
<%	} else {%>
<script type = "text/javascript">
		alert("거래처 정보 수정에 실패했습니다.");
		history.back();
</script>
<%	}%>