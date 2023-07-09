<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	int numb = Integer.parseInt(request.getParameter("numb"));
	Bean_Admin aBean = myMgr.getMember3(usid, numb);	//회원자료 가져오기
	usid = aBean.getUsid();
%>

<html>
<head>
	<title>memberUpdate</title>
	<link href="style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="inputCheck.js"></script>
	<script type="text/javascript">
		function zipSearch() {
			url = "zipSearch.jsp?search=n";
			window.open(url, "ZipCodeSearch", "width=500,height=300,scrollbars=yes");
		}
	</script>
</head>

<body bgcolor="#F0F8FF" onLoad="regFrm.usid.focus()">
	<div align="center">
		<br/><br/>
		<form name="regFrm" method="post" action="memberUpdateProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td align="center" valign="middle" bgcolor="#F0F8FF">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr align="center" bgcolor="#6495ED">
								<td colspan="3"><font color="#FFFFFF"><b>회원 정보 수정</b></font></td>
							</tr>
							<tr>
								<td width="20%">아이디</td>
								<td width="80%"><input name="usid" size="15"
									value="<%=usid%>" readonly></td>
							</tr>
							<tr>
								<td>레코드번호</td>
								<td><input name="numb" size="15"
									value="<%=aBean.getNumb()%>" readonly></td>
							</tr>
							<tr>
								<td>패스워드</td>
								<td><input type="password" name="uspw" size="15"
									value="<%=aBean.getUspw()%>"></td>
							</tr>
							<tr>
								<td>회원권한</td>
								<td><input name="auth" size="15"
									value="<%=aBean.getAuth()%>" readonly></td>
							</tr>
							<tr>
								<td>이름</td>
								<td><input name="name" size="15"
									value="<%=aBean.getName()%>"></td>
							</tr>
							<tr>
								<td>내선번호</td>
								<td><input name="telp" size="15"
									value="<%=aBean.getTelp()%>"> ex) 1234</td>
							</tr>
							<tr>
								<td>전화번호</td>
								<td><input name="phone" size="15"
									value="<%=aBean.getPhone()%>"> ex) 010-1234-5678</td>
							</tr>
							<tr>
								<td>성별</td>
								<td>
									남<input type="radio" name="gend" value="1"
									<%=aBean.getGend().equals("1") ? "checked" : ""%>>
									여<input type="radio" name="gend" value="2"
									<%=aBean.getGend().equals("2") ? "checked" : ""%>>
								</td>
							</tr>
							<tr>
								<td>생년월일</td>
								<td><input name="brth" size="6"
									value="<%=aBean.getBrth()%>"> ex)230522</td>
							</tr>
							<tr>
								<td>Email</td>
								<td><input name="mail" size="30"
									value="<%=aBean.getMail()%>"></td>
							</tr>
							<tr>
								<td>우편번호</td>
								<td>
									<input name="post" size="5" value="<%=aBean.getPost()%>" readonly>
									<input type="button" value="우편번호찾기" onClick="zipSearch()">
								</td>
							</tr>
							<tr>
								<td>주소</td>
								<td><input name="addr" size="45"
									value="<%=aBean.getAddr()%>"></td>
							</tr>
							<tr>
								<td>취미</td>
								<td>
								<%
									String list[] = {"독서", "등산", "낚시", "여행", "영화"};
									String hobby[] = aBean.getHobb();
									for(int i = 0; i < list.length; i++) {
										out.println(list[i]);
										out.println("<input type=checkbox name=hobb ");
										out.println("value=" + list[i] + " "
										+ (hobby[i].equals("1") ? "checked" : "") + ">");
									}
								%>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								<input type="submit" value="수정완료"> &nbsp;&nbsp;
								<input type="reset" value="다시쓰기"> &nbsp;&nbsp;
								<input type="button" value="뒤로가기" onClick="history.go(-1)">
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>

</html>