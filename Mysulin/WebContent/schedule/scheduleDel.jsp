<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Schedule"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>

<html>
<head>
	<title>scheduleDel</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
	<%
		String usid = (String)session.getAttribute("idKey");	//관리자 ID
		Bean_Admin pBean = myMgr.getMember(usid);				//관리자 패스워드 가져오기

		String cPath = request.getContextPath();
		int numb = Integer.parseInt(request.getParameter("numb"));
		Bean_Schedule sBean = myMgr.getSchedule(numb);		//코드 자료 가져오기
		
		if(request.getParameter("pass") != null) {
			String inPass = request.getParameter("pass");
			String dbPass = pBean.getUspw();
			if(inPass.equals(dbPass)) {
				myMgr.deleteSchedule(numb);
				String url = "scheduleList.jsp?numb1=0";
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
					내원 일정을 삭제합니다.
				</td>
			</tr>
		</table>
		<form name="delFrm" method="post" action="scheduleDel.jsp">
			<table width="300" cellpadding="2">
				<tr>
					<td align="center">
						<table>
							<tr>
								<td>레코드 번호</td>
								<td><%=sBean.getNumb()%></td>
							</tr>
							<tr>
								<td>차트 번호</td>
								<td><%=sBean.getChart_numb()%></td>
							</tr>
							<tr>
								<td>환자 성명</td>
								<td><%=sBean.getChart_name()%></td>
							</tr>
							<tr>
								<td>인슐린 코드</td>
								<td><%=sBean.getRx_code()%></td>
							</tr>
							<tr>
								<td>인슐린 이름</td>
								<td><%=sBean.getRx_name()%></td>
							</tr>
							<tr>
								<td>인슐린 처방량</td>
								<td><%=sBean.getRx_amnt()%></td>
							</tr>
							<tr>
								<td>처방 일수</td>
								<td><%=sBean.getRx_date()%></td>
							</tr>
							<tr>
								<td>다음 내원일</td>
								<td><%=sBean.getRx_next()%></td>
							</tr>
							<tr>
								<td>비고</td>
								<td><%=sBean.getNote()%></td>
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