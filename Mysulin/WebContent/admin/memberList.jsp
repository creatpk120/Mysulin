<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String check = request.getParameter("check");
	String perm1 = request.getParameter("perm1");	//권한상태
	String perm2 = request.getParameter("perm2");	//클릭여부
	int recnum = Integer.parseInt(request.getParameter("numb"));
	
	if(check == null) check = "S";
	if(perm1 == null) perm1 = "Z";
	if(perm2 == null) perm2 = "Z";
	if(perm2.equals("GG"))
		myMgr.updatePerm(recnum, perm1);
	
	int totalRecord = 0;	//전체 레코드 수
	int listSize = 0;		//현재 읽어온 게시물의 수
	Vector<Bean_Admin> vlist = null;
	
	String usid = (String)session.getAttribute("idKey");
	Bean_Admin aBean = myMgr.getMember(usid);		//회원자료 가져오기
	String auth = aBean.getAuth();
	int numb = aBean.getNumb();
	
	totalRecord = myMgr.getTotalCount(check);
%>

<html>
<head>
	<title>memberList</title>
	<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function memberUpdate(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="memberUpdate.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
	
	function memberList_auth(numb, auth) {
		document.readFrm.numb.value=numb;
		document.readFrm.perm1.value=auth;
		document.readFrm.perm2.value="GG";
		document.readFrm.action="memberList.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
	
	function memberDel(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="memberDel.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
</script>
</head>

<body bgcolor="F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/><h2>회원 명단</h2><br/>
		<table align="center" width="800" border="1">
			<tr>
				<td bgcolor="#D9E5FF"> &nbsp;&nbsp;회원수 : <%=totalRecord%></td>
			</tr>
		</table>
		<table align="center" width="800" cellpadding="3" border="1">
			<tr>
				<td align="center" colspan="3">
				<%
					vlist = myMgr.getMemberList(check);
					listSize = vlist.size();	//브라우저 화면에 보여질 게시물 번호
					if(vlist.isEmpty()) {
						out.println("등록된 게시물이 없습니다.");
					} else {
				%>
					<table width="100%" cellpadding="2" cellspacing="0" border="1">
						<tr align="center" bgcolor="#D9E5FF" height="120%">
							<td>번호</td>
							<td>아이디</td>
							<td>회원권한</td>
							<td>회원권한</td>
							<td>이름</td>
							<td>내선번호</td>
							<td>전화번호</td>
							<td>수 정</td>
							<td>삭 제</td>
						</tr>
						<%
							for(int i = 0; i < listSize; i++) {
								if(i == listSize) break;
								Bean_Admin bean = vlist.get(i);
								numb = bean.getNumb();
								usid = bean.getUsid();
								auth = bean.getAuth();
								String gu = null;
								if(auth.equals("S")) {gu = "관리자";}
								else if(auth.equals("A")) {gu = "일반회원";}
								else {gu = "임시회원";}
								String name = bean.getName();
								String telp = bean.getTelp();
								String phone = bean.getPhone();
						%>
						<tr>
							<td align="center"><%=numb%></td>
							<td align="center"><%=usid%></td>
							<td align="center">
								<a href="javascript:memberList_auth('<%=numb%>', '<%=auth%>')"><%=auth%></a>
							</td>
							<td align="center"><%=gu%></td>
							<td align="center"><%=name%></td>
							<td align="center"><%=telp%></td>
							<td align="center"><%=phone%></td>
							<td align="center">
								<a href="javascript:memberUpdate('<%=numb%>')">수정</a>
							</td>
							<td align="center">
								<a href="javascript:memberDel('<%=numb%>')">삭제</a>
							</td>
						</tr>
						<%	}%>
					</table> <%
					} %>
				</td>
			</tr>
		</table>
		<form name="readFrm" method="get">
			<br/>
			<input type="button" value="신규회원" onClick="location.href='memberJoin.jsp'"> &nbsp;&nbsp;
			<input type="button" value="전체회원" onClick="location.href='memberList.jsp?check=S&numb=0'"> &nbsp;&nbsp;
			<input type="button" value="일반회원" onClick="location.href='memberList.jsp?check=A&numb=0'"> &nbsp;&nbsp;
			<input type="button" value="임시회원" onClick="location.href='memberList.jsp?check=B&numb=0'"> &nbsp;&nbsp;
			<input type="hidden" name="numb">
			<input type="hidden" name="perm1">
			<input type="hidden" name="perm2">
		</form>
	</div>
	
</body>
</html>