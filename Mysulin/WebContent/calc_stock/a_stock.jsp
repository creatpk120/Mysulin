<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Code"%>
<%@ page import="mysulin.Bean_Stock"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	int totalRecord = 0;	//전체 레코드 수
	int listSize = 0;		//현재 읽어온 자료 수
	Vector<Bean_Stock> vlist = null;
	
	String usid = (String)session.getAttribute("idKey");
	int numb = 0;
	totalRecord = myMgr.getStockCount(usid);
	
	//인슐린별 총량 계산
	vlist = myMgr.getStockList(usid);
	listSize = vlist.size();
	for(int i = 0; i < listSize; i++) {
		Bean_Stock bean = vlist.get(i);
		int numb1 = bean.getNumb();
		String code = bean.getStock_code();
		int pack = bean.getStock_pack();
		int piece = bean.getStock_piece();
		int total = 0;
		String bundle = code.substring(1,2);
		/* System.out.println(code);
		System.out.println(bundle); */
		if(bundle.equals("2")) {
			total = pack * 2 + piece;
		} else if(bundle.equals("3")) {
			total = pack * 3 + piece;
		} else if(bundle.equals("5")) {
			total = pack * 5 + piece;
		}
		myMgr.updateTotal(numb1, total);
	}
	
	vlist = myMgr.getStockList(usid);
	listSize = vlist.size();
%>

<html>
<head>
	<title>stock</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function stockUpdate(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="a_stockUpdate.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function stockDel(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="a_stockDel.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
</script>
</head>

<body bgcolor="#F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/>
		<h2>인슐린 재고 목록</h2>
		<br/>
		<table align="center" width="800" border="1">
			<tr>
				<td bgcolor="#D9E5FF">&nbsp;&nbsp;자료 수 : <%=totalRecord%></td>
			</tr>
		</table>
		<table align="center" width="800" cellpadding="3" border="1">
			<tr>
				<td align="center" colspan="3">
				<%
					//vlist = myMgr.getStockList(usid);
					//listSize = vlist.size();	//브라우저 화면에 보여질 자료 수
					if(vlist.isEmpty()) {
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
							<td>수 정</td>
							<td>삭 제</td>
						</tr>
						<%
							for(int i = 0; i < listSize; i++) {
								Bean_Stock bean = vlist.get(i);
								numb = bean.getNumb();
								String date = bean.getStock_date();
								String code = bean.getStock_code();
								String name = bean.getStock_name();
								String exp = bean.getStock_exp();
								int pack = bean.getStock_pack();
								int piece = bean.getStock_piece();
								int total = bean.getStock_total();
								String note = bean.getStock_note();
						%>
						<tr>
							<td align="center"><%=numb%></td>
							<td align="center"><%=date%></td>
							<td align="center"><%=code%></td>
							<td align="center"><%=name%></td>
							<td align="center"><%=exp%></td>
							<td align="center"><%=pack%></td>
							<td align="center"><%=piece%></td>
							<td align="center"><%=total%></td>
							<td align="center"><%=note%></td>
							<td align="center">
								<a href="javascript:stockUpdate('<%=numb%>')">수정</a>
							</td>
							<td align="center">
								<a href="javascript:stockDel('<%=numb%>')">삭제</a>
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
			<input type="button" value="재고등록" onClick="location.href='a_stockWrite.jsp'"> &nbsp;&nbsp;
			<input type="hidden" name="numb">
		</form>
	</div>
</body>

</html>