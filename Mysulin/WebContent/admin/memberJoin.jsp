<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>

<html>
<head>
	<title>memberJoin</title>
	<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="joinCheck.js"></script>
<script type="text/javascript">
	function idCheck(usid) {
		frm = document.regFrm;
		if(usid == "") {
			alert("아이디를 입력해주세요.");
			frm.usid.focus();
			return;
		}
		url = "idCheck.jsp?usid=" + usid;
		window.open(url, "IDCheck", "width=300,height=150");
	}
	
	function zipSearch() {
		url = "zipSearch.jsp?search=n";
		window.open(url, "ZipCodeSearch", "width=500,height=300,scrollbars=yes");
	}
</script>
</head>

<body bgcolor="#F0F8FF" onLoad="regFrm.usid.focus()">
	<div align="center">
		<br/><br/>
		<form name="regFrm" method="post" action="memberJoinProc.jsp">
			<table align="center" cellpadding="5">
				<tr>
					<td align="center" valign="middle" bgcolor="#F0F8FF">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr align="center" bgcolor="#6495ED">
								<td colspan="3"><font color="#FFFFFF"><b>회원 가입</b></font></td>
							</tr>
							<tr>
								<td width="20%">아이디</td>
								<td width="50%">
									<input name="usid" size="15">
									<input type="button" value="ID중복확인" onClick="idCheck(this.form.usid.value)">
								</td>
								<td width="30%">아이디를 적어주세요.</td>
							</tr>
							<tr>
								<td>패스워드</td>
								<td><input type="password" name="uspw" size="15"></td>
								<td>패스워드를 적어주세요.</td>
							</tr>
							<tr>
								<td>패스워드 확인</td>
								<td><input type="password" name="repwd" size="15"></td>
								<td>패스워드를 확인합니다.</td>
							</tr>
							<tr>
								<td>회원권한</td>
								<td><input name="auth" size="15" value="B" readonly></td>
								<td>입력, 수정 불가</td>
							</tr>
							<tr>
								<td>이름</td>
								<td><input name="name" size="15"></td>
								<td>이름을 적어주세요.</td>
							</tr>
							<tr>
								<td>내선번호</td>
								<td><input name="telp" size="15"> ex) 1234</td>
								<td>내선번호를 적어주세요.</td>
							</tr>
							<tr>
								<td>전화번호</td>
								<td><input name="phone" size="15"> ex) 010-1234-5678</td>
								<td>전화번호를 적어주세요.</td>
							</tr>
							<tr>
								<td>성별</td>
								<td>
									남<input type="radio" name="gend" value="1" checked>
									여<input type="radio" name="gend" value="2">
								</td>
								<td>성별을 선택하세요.</td>
							</tr>
							<tr>
								<td>생년월일</td>
								<td><input name="brth" size="6"> ex) 230522</td>
								<td>생년월일을 적어주세요.</td>
							</tr>
							<tr>
								<td>Email</td>
								<td><input name="mail" size="30"></td>
								<td>메일 주소를 적어주세요.</td>
							</tr>
							<tr>
								<td>우편번호</td>
								<td>
									<input name="post" size="5" readonly>
									<input type="button" value="우편번호찾기" onClick="zipSearch()">
								</td>
								<td>우편번호를 검색하세요.</td>
							</tr>
							<tr>
								<td>상세주소</td>
								<td><input name="addr" size="45"></td>
								<td>상세주소를 적어주세요.</td>
							</tr>
							<tr>
								<td>취미</td>
								<td>
									독서<input type="checkbox" name="hobb" value="독서">
									등산<input type="checkbox" name="hobb" value="등산">
									낚시<input type="checkbox" name="hobb" value="낚시">
									여행<input type="checkbox" name="hobb" value="여행">
									영화<input type="checkbox" name="hobb" value="영화">
								</td>
								<td>취미를 선택하세요.</td>
							</tr>
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
	</div>
</body>
</html>