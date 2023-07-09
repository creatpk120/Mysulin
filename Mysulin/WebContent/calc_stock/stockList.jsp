<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Code"%>
<%@ page import="mysulin.Bean_Stock_c"%>
<%@ page import="mysulin.Bean_Stock_l"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	int listSize = 0;		//현재 읽어온 자료 수
	Vector<Bean_Stock_l> vlist = null;
	
	String usid = (String)session.getAttribute("idKey");
	int recnum = Integer.parseInt(request.getParameter("numb1"));
	int numb   = Integer.parseInt(request.getParameter("numb"));

	Bean_Stock_c cBean = myMgr.getStockC(numb);
    String date = cBean.getS_date();
    
    String perm1 = request.getParameter("perm1");	//점검상태
	String perm2 = request.getParameter("perm2");	//클릭여부
	if(perm1 == null) perm1 = "Z";
	if(perm2 == null) perm2 = "Z";
	if(perm2.equals("GG1"))
		myMgr.updateStockListPerm(recnum, perm1);
	if(perm2.equals("GG2"))
		myMgr.updateStockListPermAll(perm1);
	
	//인슐린별 총량 계산
	vlist = myMgr.getStockLList1(date);
	listSize = vlist.size();
	for(int i = 0; i < listSize; i++) {
		Bean_Stock_l bean = vlist.get(i);
		int numb1 = bean.getNumb();
		String code = bean.getStock_code();
		int pack = bean.getStock_pack();
		int piece = bean.getStock_piece();
		int total = 0;
		String check = bean.getStock_check();
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
		myMgr.updateListTotal(numb1, total);
	}
	
	vlist = myMgr.getStockLList1(date);
	listSize = vlist.size();
%>

<html>
<head>
	<title>stockList</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function stockListUpdate(numb, numb1) {
		document.readFrm.numb.value=numb;
		document.readFrm.numb1.value=numb1;
		document.readFrm.action="stockListUpdate.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function stockListDel(numb, numb1) {
		document.readFrm.numb.value=numb;
		document.readFrm.numb1.value=numb1;
		document.readFrm.action="stockListDel.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
	
	function stockList_perm(numb, numb1, check) {
		document.readFrm.numb.value=numb;
		document.readFrm.numb1.value=numb1;
		document.readFrm.perm1.value=check;
		document.readFrm.perm2.value="GG1";
		document.readFrm.action="stockList.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
	
	function stockList_permAll(numb, check) {
		document.readFrm.numb.value=numb;
		document.readFrm.perm1.value=check;
		document.readFrm.perm2.value="GG2";
		document.readFrm.action="stockList.jsp";
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
				<td bgcolor="#D9E5FF">&nbsp;※ 개별 재고 점검을 완료하세요.</td>
			</tr>
		</table>
		<table align="center" width="800" cellpadding="3" border="1">
			<tr>
				<td align="center" colspan="3">
				<%
					//vlist = myMgr.getStockLList1(date);
					//listSize = vlist.size();	//브라우저 화면에 보여질 자료 수
					if(vlist.isEmpty()) {
						out.println("등록된 자료가 없습니다.");
					} else {
				%>
					<table width="100%" cellpadding="2" cellspacing="0" border="1">
						<tr bgcolor="#D9E5FF" align="center" height="120%">
							<td>순서</td>
							<td>재고점검일</td>
							<td>인슐린코드</td>
							<td>인슐린이름</td>
							<td>유통기한</td>
							<td>박스</td>
							<td>낱개</td>
							<td>총량</td>
							<td>비고</td>
							<td>점 검</td>
							<%-- <td align="center">
								<a href="javascript:stockList_permAll('<%=numb%>','<%=check%>')">점 검</a>
							</td> --%>
							<td>수 정</td>
							<td>삭 제</td>
						</tr>
						<%
							for(int i = 0; i < listSize; i++) {
								Bean_Stock_l bean = vlist.get(i);
								int numb1 = bean.getNumb();
								String l_date = bean.getStock_date();
								String code = bean.getStock_code();
								String name = bean.getStock_name();
								String exp = bean.getStock_exp();
								int pack = bean.getStock_pack();
								int piece = bean.getStock_piece();
								int total = bean.getStock_total();
								String note = bean.getStock_note();
								String check = bean.getStock_check();
						%>
						<tr>
							<td align="center"><%=numb1%></td>
							<td align="center"><%=date%></td>
							<td align="center"><%=code%></td>
							<td align="center"><%=name%></td>
							<td align="center"><%=exp%></td>
							<td align="center"><%=pack%></td>
							<td align="center"><%=piece%></td>
							<td align="center"><%=total%></td>
							<td align="center"><%=note%></td>
							<td align="center">
								<a href="javascript:stockList_perm('<%=numb%>','<%=numb1%>','<%=check%>')"><%=check%></a>
							</td>
							<td align="center">
								<a href="javascript:stockListUpdate('<%=numb%>','<%=numb1%>')">수정</a>
							</td>
							<td align="center">
								<a href="javascript:stockListDel('<%=numb%>','<%=numb1%>')">삭제</a>
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
			<input type="button" value="뒤로가기" onClick="location.href='stockCheck.jsp?numb=<%=numb%>'"> &nbsp;&nbsp;
			<input type="button" value="인쇄하기" id="print" onClick="window.print()"> &nbsp;&nbsp;
			<input type="button" value="일괄완료" onClick="">
			<input type="hidden" name="numb">
			<input type="hidden" name="numb1">
			<input type="hidden" name="perm1">
			<input type="hidden" name="perm2">
		</form>
	</div>
</body>

</html>