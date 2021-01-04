<meta http-equiv="Content-Type"
 content="text/html; charset=UTF-8">
<html>
 <title>게시판 회원가입</title>
 <body>
  <center>
   <BR><BR>
   <H1 style="margin-top:100">회원가입</H1>
   <% 
      If Request("OverID")="True" THEN
         Response.Write "<font color=red>이미 존재하는 ID입니다.</font>"
      End If
    %>

   <FORM ACTION="joinCheck.asp" ONSUBMIT="return checkAll();" NAME="formJoin" METHOD="POST" AUTOCOMPLETE="OFF">
    <TABLE ALIGN="CENTER">
     <TR>
 	     <TD>ID</TD>
 	     <TD COLSPAN=2>
 	         <INPUT TYPE="TEXT" ID="ID" NAME="ID" MINLENGTH="4" MAXLENGTH="20" SIZE="20" REQUIRED autofocus>
 	     </TD>
 	 </TR>
 	 <TR>
 	     <TD>이름</TD>
 	     <TD>
 	         <INPUT TYPE="TEXT" ID="NAME" NAME="NAME" MINLENGTH="1" MAXLENGTH="20" SIZE="20" REQUIRED>
 	     </TD>
 	 </TR>
 	 <TR>
 	     <TD>PW</TD>
 	     <TD>
 	         <INPUT TYPE="PASSWORD" ID="PSWD1" NAME="PSWD1" MINLENGTH="6" MAXLENGTH="20" SIZE="20" ONKEYUP="pwSame()" REQUIRED>
 	     </TD>
 	 </TR>
	 <TR>
 	     <TD>PW확인</TD>
 	     <TD>
 	         <INPUT TYPE="PASSWORD" ID="PSWD2" NAME="PSWD2" MINLENGTH="6" MAXLENGTH="20" SIZE="20" ONKEYUP="pwSame()" REQUIRED>
 	     </TD>
 	 </TR>
    </TABLE>
	<P ID="PSWDCHECK"></P>
	
	<BR>
     <INPUT TYPE="SUBMIT" VALUE="확인">&nbsp;&nbsp;
     <INPUT TYPE="RESET" VALUE="취소">&nbsp;&nbsp;
	 <INPUT TYPE="BUTTON" VALUE="로그인" ONCLICK="location.href='login.asp'">

   </FORM>
  </center>
 </body>
</html>
<SCRIPT type="text/javascript" language="javascript">
	function checkAll() {
		var id = formJoin.ID.value;
		var name = formJoin.NAME.value;
		var pw1 = formJoin.PSWD1.value;
		var pw2 = formJoin.PSWD2.value;

		if(!idCheck(id)){
				return false;
			}
		else if(!nameCheck(name)){
				return false;
			}
		else if(!pwCheck(id, pw1, pw2)){
				return false;
			}
		else if(!pwSame()){
				return false;
			}
		return true;
	}

<!-- ID 유효성 체크 -->
	function idCheck(id){
		var idRegExp = /^[a-z0-9ㄱ-힣]{4,20}$/;
		if(!idRegExp.test(id)){
			alert("아이디는 영문 소문자, 한글, 숫자 4~20자리로 입력해야합니다!");
			formJoin.ID.value="";
			formJoin.ID.focus();
			return false;
		}
		return true;
	}
<!-- 이름 유효성 체크 -->
	function nameCheck(name){
		var nameRegExp = /^[a-zㄱ-힣]{1,20}$/;
		if(!nameRegExp.test(name)){
			alert("이름은 영문 소문자, 한글 1~20자리로 입력해야합니다!");
			formJoin.NAME.value="";
			formJoin.NAME.focus();
			return false;
		}
		return true;
	}
<!-- 비밀번호 유효성 체크 -->
	function pwCheck(id, pw1, pw2){
		var pw1RegExp = /^[a-z0-9~!@#$%^&*()_|:]{6,20}$/;
		if(!pw1RegExp.test(pw1)){
			alert("비밀번호는 영문 소문자, 숫자, 특정 특수문자 6~20자리로 입력해야합니다!");
			formJoin.PSWD1.value="";
			formJoin.PSWD1.focus();
			return false;
		}

		if(id === pw1) {
			alert("아이디와 비밀번호는 같을 수 없습니다!");
			formJoin.PSWD1.value="";
			formJoin.PSWD2.value="";
			formJoin.PSWD1.focus();
			return false;
		}
		return true;
	}
<!-- 비밀번호확인 체크 -->
	function pwSame(){
		var pw1 = formJoin.PSWD1.value;
		var pw2 = formJoin.PSWD2.value;

		if(pw2==""){
			document.getElementById('PSWDCHECK').innerHTML="";
			return false;
		}
		else if(pw1!==pw2){
			document.getElementById('PSWDCHECK').innerHTML = "<font color=red>비밀번호가 일치하지않습니다. 시 입력해주세요.</font>";
			return false;
		}
		else{
			document.getElementById('PSWDCHECK').innerHTML = "<font color=blue>비밀번호 일치</font>";
			return true;
		}
	}
</SCRIPT>
   