<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Code"%>
<%@ page import="mysulin.Bean_Stock_c"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>

<html>
<head>
	<title>stockCheckDel</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
	<%
		String usid = (String)session.getAttribute("idKey");
		Bean_Admin aBean = myMgr.getMember(usid);		//회원 자료 가져오기
	
		int numb = Integer.parseInt(request.getParameter("numb"));
		String cPath = request.getContextPath();
		
		Bean_Stock_c cBean = myMgr.getStockC(numb);		//삭제할 자료 가져오기
		
		if(request.getParameter("pass") != null) {
			String inPass = request.getParameter("pass");
			String dbPass = aBean.getUspw();
			if(inPass.equals(dbPass)) {
				myMgr.deleteStockC(numb);
				String url = "stockCheck.jsp?numb=0";
				response.sendRedirect(url);
			} else {
	%>
	<script type = "text/javascript">
				alert("비밀번호가 일치하지 않습니다.");
				history.back();
	</script>
	<%		}
		} else {
	%>
	<script type = "text/javascript">
		function check() {
			if(document.delFrm.pass.value == "") {
				alert("비밀번호를 입력하세요.");
				document.delFrm.pass.focus();
				return false;
			}
			document.delFrm.submit();
		}
	</script>
</head>

<body bgcolor="#F0F8FF">
	<div align="center">
		<br/><br/>
		<table width="300" cellpadding="3">
			<tr>
				<td bgcolor="#dddddd" height="21" align="center">
					재고 점검 내역을 삭제합니다.
				</td>
			</tr>
		</table>
		<form name="delFrm" method="post" action="stockCheckDel.jsp">
			<table width="300" cellpadding="2">
				<tr>
					<td align="center">
						<table>
							<tr>
								<td>레코드 번호</td>
								<td><%=cBean.getNumb()%></td>
							</tr>
							<tr>
								<td>담당자</td>
								<td><%=cBean.getS_usid()%></td>
							</tr>
							<tr>
								<td>재고점검일</td>
								<td><%=cBean.getS_date()%></td>
							</tr>
							<tr>
								<td>점검여부</td>
								<td><%=cBean.getS_check()%></td>
							</tr>
							<tr>
								<td>패스워드 확인</td>
								<td><input type="password" name="pass" size="10" maxlength="10"></td>
							</tr>
							<tr>
								<td><hr size="1" color="#eeeeee"/></td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<input type="button" value="삭제완료" onClick="check()"> &nbsp;
									<input type="reset" value="다시쓰기"> &nbsp;
									<input type="button" value="뒤로가기" onClick="history.go(-1)">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="numb" value="<%=numb%>">
		</form>
	</div>
	<%	} %>
</body>
</html>