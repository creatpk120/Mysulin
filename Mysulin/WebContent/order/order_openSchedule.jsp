<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Stock_l"%>
<%@ page import="mysulin.Bean_Schedule"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	int totalRecord = 0;	//전체 레코드 수
	int listSize = 0;		//현재 읽어온 스케쥴 자료 수
	int s_listSize = 0;		//현재 읽어온 재고 리스트 자료 수
	Vector<Bean_Schedule> vlist  = null;
	Vector<Bean_Stock_l> s_vlist = null;
	String usid = (String)session.getAttribute("idKey");

	//검색 기능
	String check = request.getParameter("check");
	if(check == null) check = "S";
	Bean_Admin aBean = myMgr.getMember(usid);	//회원자료 가져오기
	check = aBean.getAuth();
	int numb = 0;
	String keyWord = "", keyField = "";
	if(request.getParameter("keyWord") != null) {
		keyWord = request.getParameter("keyWord");		//검색어
		keyField = request.getParameter("keyField");	//검색분류
		check = "B";
	}
	totalRecord = myMgr.getScheduleCount(check, keyWord, keyField, usid);

	//오늘 날짜 재고 불러와서 스케쥴에 넣기(임의 지정 날짜)
	SimpleDateFormat date_format = new SimpleDateFormat("yyyy-MM-dd");	//데이터 포맷
	String st_fakeToday = "2023-05-22";	//문자형 날짜: 오늘 날짜 임의 지정
	s_vlist = myMgr.getStockLList3(st_fakeToday);
	s_listSize = s_vlist.size();		//처리할 자료 수
	for(int i = 0; i < s_listSize; i++) {
		Bean_Stock_l bean = s_vlist.get(i);
		String s_date = bean.getStock_date();
		String s_code = bean.getStock_code();
		String s_name = bean.getStock_name();
		int s_total = bean.getStock_total();
		/* System.out.println(s_date);
		System.out.println(s_code + "_" + s_name);
		System.out.println("총량 : " + s_total);
		System.out.println(); */
		
		vlist = myMgr.getScheduleList2(s_code, s_name);
		listSize = vlist.size();
		for(int j = 0; j < listSize; j++) {
			Bean_Schedule l_bean = vlist.get(j);
			/* numb = bean.getNumb();
			int numb1 = bean.getNumb(); */
			String rx_code = l_bean.getRx_code();
			String rx_name = l_bean.getRx_name();
			int st_amnt = l_bean.getSt_amnt();
		}
		myMgr.updateScheduleStock(s_code, s_name, s_total);
	}
%>

<html>
<head>
	<title>order_openSchedule</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function Search() {
		if(document.searchFrm.keyWord.value == "") {
			document.searchFrm.numb1.value=0;
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.numb1.value=0;
		document.searchFrm.action="order_openSchedule.jsp";
		document.searchFrm.submit();
	}
	
	function enterKey() {
		if(window.event.keyCode == 13) {
			Search();
		}
	}
</script>
</head>

<body bgcolor="#F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/>
		<h2>내원 일정 현황</h2>
		<br/>
		
		<form name="searchFrm" method="get" action="order_openSchedule.jsp">
			<table width="600" cellpadding="4" cellspacing="0">
				<tr>
					<td align="center" valign="bottom">
						<select name="keyField" size="1">
							<option value="rx_code">인슐린 코드</option>
							<option value="rx_name">인슐린 이름</option>
						</select>
						<input type="text" size="16" name="keyWord" onkeypress="if(event.keyCode == 13){enterKey();}">
						<input type="button" value="검색" onClick="Search()">
						<input type="hidden" name="numb1">
					</td>
				</tr>
			</table>
		</form>
		
		<table align="center" width="800" border="1">
			<tr>
				<td bgcolor="#D9E5FF">
					&nbsp;&nbsp;내원 일정 관리 수 : <%=totalRecord%>
					<br/>&nbsp;&nbsp;현재 가상 날짜(재고 연결) : <%=st_fakeToday%>
				</td>
			</tr>
		</table>
		<table align="center" width="800" cellpadding="3" border="1">
			<tr>
				<td align="center" colspan="3">
				<%
					vlist = myMgr.getScheduleList(check, keyWord, keyField, usid);
					listSize = vlist.size();	//브라우저 화면에 보여질 자료의 수
					if(vlist.isEmpty()) {
						out.println("등록된 자료가 없습니다.");
					} else {
				%>
					<table width="100%" cellpadding="2" cellspacing="0" border="1">
						<tr bgcolor="#D9E5FF" align="center" height="120%">
							<td>번호</td>
							<td>차트번호</td>
							<td>환자성명</td>
							<td>인슐린코드</td>
							<td>인슐린이름</td>
							<td>처방량</td>
							<td>재고량</td>
							<td>처방일</td>
							<td>다음내원일</td>
							<td>비고</td>
						</tr>
						<%
							for(int i = 0; i < listSize; i++) {
								Bean_Schedule bean = vlist.get(i);
								numb = bean.getNumb();
								int numb1 = bean.getNumb();
								String chart_numb = bean.getChart_numb();
								String chart_name = bean.getChart_name();
								String rx_code = bean.getRx_code();
								String rx_name = bean.getRx_name();
								int rx_amnt = bean.getRx_amnt();
								int rx_date = bean.getRx_date();
								String rx_next = bean.getRx_next();
								String note = bean.getNote();
								int st_amnt = bean.getSt_amnt();
						%>
						<tr>
							<td align="center"><%=numb%></td>
							<td align="center"><%=chart_numb%></td>
							<td align="center"><%=chart_name%></td>
							<td align="center"><%=rx_code%></td>
							<td align="center"><%=rx_name%></td>
							<td align="center"><%=rx_amnt%></td>
							<td align="center" bgcolor="#E2E8F9"><%=st_amnt%></td>
							<td align="center"><%=rx_date%>일</td>
							<td align="center"><%=rx_next%></td>
							<td align="center"><%=note%></td>
						</tr>
						<%	}//for%>
					</table> <%
					}//if
				%>
				</td>
			</tr>
		</table>
		<br/><a href="#" onClick="self.close()" style="font-size:1.2em">[닫기]</a>
	</div>
</body>
</html>