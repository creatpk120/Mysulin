<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	Bean_Admin aBean = myMgr.getMember(usid);		//회원자료 가져오기
	String auth = null;
	if(usid != null) {
		auth = aBean.getAuth();
	}

	String cPath = request.getContextPath();
	String url1 = "../admin/memberJoin.jsp";
	String url2 = "../main/main.jsp";
	String url3 = "../main/main.jsp";
	String url4 = "../main/main.jsp";
	String url5 = "../main/main.jsp";
	String url6 = "../main/main.jsp";
	String label = "회원가입";
	
	if(usid == null) {
		label = "회원가입";
	} else if(auth.equals("S")) {
		url1 = "../admin/memberList.jsp?numb=0";
		url2 = "../main/mng_db.jsp";
		url3 = "../main/mng_calc.jsp";
		url4 = "../schedule/scheduleList.jsp?numb1=0";
		url5 = "../order/orderCheck.jsp?numb=0";
		url6 = "../order/orderPage_selectAgnt.jsp";
		label = "전체회원";
	} else if(auth.equals("A")) {
		url1 = "../admin/memberList.jsp?numb=0";
		url2 = "../main/mng_db.jsp";
		url3 = "../main/mng_calc.jsp";
		url4 = "../schedule/scheduleList.jsp?numb1=0";
		url5 = "../order/orderCheck.jsp?numb=0";
		url6 = "../order/orderPage_selectAgnt.jsp";
		label = "회원수정";
	} else if(auth.equals("B")) {
		url1 = "../admin/memberUpdate.jsp?numb=0";
		url2 = "../main/main.jsp";
		url3 = "../main/main.jsp";
		url4 = "../main/main.jsp";
		url5 = "../main/main.jsp";
		url6 = "../main/main.jsp";
		label = "회원수정";
	}
%>

<html>
<head>
	<title>left</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#D9E5FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/><br/>
		<font size="3"><a href="<%=url1%>" target="content"><b><%=label%></b></a></font><br><br>
		<font size="3"><a href="<%=url2%>" target="content"><b>데이터관리</b></a></font><br><br>
		<hr color="F8F0FF"><br/>
		<font size="3"><a href="<%=url3%>" target="content"><b>정산하기</b></a></font><br><br>
		<font size="3"><a href="<%=url4%>" target="content"><b>일정관리</b></a></font><br><br>
		<font size="3"><a href="<%=url5%>" target="content"><b>발주관리</b></a></font><br><br>
		<font size="3"><a href="<%=url6%>" target="content"><b>발주하기</b></a></font><br><br>
	</div>
</body>
</html>