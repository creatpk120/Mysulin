<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Code"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<jsp:useBean id="codeBean" class="mysulin.Bean_Code"/>
<jsp:setProperty  name="codeBean" property="*"/>
<%
	boolean result = myMgr.updateCode(codeBean);
	if(result) {
%>
<script type = "text/javascript">
		alert("코드정보를 수정했습니다.");
		location.href = "codeList.jsp";
</script>
<%	} else { %>
<script type = "text/javascript">
		alert("코드정보 수정에 실패했습니다.");
		history.back();
</script>
<%	} %>