<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Code"%>
<%@ page import="mysulin.Bean_Order_l"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String agnt_name = request.getParameter("agnt_value");
	if(agnt_name == null) agnt_name = "A제약";
	
 	Vector<Bean_Code> vlist = null;
	int listSize = 0;			//현재 읽어온 자료의 수
	vlist = myMgr.getOrderKeyWord("B제약");
	listSize = vlist.size();	//브라우저 화면에 보여질 자료의 수
	for(int i = 0; i < listSize; i++) {
		Bean_Code bean = vlist.get(i);
		String code = bean.getCode();
		String name = bean.getName();
		//System.out.println(code + "_" + name);
	}
%>

<html>
<head>
	<title>orderPage</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	/* function chageSelectedValue(){
		var yourTestSelect = document.getElementById("TestSelect");

		// select element에서 선택된 option의 value가 저장됩니다.
		var selectedValue = yourTestSelect.options[yourTestSelect.selectedIndex].value;

		// select element에서 선택된 option의 text가 저장됩니다.
		var selectedText = yourTestSelect.options[yourTestSelect.selectedIndex].text;
	} */
	
	
	function orderAgntChange(){
		var orderAgnt_select = document.getElementById("agnt_select");

		// select element에서 선택된 option의 value가 저장됩니다.
		var selectedValue = orderAgnt_select.options[orderAgnt_select.selectedIndex].value;

		// select element에서 선택된 option의 text가 저장됩니다.
		var selectedText = orderAgnt_select.options[orderAgnt_select.selectedIndex].text;
			document.hiddFrm.agnt_value.value=selectedText;
			document.hiddFrm.submit();
	}
</script>
</head>

<body bgcolor="#F0F8FF" onLoad="regFrm.인슐린선택.focus()">
	<div align="center">
		<br/><br/>
		<form name="regFrm" method="post" action="orderPageProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td align="center" valign="middle" bgcolor="#F0F8FF">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr align="center" bgcolor="#6495ED">
								<td colspan="3"><font color="#FFFFFF"><b>인슐린 발주서</b></font></td>
							</tr>
							<tr>
								<td>연습</td>
								<td>
									<select id="TestSelect" name="SelectValue" onchange="chageLangSelect()">
										<option value="" selected disabled>Choose your value</option>              
										<option value="val01">YourValue01</option>
										<option value="val02">YourValue02</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>제약회사 선택</td>
								<td>
									<select name="all_insulin" id="agnt_select" onchange="orderAgntChange()">
										<option value="0" selected disabled>선택하세요.
								<%
									Vector<Bean_Code> vlist1 = null;
									int listSize1 = 0;			//현재 읽어온 자료의 수
									vlist1 = myMgr.getOrderKeyWord("all_insulin");
									listSize1 = vlist1.size();	//브라우저 화면에 보여질 자료의 수
									if(vlist1.isEmpty()) {
										out.println("등록된 자료가 없습니다.");
									} else {
										for(int i = 0; i < listSize1; i++) {
											Bean_Code bean = vlist1.get(i);
											String c_agnt = bean.getAgnt();
											String c_code = bean.getCode();
											String c_name = bean.getName(); %>
											<option value="<%=c_agnt%>"> <%=c_agnt%>_<%=c_name%>
									<%	}
									}%>
								</select></td>
								<script>document.regFrm.all_insulin.value="<%=agnt_name.substring(0,3)%>"</script>
							</tr>
							<%-- <tr>
								<td>인슐린 선택</td>
								<td><select name="order_code">
										<option value="0" selected disabled>선택하세요.
								<%
									Vector<Bean_Code> vlist2 = null;
									int listSize2 = 0;			//현재 읽어온 자료의 수
									//System.out.println("구분값2 : " + m_gubn_y);
                  					//System.out.println("구분값3 : " + m_gubn_y.substring(0,2));
                  					//System.out.println(m_gubn_y.substring(0,2));
				  					vlist2 = myMgr.getMoimList(m_gubn_y.substring(0,2));
									//vlist2 = moimMgr.getMoimList("XX");
									listSize2 = vlist2.size();	//브라우저 화면에 보여질 자료의 수
									if(vlist2.isEmpty()) {
										out.println("등록된 자료가 없습니다.");
									} else {
										for(int i = 0; i < listSize2; i++) {
											Bean_Code bean = vlist2.get(i);
											String i_code = bean.getM_code();
											String i_name = bean.getM_name(); %>
											<option value="<%=m_code%>"> <%=m_name%>
									<%	}
									}%>
								</select></td>
								<td>모임을 선택하세요.</td>
							</tr> --%>
							<tr>
								<td colspan="3" align="center">
									<input type="button" value="회원가입" onClick="joinCheck()"> &nbsp;&nbsp;
									<input type="reset" value="다시쓰기"> &nbsp;&nbsp;
									<input type="button" value="뒤로가기" onClick="history.go(-1)">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<form name="hiddFrm" method="get">
			<input type="hidden" name="m_gubn_v">
		</form>
	</div>
</body>
</html>