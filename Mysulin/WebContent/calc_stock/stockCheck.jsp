<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Code"%>
<%@ page import="mysulin.Bean_Stock_c"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String perm1 = request.getParameter("perm1");	//점검상태
	String perm2 = request.getParameter("perm2");	//클릭여부
	int recnum = Integer.parseInt(request.getParameter("numb"));

	if(perm1 == null) perm1 = "Z";
	if(perm2 == null) perm2 = "Z";
	if(perm2.equals("GG"))
		myMgr.updateStockPerm(recnum, perm1);

	int totalRecord = 0;	//전체 레코드 수
	int listSize = 0;		//현재 읽어온 자료 수
	Vector<Bean_Stock_c> vlist = null;
	
	String usid = (String)session.getAttribute("idKey");
	int numb = 0;
	totalRecord = myMgr.getStockCCount(usid);
%>

<html>
<head>
	<title>stockCheck</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function stockCheckUpdate(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="stockCheckUpdate.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function stockCheckDel(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="stockCheckDel.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function stockCheck_perm(numb, check) {
		document.readFrm.numb.value=numb;
		document.readFrm.perm1.value=check;
		document.readFrm.perm2.value="GG";
		document.readFrm.action="stockCheck.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function stockList_c(numb){
		document.readFrm.numb.value=numb;
		document.readFrm.action="stockList_c.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function stockList(numb){
		document.readFrm.numb.value=numb;
		document.readFrm.numb1.value=0;
		document.readFrm.action="stockList.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
</script>
</head>

<body bgcolor="#F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/>
		<h2>일별 재고 목록</h2>
		<br/>
		<table align="center" width="800" border="1">
			<tr>
				<td bgcolor="#D9E5FF">&nbsp;&nbsp;재고 점검 횟수 : <%=totalRecord%></td>
			</tr>
		</table>
		<table align="center" width="800" cellpadding="3" border="1">
			<tr>
				<td align="center" colspan="3">
				<%
					vlist = myMgr.getStockCList(usid);
						listSize = vlist.size();	//브라우저 화면에 보여질 자료 수
						if(vlist.isEmpty()) {
							out.println("등록된 자료가 없습니다.");
						} else {
				%>
					<table width="100%" cellpadding="2" cellspacing="0" border="1">
						<tr bgcolor="#D9E5FF" align="center" height="120%">
							<td>순서</td>
							<td>담당자</td>
							<td>재고점검일</td>
							<td>점검여부</td>
							<td>목 록</td>
							<td>점 검</td>
							<td>수 정</td>
							<td>삭 제</td>
						</tr>
						<%
							for(int i = 0; i < listSize; i++) {
								Bean_Stock_c bean = vlist.get(i);
								numb = bean.getNumb();
								String usid1 = bean.getS_usid();
								String date = bean.getS_date();
								String check = bean.getS_check();
						%>
						<tr>
							<td align="center"><%=numb%></td>
							<td align="center"><%=usid1%></td>
							<td align="center"><%=date%></td>
							<td align="center">
								<a href="javascript:stockCheck_perm('<%=numb%>','<%=check%>')"><%=check%></a>
							</td>
							<td align="center">
								<a href="javascript:stockList_c('<%=numb%>')">목록생성</a>
							</td>
							<td align="center">
								<a href="javascript:stockList('<%=numb%>')">점검하기</a>
							</td>
							<td align="center">
								<a href="javascript:stockCheckUpdate('<%=numb%>')">수정</a>
							</td>
							<td align="center">
								<a href="javascript:stockCheckDel('<%=numb%>')">삭제</a>
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
			<input type="button" value="신규점검등록" onClick="location.href='stockCheckWrite.jsp'"> &nbsp;&nbsp;
			<input type="hidden" name="numb">
			<input type="hidden" name="numb1">
			<input type="hidden" name="perm1">
			<input type="hidden" name="perm2">
		</form>
	</div>
</body>

</html>