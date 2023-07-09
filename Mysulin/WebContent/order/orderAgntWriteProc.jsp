<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Order_a"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<jsp:useBean id="myBean" class="mysulin.Bean_Order_a"/>
<jsp:setProperty  name="myBean" property="*"/>
<%
	boolean result = myMgr.orderAgnt_Insert(myBean);
	if(result) {
%>
<script type = "text/javascript">
		alert("신규 거래처를 등록했습니다.");
		location.href = "orderAgnt.jsp?numb=0";
</script>
<%	} else {%>
<script type = "text/javascript">
		alert("신규 거래처 등록에 실패했습니다.");
		history.back();
</script>
<%	}%>