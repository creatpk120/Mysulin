<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Code"%>
<%@ page import="mysulin.Bean_Stock_c"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<jsp:useBean id="myBean" class="mysulin.Bean_Stock_c"/>
<jsp:setProperty  name="myBean" property="*"/>
<%
	boolean result = myMgr.StockC_Insert(myBean);
	if(result) {
%>
<script type = "text/javascript">
		alert("재고 점검 내역을 등록했습니다.");
		location.href = "stockCheck.jsp?numb=0";
</script>
<%	} else {%>
<script type = "text/javascript">
		alert("재고 점검 내역 등록에 실패했습니다.");
		history.back();
</script>
<%	}%>