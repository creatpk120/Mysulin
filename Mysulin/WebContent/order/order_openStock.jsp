<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Stock_l"%>
<%@ page import="mysulin.Bean_Order_c"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	int listSize = 0;	//현재 읽어온 자료 수
	Vector<Bean_Stock_l> vlist = null;
	
	//임의로 지정한 날짜로 재고 리스트 불러오기
	SimpleDateFormat date_format = new SimpleDateFormat("yyyy-MM-dd");
	String st_fakeToday = "2023-05-22";
	vlist = myMgr.getStockLList1(st_fakeToday);
	listSize = vlist.size();
	for(int i = 0; i < listSize; i++) {
		Bean_Stock_l bean = vlist.get(i);
		int numb = bean.getNumb();
		String code = bean.getStock_code();
		String name = bean.getStock_name();
		String exp = bean.getStock_exp();
		int pack = bean.getStock_pack();
		int piece = bean.getStock_piece();
		int total = bean.getStock_total();
	}
%>

<html>
<head>
	<title>order_openStock</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/>
		<h2>재고 현황</h2>
		<br/>
		<table align="center" width="700" border="1">
			<tr>
				<td bgcolor="#D9E5FF">
					&nbsp;&nbsp;현재 가상 날짜(재고 연결) : <%=st_fakeToday%>
				</td>
			</tr>
		</table>
		<table align="center" width="700" cellpadding="3" border="1">
			<tr>
				<td align="center" colspan="3">
					<table width="100%" cellpadding="2" cellspacing="0" border="1">
						<tr bgcolor="#D9E5FF" align="center" height="120%">
							<td>인슐린코드</td>
							<td>인슐린이름</td>
							<td>유통기한</td>
							<td>박스</td>
							<td>낱개</td>
							<td>총량</td>
						</tr>
						<%
							for(int i = 0; i < listSize; i++) {
								Bean_Stock_l bean = vlist.get(i);
								int numb = bean.getNumb();
								String code = bean.getStock_code();
								String name = bean.getStock_name();
								String exp = bean.getStock_exp();
								int pack = bean.getStock_pack();
								int piece = bean.getStock_piece();
								int total = bean.getStock_total();
						%>
						<tr>
							<td align="center"><%=code%></td>
							<td align="center"><%=name%></td>
							<td align="center"><%=exp%></td>
							<td align="center"><%=pack%></td>
							<td align="center"><%=piece%></td>
							<td align="center" bgcolor="#E2E8F9"><%=total%></td>
						</tr>
						<%	} %>
					</table>
				</td>
			</tr>
		</table>
		<br/><a href="#" onClick="self.close()" style="font-size:1.2em">[닫기]</a>
	</div>
</body>

</html>