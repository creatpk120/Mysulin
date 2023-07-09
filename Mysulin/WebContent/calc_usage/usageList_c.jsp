<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Usage_a"%>
<%@ page import="mysulin.Bean_Usage_c"%>
<%@ page import="mysulin.Bean_Usage_l"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>

<%
	int totalRecord = 0;	//전체 레코드 수
	int listSize = 0;		//현재 읽어온 자료의 수
	Vector<Bean_Usage_l> vlist = null;
	String usid = (String)session.getAttribute("idKey");
	
	int numb = Integer.parseInt(request.getParameter("numb"));
	Bean_Usage_c cBean = myMgr.getUsageCheck(numb);
    String date = cBean.getU_date();
    
	Vector<Bean_Usage_a> vlist_a = null;
	vlist_a = myMgr.getUsageList();
	listSize = vlist_a.size();		//처리할 자료 수
	for(int i = 0; i < listSize; i++) {
		Bean_Usage_a bean = vlist_a.get(i);
		String u_usid = bean.getUsage_usid();
		String u_date = bean.getUsage_date();
		String u_code = bean.getUsage_code();
		String u_name = bean.getUsage_name();
		int u_total = bean.getUsage_total();
		String u_note = bean.getUsage_note();
		
		
		boolean result = myMgr.UsageList_Check(date, u_code);
		if(result) {
			//System.out.println(" 존재하는 아이디 : " + usid);
		} else {
			myMgr.UsageList_Create(u_usid, date, u_code, u_name, u_total, u_note);
		}
	}
%>

<html>
<head>
	<title>stockList_c</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/>
		<h2>재고 목록 확인</h2>
		<br/>
		<table align="center" width="600" border="1">
			<tr>
				<td bgcolor="#D9E5FF">&nbsp;&nbsp;재고 수 : <%=listSize%></td>
			</tr>
		</table>
		<table align="center" width="600" cellpadding="3" border="1">
			<tr>
				<td align="center" colspan="3">
				<%
					vlist = myMgr.getUsageLList(date);
					listSize = vlist.size();	//브라우저 화면에 보여질 게시물 번호
					if(vlist.isEmpty()) {
						out.println("등록된 게시물이 없습니다.");
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
							<td>점검</td>
						</tr>
						<%
							for(int i = 0; i < listSize; i++) {
								Bean_Usage_l bean = vlist.get(i);
								numb = bean.getNumb();
								String l_date = bean.getUsage_date();
								String l_code = bean.getUsage_code();
								String l_name = bean.getUsage_name();
								int total = bean.getUsage_total();
								String note = bean.getUsage_note();
								String check = bean.getUsage_check();
						%>
						<tr>
							<td align="center"><%=numb%></td>
							<td align="center"><%=l_date%></td>
							<td align="center"><%=l_code%></td>
							<td align="center"><%=l_name%></td>
							<td align="center"><%=total%></td>
							<td align="center"><%=note%></td>
							<td align="center"><%=check%></td>
						</tr>
						<%	} %>
					</table> <%
					} %>
				</td>
			</tr>
		</table>
		<form name="readFrm" method="get">
			<br/>
			<input type="hidden" name="numb">
			<input type="button" value="뒤로가기" onClick="history.go(-1)">
		</form>
	</div>
</body>

</html>