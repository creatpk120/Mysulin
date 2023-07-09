<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Stock_l"%>
<%@ page import="mysulin.Bean_Usage_l"%>
<%@ page import="mysulin.Bean_Mng_c"%>
<%@ page import="mysulin.Bean_Mng_l"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>

<%
	int totalRecord = 0;	//전체 레코드 수
	int s_listSize = 0;		//현재 읽어온 재고 리스트 자료 수
	int u_listSize = 0;		//현재 읽어온 처방 리스트 자료 수
	int l_listSize = 0;		//현재 읽어온 정산 리스트 자료 수
	Vector<Bean_Stock_l> s_vlist = null;
	Vector<Bean_Usage_l> u_vlist = null;
	Vector<Bean_Mng_l> 	 l_vlist = null;
	
	String usid = (String)session.getAttribute("idKey");
	int numb = Integer.parseInt(request.getParameter("numb"));
	
	Bean_Mng_c cBean = myMgr.getMngCheck(numb);
    String date = cBean.getM_y_date();	//점검대상일
	
	//날짜별 리스트 삭제하고 생성
	myMgr.truncate_mngList(date);
	
    //해당 날짜 재고 리스트 불러와서 정산 리스트에 넣기
	s_vlist = myMgr.getStockLList1(date);
	s_listSize = s_vlist.size();		//처리할 자료 수
	for(int i = 0; i < s_listSize; i++) {
		Bean_Stock_l bean = s_vlist.get(i);
		String s_usid = bean.getStock_usid();
		String s_date = bean.getStock_date();
		String s_code = bean.getStock_code();
		String s_name = bean.getStock_name();
		String s_exp = bean.getStock_exp();
		int s_pack = bean.getStock_pack();
		int s_piece = bean.getStock_piece();
		int s_total = bean.getStock_total();
		String s_note = bean.getStock_note();
		
		boolean result = myMgr.mngList_Check(date, s_code, s_name, s_exp);
		if(result) {
			System.out.println("리스트 이미 있어서 생성하지 않았음");
		} else {
			//System.out.println("리스트 생성함");
			myMgr.mngList_Create(s_usid, date, s_code, s_name, s_exp, s_pack, s_piece, s_total, s_note);
		}
	}
	
	//정산 기능
	//해당 날짜 사용 리스트 불러오기
	u_vlist = myMgr.getUsageLList(date);
	u_listSize = u_vlist.size();
	for(int i = 0; i < u_listSize; i++) {
		Bean_Usage_l uBean = u_vlist.get(i);
		int u_numb = uBean.getNumb();
		String u_code = uBean.getUsage_code();
		String u_name = uBean.getUsage_name();
		int u_total = uBean.getUsage_total();
//		System.out.println(u_code + "_" + u_name);
//		System.out.println("사용 : " + u_total);
		
		//유통기한 선입선출 계산 반복
		l_vlist = myMgr.getMngList1(date, u_code);
		l_listSize = l_vlist.size();
		for(int j = 0; j < l_listSize; j++) {
			Bean_Mng_l bean = l_vlist.get(j);
			int numb1 = bean.getNumb();
			String code = bean.getMng_code();
			String bundle = code.substring(1,2);
			String exp = bean.getMng_exp();
			int pack = 0;
			int piece = 0;
			int total = bean.getMng_total();
//			System.out.println("재고 : " + total);
			
			if(total >= u_total) {
				total = total - u_total;
				u_total = 0;
//				System.out.println("총량 : " + total);
			}
			else if(total < u_total) {
				total = total - u_total;
				u_total = total * -1;
				if(total < 0) total = 0;
//				System.out.println("총량 : " + total);
			}
			
			//총량으로 상자+낱개 분리(번들 적용)
			if(bundle.equals("2")) {
				pack = total / 2;
				piece = total % 2;
			} else if(bundle.equals("3")) {
				pack = total / 3;
				piece = total % 3;
			} else if(bundle.equals("5")) {
				pack = total / 5;
				piece = total % 5;
			}
			myMgr.updateMngListTotal2(date, exp, code, pack, piece, total);
		}			
	}

	l_vlist = myMgr.getMngList(date);
	l_listSize = l_vlist.size();	
%>

<html>
<head>
	<title>mngList_c</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/>
		<h2>정산 목록 생성</h2>
		<br/>
		<table align="center" width="800" border="1">
			<tr>
				<td bgcolor="#D9E5FF">&nbsp;&nbsp;자료 수 : <%=s_listSize%></td>
			</tr>
		</table>
		<table align="center" width="800" cellpadding="3" border="1">
			<tr>
				<td align="center" colspan="3">
				<%
					if(l_vlist.isEmpty()) {
						out.println("등록된 게시물이 없습니다.");
					} else {
				%>
					<table width="100%" cellpadding="2" cellspacing="0" border="1">
						<tr bgcolor="#D9E5FF" align="center" height="120%">
							<td>순서</td>
							<td>정산대상일</td>
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
							for(int i = 0; i < s_listSize; i++) {
								Bean_Mng_l bean = l_vlist.get(i);
								numb = bean.getNumb();
								String l_date = bean.getMng_date();
								String l_code = bean.getMng_code();
								String l_name = bean.getMng_name();
								String exp = bean.getMng_exp();
								int pack = bean.getMng_pack();
								int piece = bean.getMng_piece();
								int total = bean.getMng_total();
								String note = bean.getMng_note();
								String check = bean.getMng_check();
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