<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Mng_l"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	int numb  = Integer.parseInt(request.getParameter("numb"));		//stockCheck
	int numb1 = Integer.parseInt(request.getParameter("numb1"));	//stockList
	
	Bean_Mng_l lBean = myMgr.getMngL(numb1);
%>

<html>
<head>
	<title>mngListUpdate</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function updateCheck(numb) {
			document.regFrm.recnumb.value=numb;
			document.regFrm.action="mngListUpdateProc.jsp";
			document.regFrm.submit();
		}
	</script>
</head>

<body bgcolor="#F0F8FF" onLoad="regFrm.mng_exp.focus()">
	<div align="center">
		<br/><br/>
		<form name="regFrm" method="post" action="mngListUpdateProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td bgcolor="#F0F8FF" align="center" valign="middle">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr bgcolor="#6495ED" align="center">
								<td colspan="3"><font color="#FFFFFF"><b>정산 내역 수정</b></font></td>
							</tr>
							<tr>
								<td>레코드번호</td>
								<td><input name="numb" size="15"
									value="<%=lBean.getNumb()%>" readonly></td>
							</tr>
							<tr>
								<td>담당자</td>
								<td><input name="mng_usid" size="15"
									value="<%=usid%>" readonly></td>
							</tr>
							<tr>
								<td>재고점검일</td>
								<td><input type="date" name="mng_date" size="15"
									value="<%=lBean.getMng_date()%>" readonly></td>
							</tr>
							<tr>
								<td>인슐린코드</td>
								<td><input name="mng_code" size="15"
									value="<%=lBean.getMng_code()%>" readonly></td>
							</tr>
							<tr>
								<td>인슐린이름</td>
								<td><input name="mng_name" size="15"
									value="<%=lBean.getMng_name()%>" readonly></td>
							</tr>
							<tr>
								<td>유통기한</td>
								<td><input type="date" name="mng_exp" size="15"
									value="<%=lBean.getMng_exp()%>"></td>
							</tr>
							<tr>
								<td>박스</td>
								<td><input name="mng_pack" size="15"
									value="<%=lBean.getMng_pack()%>"></td>
							</tr>
							<tr>
								<td>낱개</td>
								<td><input name="mng_piece" size="15"
									value="<%=lBean.getMng_piece()%>"></td>
							</tr>
							<tr>
								<td>총량</td>
								<td><input name="mng_total" size="15"
									value="<%=lBean.getMng_total()%>"></td>
							</tr>
							<tr>
								<td>비고</td>
								<td><input name="mng_note" size="30"
									value="<%=lBean.getMng_note()%>"></td>
							</tr>
							<tr>
								<td>점검</td>
								<td><input name="mng_check" size="15"
									value="<%=lBean.getMng_check()%>" readonly></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								<input type="submit" value="수정완료" onClick="updateCheck(<%=numb%>)"> &nbsp;&nbsp; 
								<input type="reset" value="다시쓰기"> &nbsp;&nbsp;
								<input type="button" value="추가하기" onClick="location.href='mngListWrite.jsp?numb=<%=numb%>&numb1=<%=numb1%>'"> &nbsp;&nbsp;
								<input type="button" value="뒤로가기" onClick="history.go(-1)">
								<input type="hidden" name="recnumb"></td>							 
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>

</html>