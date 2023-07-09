<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Usage_a"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	int totalRecord = 0;	//전체 레코드 수
	int listSize = 0;		//현재 읽어온 자료 수
	Vector<Bean_Usage_a> vlist = null;
	
	String usid = (String)session.getAttribute("idKey");
	int numb = 0;
	totalRecord = myMgr.getUsageCount(usid);
%>

<html>
<head>
	<title>usage</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function usageUpdate(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="a_usageUpdate.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function usageDel(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="a_usageDel.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
</script>
</head>

<body bgcolor="#F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/>
		<h2>인슐린 처방 목록</h2>
		<br/>
		<table align="center" width="800" border="1">
			<tr>
				<td bgcolor="#D9E5FF">&nbsp;&nbsp;자료 수 : <%=totalRecord%></td>
			</tr>
		</table>
		<table align="center" width="800" cellpadding="3" border="1">
			<tr>
				<td align="center" colspan="3">
				<%
					vlist = myMgr.getUsageList(usid);
							listSize = vlist.size();	//브라우저 화면에 보여질 자료 수
							if(vlist.isEmpty()) {
								out.println("등록된 자료가 없습니다.");
							} else {
				%>
					<table width="100%" cellpadding="2" cellspacing="0" border="1">
						<tr bgcolor="#D9E5FF" align="center" height="120%">
							<td>순서</td>
							<td>처방일</td>
							<td>인슐린코드</td>
							<td>인슐린이름</td>
							<td>처방량</td>
							<td>비고</td>
							<td>수 정</td>
							<td>삭 제</td>
						</tr>
						<%
							for(int i = 0; i < listSize; i++) {
								Bean_Usage_a bean = vlist.get(i);
								numb = bean.getNumb();
								String date = bean.getUsage_date();
								String code = bean.getUsage_code();
								String name = bean.getUsage_name();
								int total = bean.getUsage_total();
								String note = bean.getUsage_note();
						%>
						<tr>
							<td align="center"><%=numb%></td>
							<td align="center"><%=date%></td>
							<td align="center"><%=code%></td>
							<td align="center"><%=name%></td>
							<td align="center"><%=total%></td>
							<td align="center"><%=note%></td>
							<td align="center">
								<a href="javascript:usageUpdate('<%=numb%>')">수정</a>
							</td>
							<td align="center">
								<a href="javascript:usageDel('<%=numb%>')">삭제</a>
							</td>
						</tr>
						<%	}//for%>
					</table> <%
					}//if
				%>
				</td>
			</tr>
		</table>
		<form name="readFrm" method="get">
			<br/>
			<input type="button" value="처방등록" onClick="location.href='a_usageWrite.jsp'"> &nbsp;&nbsp;
			<input type="hidden" name="numb">
		</form>
	</div>
</body>

</html>