<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Usage_l"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	int numb  = Integer.parseInt(request.getParameter("numb"));		//usageCheck
	int numb1 = Integer.parseInt(request.getParameter("numb1"));	//usageList
	
	Bean_Usage_l lBean = myMgr.getUsageLList(numb1);

%>

<html>
<head>
	<title>usageListUpdate</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function updateCheck(numb) {
			document.regFrm.recnumb.value=numb;
			document.regFrm.action="usageListUpdateProc.jsp";
			document.regFrm.submit();
		}
	</script>
</head>

<body bgcolor="#F0F8FF" onLoad="regFrm.usage_total.focus()">
	<div align="center">
		<br/><br/>
		<form name="regFrm" method="post" action="usageListUpdateProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td bgcolor="#F0F8FF" align="center" valign="middle">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr bgcolor="#6495ED" align="center">
								<td colspan="3"><font color="#FFFFFF"><b>일별 처방 목록 수정</b></font></td>
							</tr>
							<tr>
								<td>레코드번호</td>
								<td><input name="numb" size="15"
									value="<%=lBean.getNumb()%>" readonly></td>
							</tr>
							<tr>
								<td>처방일</td>
								<td><input type="date" name="usage_date" size="15"
									value="<%=lBean.getUsage_date()%>" readonly></td>
							</tr>
							<tr>
								<td>인슐린코드</td>
								<td><input name="usage_code" size="15"
									value="<%=lBean.getUsage_code()%>" readonly></td>
							</tr>
							<tr>
								<td>인슐린이름</td>
								<td><input name="usage_name" size="15"
									value="<%=lBean.getUsage_name()%>" readonly></td>
							</tr>
							<tr>
								<td>처방량</td>
								<td><input name="usage_total" size="15"
									value="<%=lBean.getUsage_total()%>"></td>
							</tr>
							<tr>
								<td>비고</td>
								<td><input name="usage_note" size="45"
									value="<%=lBean.getUsage_note()%>"></td>
							</tr>
							<tr>
								<td>확인</td>
								<td><input name="usage_check" size="15"
									value="<%=lBean.getUsage_check()%>" readonly></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								<input type="submit" value="수정완료" onClick="updateCheck(<%=numb%>)"> &nbsp;&nbsp; 
								<input type="reset" value="다시쓰기"> &nbsp;&nbsp;
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