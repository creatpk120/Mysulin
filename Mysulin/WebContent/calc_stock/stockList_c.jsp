<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Stock"%>
<%@ page import="mysulin.Bean_Stock_c"%>
<%@ page import="mysulin.Bean_Stock_l"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>

<%
	int totalRecord = 0;	//전체 레코드 수
	int listSize = 0;		//현재 읽어온 자료의 수
	Vector<Bean_Stock_l> vlist = null;
	String usid = (String)session.getAttribute("idKey");
	
	int numb = Integer.parseInt(request.getParameter("numb"));
	Bean_Stock_c cBean = myMgr.getStockC(numb);
    String date = cBean.getS_date();
    
	Vector<Bean_Stock> vlist_a = null;
	vlist_a = myMgr.getStockList2();
	listSize = vlist_a.size();		//처리할 자료 수
	for(int i = 0; i < listSize; i++) {
		Bean_Stock bean = vlist_a.get(i);
		String s_usid = bean.getStock_usid();
		String s_date = bean.getStock_date();
		String s_code = bean.getStock_code();
		String s_name = bean.getStock_name();
		String s_exp = bean.getStock_exp();
		int s_pack = bean.getStock_pack();
		int s_piece = bean.getStock_piece();
		int s_total = bean.getStock_total();
		String s_note = bean.getStock_note();
		
		
		boolean result = myMgr.StockList_Check2(date, s_code, s_name);
		if(result) {
			
		} else {
			myMgr.StockList_Create(s_usid, date, s_code, s_name, s_exp, s_pack, s_piece, s_total, s_note);
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
		<table align="center" width="800" border="1">
			<tr>
				<td bgcolor="#D9E5FF">&nbsp;&nbsp;재고 수 : <%=listSize%></td>
			</tr>
		</table>
		<table align="center" width="800" cellpadding="3" border="1">
			<tr>
				<td align="center" colspan="3">
				<%
					vlist = myMgr.getStockLList1(date);
					listSize = vlist.size();	//브라우저 화면에 보여질 게시물 번호
					if(vlist.isEmpty()) {
						out.println("등록된 게시물이 없습니다.");
					} else {
				%>
					<table width="100%" cellpadding="2" cellspacing="0" border="1">
						<tr bgcolor="#D9E5FF" align="center" height="120%">
							<td>순서</td>
							<td>재고점검일</td>
							<td>인슐린코드</td>
							<td>인슐린이름</td>
							<td>유통기한</td>
							<td>박스</td>
							<td>낱개</td>
							<td>총량</td>
							<td>비고</td>
							<td>점검</td>
						</tr>
						<%
							for(int i = 0; i < listSize; i++) {
								Bean_Stock_l bean = vlist.get(i);
								numb = bean.getNumb();
								String l_date = bean.getStock_date();
								String l_code = bean.getStock_code();
								String l_name = bean.getStock_name();
								String exp = bean.getStock_exp();
								int pack = bean.getStock_pack();
								int piece = bean.getStock_piece();
								int total = bean.getStock_total();
								String note = bean.getStock_note();
								String check = bean.getStock_check();
						%>
						<tr>
							<td align="center"><%=numb%></td>
							<td align="center"><%=l_date%></td>
							<td align="center"><%=l_code%></td>
							<td align="center"><%=l_name%></td>
							<td align="center"><%=exp%></td>
							<td align="center"><%=pack%></td>
							<td align="center"><%=piece%></td>
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