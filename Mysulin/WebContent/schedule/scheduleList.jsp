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

	//다음 내원일 업데이트
	//클릭 기능
	String perm1 = request.getParameter("perm1");	//권한상태
	String perm2 = request.getParameter("perm2");	//클릭여부
	int recnum = Integer.parseInt(request.getParameter("numb1"));
	if(perm1 == null) perm1 = "Z";
	if(perm2 == null) perm2 = "Z";
	if(perm2.equals("GG")) {
		
		//날짜 계산 기능
		SimpleDateFormat date_format = new SimpleDateFormat("yyyy-MM-dd");	//데이터 포맷
//		String st_fakeToday = "2023-05-23";	//문자형 날짜: 오늘 날짜 임의 지정
		Date st_date = null;				//문자형 날짜: 처방일수(ex.90일)
		Date st_next = null;				//문자형 날짜: 다음 내원일
	
 		Bean_Schedule sBean = myMgr.getSchedule(recnum);
		int r_date = sBean.getRx_date();				//처방일수
		String rx_next = sBean.getRx_next();			//다음 내원일(처방일 더하기 전)
		System.out.println(recnum + "번. 현재 내원일 : " + rx_next + "(" + r_date + "일)");
		
		st_next = date_format.parse(rx_next);			//형변환: 문자형 → 날짜형
	
		st_next.setDate(st_next.getDate() + r_date);	//다음 내원일(처방일 더하기)
		String rx_next1 = date_format.format(st_next).substring(0, 10);	//형변환: 날짜형 → 문자형
		myMgr.updateScheduleDate(recnum, rx_next1);		//계산한 다음 내원일 업데이트
		System.out.println(recnum + "번. 변경 내원일 : " + rx_next1 + "(" + r_date + "일)");
	}
	
	//오늘 날짜 재고 불러와서 스케쥴에 넣기(임의 지정 날짜)
	SimpleDateFormat date_format = new SimpleDateFormat("yyyy-MM-dd");	//데이터 포맷
	String st_fakeToday = "2023-05-24";	//문자형 날짜: 오늘 날짜 임의 지정
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
	<title>scheduleList</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function scheduleUpdate(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="scheduleUpdate.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function scheduleDel(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="scheduleDel.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
		
	function Search() {
		if(document.searchFrm.keyWord.value == "") {
			document.searchFrm.numb1.value=0;
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.numb1.value=0;
		document.searchFrm.action="scheduleList.jsp";
		document.searchFrm.target="content";
		document.searchFrm.submit();
	}
	
	function enterKey() {
		if(window.event.keyCode == 13) {
			Search();
		}
	}
	
	function nextSchedule_perm(numb1, rx_next) {
		document.readFrm.numb1.value=numb1;
		document.readFrm.perm1.value=rx_next;
		document.readFrm.perm2.value="GG";
		document.readFrm.action="scheduleList.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
</script>
</head>

<body bgcolor="#F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/>
		<h2>내원 일정 관리</h2>
		<br/>
		
		<form name="searchFrm" method="get" action="scheduleList.jsp">
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
					<%-- <br/>&nbsp;&nbsp;현재 가상 날짜(재고 연결) : <%=st_fakeToday%> --%>
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
							<td>수 정</td>
							<td>삭 제</td>
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
							<td align="center">
								<a href="javascript:nextSchedule_perm('<%=numb1%>','<%=rx_next%>')"><%=rx_next%></a>
							</td>
							<td align="center"><%=note%></td>
							<td align="center">
								<a href="javascript:scheduleUpdate('<%=numb%>')">수정</a>
							</td>
							<td align="center">
								<a href="javascript:scheduleDel('<%=numb%>')">삭제</a>
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
			<br>
			<input type="button" value="일정등록" onClick="location.href='scheduleWrite.jsp'"> &nbsp;&nbsp;
			<input type="button" value="전체일정" onClick="location.href='scheduleList.jsp?check=All&numb1=0'"> &nbsp;&nbsp;
			<input type="hidden" name="numb">
			<input type="hidden" name="numb1">
			<input type="hidden" name="perm1">
			<input type="hidden" name="perm2">
		</form>
	</div>
</body>
</html>