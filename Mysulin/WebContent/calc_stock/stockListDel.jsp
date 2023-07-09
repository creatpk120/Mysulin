<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Stock_l"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>

<html>
<head>
	<title>stockListDel</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
	<%
		String usid = (String)session.getAttribute("idKey");
		Bean_Admin aBean = myMgr.getMember(usid);		//회원 자료 가져오기
	
		int numb  = Integer.parseInt(request.getParameter("numb"));		//stockCheck
		int numb1 = Integer.parseInt(request.getParameter("numb1"));	//stockList(delete대상)
		System.out.println("- 리스트 삭제 -");
		System.out.println("stockCheck numb  : " + numb);
		System.out.println("stockList numb1 : " + numb1);
		
		Bean_Stock_l lBean = myMgr.getStockL(numb1);		//삭제할 자료 가져오기
		
		if(request.getParameter("pass") != null) {
			String inPass = request.getParameter("pass");
			String dbPass = aBean.getUspw();
			if(inPass.equals(dbPass)) {
				myMgr.deleteStockL(numb1);
				String url = "stockList.jsp?numb=" + numb + "&numb1=0";
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
		<form name="delFrm" method="post" action="stockListDel.jsp">
			<table width="300" cellpadding="2">
				<tr>
					<td align="center">
						<table>
							<tr>
								<td>레코드 번호</td>
								<td><%=lBean.getNumb()%></td>
							</tr>
							<tr>
								<td>재고점검일</td>
								<td><%=lBean.getStock_date()%></td>
							</tr>
							<tr>
								<td>인슐린코드</td>
								<td><%=lBean.getStock_code()%></td>
							</tr>
							<tr>
								<td>인슐린이름</td>
								<td><%=lBean.getStock_name()%></td>
							</tr>
							<tr>
								<td>유통기한</td>
								<td><%=lBean.getStock_exp()%></td>
							</tr>
							<tr>
								<td>박스</td>
								<td><%=lBean.getStock_pack()%></td>
							</tr>
							<tr>
								<td>낱개</td>
								<td><%=lBean.getStock_piece()%></td>
							</tr>
							<tr>
								<td>총량</td>
								<td><%=lBean.getStock_total()%></td>
							</tr>
							<tr>
								<td>점검여부</td>
								<td><%=lBean.getStock_check()%></td>
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
			<input type="hidden" name="numb1" value="<%=numb1%>">
		</form>
	</div>
	<%	} %>
</body>
</html>