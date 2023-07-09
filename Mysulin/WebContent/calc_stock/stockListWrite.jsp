<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Stock_l"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String usid = (String)session.getAttribute("idKey");
	int numb  = Integer.parseInt(request.getParameter("numb"));		//stockCheck
	int numb1 = Integer.parseInt(request.getParameter("numb1"));	//stockList_target
	System.out.println("- 리스트에 싱글 데이터 추가 -");
	System.out.println("stockCheck numb  : " + numb);
	System.out.println("stockList numb1 : " + numb1);

/* 	Bean_Stock_l bean = myMgr.getStockL(numb1);		//삭제할 자료 가져오기
	String date = bean.getStock_date();
	String code = bean.getStock_code();
	String name = bean.getStock_name(); */
	
	Bean_Stock_l lBean = myMgr.getStockL(numb1);
%>

<html>
<head>
	<title>stockListWrite</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function writeCheck(numb) {
		document.stockFrm.recnumb.value=numb;
		document.stockFrm.action = "stockListWriteProc.jsp";
		document.stockFrm.submit();
	}
</script>
</head>

<body bgcolor="#F0F8FF" onLoad="stockFrm.stock_exp.focus()">
	<div align="center">
		<br/><br/>
		<form name="stockFrm" method="post" action="stockListWriteProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td bgcolor="#F0F8FF" align="center" valign="middle">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr bgcolor="#6495ED" align="center">
								<td align="center" colspan="3"><font color="#FFFFFF"><b>재고 목록 등록</b></font></td>
							</tr>
							<tr>
								<td>담당자</td>
								<td><input name="stock_usid" size="15" value="<%=usid%>" readonly></td>
							</tr>
							<tr>
								<td>재고점검일</td>
								<td><input type="date" name="stock_date" size="15"
									value="<%=lBean.getStock_date()%>" readonly></td>
							</tr>
							<tr>
								<td>인슐린코드</td>
								<td><input name="stock_code" size="15"
									value="<%=lBean.getStock_code()%>" readonly></td>
							</tr>
							<tr>
								<td>인슐린이름</td>
								<td><input name="stock_name" size="15"
									value="<%=lBean.getStock_name()%>" readonly></td>
							</tr>
							<tr>
								<td>유통기한</td>
								<td><input type="date" name="stock_exp" size="15"
									value="<%=lBean.getStock_exp()%>"></td>
							</tr>
							<tr>
								<td>박스</td>
								<td><input name="stock_pack" size="15"
									value="<%=lBean.getStock_pack()%>"></td>
							</tr>
							<tr>
								<td>낱개</td>
								<td><input name="stock_piece" size="15"
									value="<%=lBean.getStock_piece()%>"></td>
							</tr>
							<%-- <tr>
								<td>총량</td>
								<td><input name="stock_total" size="15"
									value="<%=lBean.getStock_total()%>"></td>
							</tr> --%>
							<tr>
								<td>비고</td>
								<td><input name="stock_note" size="30"
									value="<%=lBean.getStock_note()%>"></td>
							</tr>
							<tr>
								<td>점검</td>
								<td><input name="stock_check" size="15"
									value="<%=lBean.getStock_check()%>" readonly></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
									<input type="button" value="재고등록" onClick="writeCheck(<%=numb%>)"> &nbsp;&nbsp;
									<input type="reset" value="다시쓰기"> &nbsp;&nbsp;
									<input type="button" value="뒤로가기" onClick = "history.go(-1)">
									<input type="hidden" name="recnumb">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>

</html>