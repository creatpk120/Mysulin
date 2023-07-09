<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Order_a"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	int totalRecord = 0;	//전체 레코드 수
	int listSize = 0;		//현재 읽어온 자료 수
	Vector<Bean_Order_a> vlist = null;
	
	String usid = (String)session.getAttribute("idKey");
	int numb = 0;
%>

<html>
<head>
	<title>orderAgnt</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function orderAgntUpdate(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="orderAgntUpdate.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function orderAgntDel(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="orderAgntDel.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
</script>
</head>

<body bgcolor="#F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/>
		<h2>거래처 정보</h2>
		<br/>
		
		<table align="center" width="800" cellpadding="3" border="1">
			<tr>
				<td align="center" colspan="3">
				<%
					vlist = myMgr.getOrderAngtList(usid);
						listSize = vlist.size();	//브라우저 화면에 보여질 자료 수
						if(vlist.isEmpty()) {
							out.println("등록된 자료가 없습니다.");
						} else {
				%>
					<table width="100%" cellpadding="2" cellspacing="0" border="1">
						<tr bgcolor="#D9E5FF" align="center" height="120%">
							<td>거래처</td>
							<td>담당자</td>
							<td>전화번호</td>
							<td>Email</td>
							<td>우편번호</td>
							<td>상세주소</td>
							<td>비고</td>
							<td>수 정</td>
							<td>삭 제</td>
						</tr>
						<%
							for(int i = 0; i < listSize; i++) {
								Bean_Order_a bean = vlist.get(i);
								numb = bean.getNumb();
								String agnt = bean.getAgnt();
								String name = bean.getName();
								String telp = bean.getTelp();
								String mail = bean.getMail();
								String post = bean.getPost();
								String addr = bean.getAddr();
								String note = bean.getNote();
						%>
						<tr>
							<td align="center"><%=agnt%></td>
							<td align="center"><%=name%></td>
							<td align="center"><%=telp%></td>
							<td align="center"><%=mail%></td>
							<td align="center"><%=post%></td>
							<td align="center"><%=addr%></td>
							<td align="center"><%=note%></td>
							<td align="center">
								<a href="javascript:orderAgntUpdate('<%=numb%>')">수정</a>
							</td>
							<td align="center">
								<a href="javascript:orderAgntDel('<%=numb%>')">삭제</a>
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
			<input type="button" value="추가하기" onClick="location.href='orderAgntWrite.jsp'"> &nbsp;&nbsp;
			<input type="button" value="뒤로가기" onClick="location.href='orderCheck.jsp?numb=0'"> &nbsp;&nbsp;
			<input type="hidden" name="numb">
		</form>
	</div>
</body>

</html>