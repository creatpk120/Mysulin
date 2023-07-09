<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Mng_l"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<jsp:useBean id="myBean" class="mysulin.Bean_Mng_l"/>
<jsp:setProperty  name="myBean" property="*"/>
<%
	int numb = Integer.parseInt(request.getParameter("recnumb"));
	boolean result = myMgr.updateMngL(myBean);
	if(result) {
%>
<script type = "text/javascript">
		alert("재고 점검 내역을 수정했습니다.");
		location.href="mngList.jsp?numb=<%=numb%>&numb1=0";
</script>
<%	} else { %>
<script type = "text/javascript">
		alert("재고 점검 내역 수정에 실패했습니다.");
		history.back();
</script>
<%	} %>