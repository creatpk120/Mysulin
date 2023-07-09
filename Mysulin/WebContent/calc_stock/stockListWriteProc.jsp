<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Stock_l"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<jsp:useBean id="myBean" class="mysulin.Bean_Stock_l"/>
<jsp:setProperty  name="myBean" property="*"/>
<%
	int numb = Integer.parseInt(request.getParameter("recnumb"));
	boolean result = myMgr.StockList_Insert(myBean);
	if(result) {
%>
<script type = "text/javascript">
		alert("재고 내역을 등록했습니다.");
		location.href="stockList.jsp?numb=<%=numb%>&numb1=0";
</script>
<%	} else {%>
<script type = "text/javascript">
		alert("재고 내역 등록에 실패했습니다.");
		history.back();
</script>
<%	}%>