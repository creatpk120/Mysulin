function joinCheck(){
	if(document.regFrm.usid.value==""){
		alert("아이디를 입력해주세요.");
		document.regFrm.usid.focus();
		return;
	}
	if(document.regFrm.uspw.value==""){
		alert("비밀번호를 입력해주세요.");
		document.regFrm.uspw.focus();
		return;
	}
	if(document.regFrm.repwd.value==""){
		alert("비밀번호를 확인해주세요.");
		document.regFrm.repwd.focus();
		return;
	}
	if(document.regFrm.uspw.value != document.regFrm.repwd.value){
		alert("비밀번호가 일치하지 않습니다.");
		document.regFrm.repwd.value="";
		document.regFrm.repwd.focus();
		return;
	}
	if(document.regFrm.name.value==""){
		alert("이름을 입력해주세요.");
		document.regFrm.name.focus();
		return;
	}
	if(document.regFrm.telp.value==""){
		alert("내선번호를 입력해주세요.");
		document.regFrm.telp.focus();
		return;
	}
	if(document.regFrm.phone.value==""){
		alert("전화번호를 입력해주세요.");
		document.regFrm.phone.focus();
		return;
	}
	if(document.regFrm.brth.value==""){
		alert("생년월일을 입력해주세요.");
		document.regFrm.brth.focus();
		return;
	}
	if(document.regFrm.mail.value==""){
		alert("이메일을 입력해주세요.");
		document.regFrm.mail.focus();
		return;
	}
    var str=document.regFrm.mail.value;	   
    var atPos = str.indexOf('@');
    var atLastPos = str.lastIndexOf('@');
    var dotPos = str.indexOf('.'); 
    var spacePos = str.indexOf(' ');
    var commaPos = str.indexOf(',');
    var eMailSize = str.length;
    if (atPos > 1 && atPos == atLastPos && 
	   dotPos > 3 && spacePos == -1 && commaPos == -1 
	   && atPos + 1 < dotPos && dotPos + 1 < eMailSize);
    else {
          alert('E-mail주소 형식이 잘못되었습니다.\n\r다시 입력해 주세요!');
	      document.regFrm.mail.focus();
		  return;
    }
	document.regFrm.submit();
}

function win_close() {
	self.close();
}