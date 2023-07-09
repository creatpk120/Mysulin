<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Usage_c"%>
<%@ page import="mysulin.Bean_Usage_l"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	int listSize = 0;		//현재 읽어온 자료 수
	Vector<Bean_Usage_l> vlist = null;
	
	String usid = (String)session.getAttribute("idKey");
	int recnum = Integer.parseInt(request.getParameter("numb1"));
	int numb   = Integer.parseInt(request.getParameter("numb"));

	Bean_Usage_c cBean = myMgr.getUsageCheck(numb);
    String date = cBean.getU_date();
    
    String perm1 = request.getParameter("perm1");	//점검상태
	String perm2 = request.getParameter("perm2");	//클릭여부
	if(perm1 == null) perm1 = "Z";
	if(perm2 == null) perm2 = "Z";
	if(perm2.equals("GG"))
		myMgr.updateUsageListPerm(recnum, perm1);
%>

<html>
<head>
	<title>usageList</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function usageListUpdate(numb, numb1) {
		document.readFrm.numb.value=numb;
		document.readFrm.numb1.value=numb1;
		document.readFrm.action="usageListUpdate.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function usageListDel(numb, numb1) {
		document.readFrm.numb.value=numb;
		document.readFrm.numb1.value=numb1;
		document.readFrm.action="usageListDel.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
	
	function usageList_perm(numb, numb1, check) {
		document.readFrm.numb.value=numb;
		document.readFrm.numb1.value=numb1;
		document.readFrm.perm1.value=check;
		document.readFrm.perm2.value="GG";
		document.readFrm.action="usageList.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
</script>
</head>

<body bgcolor="#F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/>
		<h2>일별 처방 목록</h2>
		<br/>
		<table align="center" width="800" border="1">
			<tr>
				<td bgcolor="#D9E5FF">&nbsp;※ 개별 인슐린 처방 확인을 완료하세요.</td>
			</tr>
		</table>
		<table align="center" width="800" cellpadding="3" border="1">
			<tr>
				<td align="center" colspan="3">
				<%
					vlist = myMgr.getUsageLList(date);
					listSize = vlist.size();	//브라우저 화면에 보여질 자료 수
					if(vlist.isEmpty()) {
						out.println("등록된 자료가 없습니다.");
					} else {
				%>
					<table width="100%" cellpadding="2" cellspacing="0" border="1">
						<tr bgcolor="#D9E5FF" align="center" height="120%">
							<td>순서</td>
							<td>처방일</td>
							<td>인슐린코드</td>
							<td>인슐린이름</td>
							<td>처방량</td>
							<td>비고</td>
							<td>점 검</td>
							<td>수 정</td>
							<td>삭 제</td>
						</tr>
						<%
							for(int i = 0; i < listSize; i++) {
								Bean_Usage_l bean = vlist.get(i);
								int numb1 = bean.getNumb();
								String l_date = bean.getUsage_date();
								String code = bean.getUsage_code();
								String name = bean.getUsage_name();
								int total = bean.getUsage_total();
								String note = bean.getUsage_note();
								String check = bean.getUsage_check();
						%>
						<tr>
							<td align="center"><%=numb1%></td>
							<td align="center"><%=date%></td>
							<td align="center"><%=code%></td>
							<td align="center"><%=name%></td>
							<td align="center"><%=total%></td>
							<td align="center"><%=note%></td>
							<td align="center">
								<a href="javascript:usageList_perm('<%=numb%>','<%=numb1%>','<%=check%>')"><%=check%></a>
							</td>
							<td align="center">
								<a href="javascript:usageListUpdate('<%=numb%>','<%=numb1%>')">수정</a>
							</td>
							<td align="center">
								<a href="javascript:usageListDel('<%=numb%>','<%=numb1%>')">삭제</a>
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
			<input type="button" value="뒤로가기" onClick="location.href='usageCheck.jsp?numb=<%=numb%>'">
			<input type="hidden" name="numb">
			<input type="hidden" name="numb1">
			<input type="hidden" name="perm1">
			<input type="hidden" name="perm2">
		</form>
	</div>
</body>

</html>