<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Stock_l"%>
<%@ page import="mysulin.Bean_Mng_c"%>
<%@ page import="mysulin.Bean_Mng_l"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	int s_listSize = 0;		//현재 읽어온 재고 리스트 자료의 수
	int l_listSize = 0;		//현재 읽어온 정산 리스트 자료 수
	Vector<Bean_Stock_l> s_vlist = null;
	Vector<Bean_Mng_l>	 l_vlist = null;
	
	String usid = (String)session.getAttribute("idKey");
	int recnum = Integer.parseInt(request.getParameter("numb1"));
	int numb   = Integer.parseInt(request.getParameter("numb"));

	Bean_Mng_c cBean = myMgr.getMngCheck(numb);
    String date = cBean.getM_y_date();	//점검대상일
    String date1 = cBean.getM_t_date();	//점검실행일 → 오늘재고업뎃용
	
	//정산 결과 당일 재고 리스트에 넣기
	//날짜별 리스트 삭제하고 생성
	myMgr.truncate_stockList(date1);
	
	l_vlist = myMgr.getMngList(date);
	l_listSize = l_vlist.size();
	for(int i = 0; i < l_listSize; i++) {
		Bean_Mng_l bean = l_vlist.get(i);
		String l_usid = bean.getMng_usid();
		String l_date = bean.getMng_date();
		String l_code = bean.getMng_code();
		String name = bean.getMng_name();
		String exp = bean.getMng_exp();
		int pack = bean.getMng_pack();
		int piece = bean.getMng_piece();
		int total = bean.getMng_total();
		String note = bean.getMng_note();
		String check = bean.getMng_check();
		
		boolean result = myMgr.StockList_Check(date1, l_code, name, exp);
		if(result) {
			
		} else {
			myMgr.StockList_Create(l_usid, date1, l_code, name, exp, pack, piece, total, note);
		}
	}
%>

<html>
<head>
	<title>mngList_stockUpdate</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/>
		<h2>당일 재고 목록 생성</h2>
		<br/>
		<table align="center" width="800" border="1">
			<tr>
				<td bgcolor="#D9E5FF">&nbsp;※ 재고 등록 페이지를 확인하세요.</td>
			</tr>
		</table>
		<table align="center" width="800" cellpadding="3" border="1">
			<tr>
				<td align="center" colspan="3">
				<%
					l_vlist = myMgr.getMngList(date);
					l_listSize = l_vlist.size();	//브라우저 화면에 보여질 자료 수
					if(l_vlist.isEmpty()) {
						out.println("등록된 자료가 없습니다.");
					} else {
				%>
					<table width="100%" cellpadding="2" cellspacing="0" border="1">
						<tr bgcolor="#D9E5FF" align="center" height="120%">
							<td>순서</td>
							<td>재고등록일</td>
							<td>인슐린코드</td>
							<td>인슐린이름</td>
							<td>유통기한</td>
							<td>박스</td>
							<td>낱개</td>
							<td>총량</td>
							<td>비고</td>
							<td>점 검</td>
						</tr>
						<%
							for(int i = 0; i < l_listSize; i++) {
								Bean_Mng_l bean = l_vlist.get(i);
								int numb1 = bean.getNumb();
								String l_date = bean.getMng_date();
								String l_code = bean.getMng_code();
								String name = bean.getMng_name();
								String exp = bean.getMng_exp();
								int pack = bean.getMng_pack();
								int piece = bean.getMng_piece();
								int total = bean.getMng_total();
								String note = bean.getMng_note();
								String check = bean.getMng_check();
						%>
						<tr>
							<td align="center"><%=numb1%></td>
							<td align="center"><%=date1%></td>
							<td align="center"><%=l_code%></td>
							<td align="center"><%=name%></td>
							<td align="center"><%=exp%></td>
							<td align="center"><%=pack%></td>
							<td align="center"><%=piece%></td>
							<td align="center"><%=total%></td>
							<td align="center"><%=note%></td>
							<td align="center"><%=check%></td>
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
			<input type="button" value="뒤로가기" onClick="location.href='mngList.jsp?numb=<%=numb%>&numb1=<%=recnum%>'"> &nbsp;&nbsp;
			<input type="button" value="재고목록" onClick="location.href='../calc_stock/stockCheck.jsp?numb=<%=numb%>'"> &nbsp;&nbsp;
			<input type="button" value="인쇄하기" id="print" onClick="window.print()">
			<input type="hidden" name="numb">
			<input type="hidden" name="numb1">
			<input type="hidden" name="perm1">
			<input type="hidden" name="perm2">
		</form>
	</div>
</body>

</html>