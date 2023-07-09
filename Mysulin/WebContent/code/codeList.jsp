<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Code"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	int totalRecord = 0;		//전체 레코드 수
	int listSize = 0;			//현재 읽어온 자료의 수
	Vector<Bean_Code> vlist = null;
	
	String usid = (String)session.getAttribute("idKey");
	String check = request.getParameter("check");
	if(check == null) check = "S";
	Bean_Admin aBean = myMgr.getMember(usid);		//회원자료 가져오기
	check = aBean.getAuth();
	int numb = 0;
	
	String keyWord = "", keyField = "";
	if(request.getParameter("keyWord") != null) {
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
		check = "B";
	}
	totalRecord = myMgr.getCodeCount(check, keyWord, keyField, usid);
%>

<html>
<head>
	<title>codeList</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function codeUpdate(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="codeUpdate.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function codeDel(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="codeDel.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
		
	function Search() {
		if(document.searchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.action="codeList.jsp";
		document.searchFrm.target="content";
		document.searchFrm.submit();
	}
	
	/* function enterKey() {
		if(window.event.keyCode == 13) {
			Search();
		}
	} */
</script>
</head>

<body bgcolor="#F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/>
		<h2>인슐린 코드 관리</h2>
		<br/>
		
		<form name="searchFrm" method="get" action="codeList.jsp">
			<table width="600" cellpadding="4" cellspacing="0">
				<tr>
					<td align="center" valign="bottom">
						<select name="keyField" size="1">
							<option value="0" selected disabled>선택하세요.
							<option value="agnt">제약 회사</option>
							<option value="code">인슐린 코드</option>
							<option value="name">인슐린 이름</option>
						</select>
						<!-- <input type="text" size="16" name="keyWord" onkeypress="if(event.keyCode == 13){enterKey();}"> -->
						<input type="text" size="16" name="keyWord" onkeypress="if(event.keyCode == 13){Search();}">
						<input type="button" value="검색" onClick="Search()">
					</td>
				</tr>
			</table>
		</form>
		
		<table align="center" width="800" border="1">
			<tr>
				<td bgcolor="#D9E5FF">&nbsp;&nbsp;인슐린 코드 수 : <%=totalRecord%></td>
			</tr>
		</table>
		<table align="center" width="800" cellpadding="3" border="1">
			<tr>
				<td align="center" colspan="3">
				<%
					vlist = myMgr.getCodeList(check, keyWord, keyField, usid);
					listSize = vlist.size();	//브라우저 화면에 보여질 자료의 수
					if(vlist.isEmpty()) {
						out.println("등록된 자료가 없습니다.");
					} else {
				%>
					<table width="100%" cellpadding="2" cellspacing="0" border="1">
						<tr bgcolor="#D9E5FF" align="center" height="120%">
							<td>번호</td>
							<td>제약 회사</td>
							<td>인슐린 코드</td>
							<td>인슐린 이름</td>
							<td>수 정</td>
							<td>삭 제</td>
						</tr>
						<%
							for(int i = 0; i < listSize; i++) {
								Bean_Code bean = vlist.get(i);
								numb = bean.getNumb();
								String agnt = bean.getAgnt();
								String code = bean.getCode();
								String name = bean.getName();
						%>
						<tr>
							<td align="center"><%=numb%></td>
							<td align="center"><%=agnt%></td>
							<td align="center"><%=code%></td>
							<td align="center"><%=name%></td>
							<td align="center">
								<a href="javascript:codeUpdate('<%=numb%>')">수정</a>
							</td>
							<td align="center">
								<a href="javascript:codeDel('<%=numb%>')">삭제</a>
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
			<input type="button" value="코드등록" onClick="location.href='codeWrite.jsp'"> &nbsp;&nbsp;
			<input type="button" value="전체코드" onClick="location.href='codeList.jsp?check=All'"> &nbsp;&nbsp;
			<input type="hidden" name="numb">
		</form>
	</div>
</body>
</html>