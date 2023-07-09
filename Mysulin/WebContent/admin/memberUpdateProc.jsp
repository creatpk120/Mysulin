<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="mysulin.Bean_Admin"%>
<jsp:useBean id="myBean" class="mysulin.Bean_Admin"/>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<jsp:setProperty  name="myBean" property="*"/>
<%
	String usid = (String)session.getAttribute("idKey");
	Bean_Admin aBean = myMgr.getMember(usid);		//회원자료 가져오기
	String auth = null;
	if(usid != null) {
		auth = aBean.getAuth();
	}

	boolean result = myMgr.updateMember(myBean);
	if(result){
%>
<script type="text/javascript">
		alert("회원정보를 수정했습니다.");
		<%	if(auth.equals("S")) { %>
				location.href="memberList.jsp?check=S&numb=0";
		<%	} else { %>
				history.back();
		<%	} %>
</script>
<%	} else { %>
<script type="text/javascript">
		alert("회원정보 수정에 실패했습니다.");
		history.back();
</script>
<%	} %>