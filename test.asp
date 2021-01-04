<meta http-equiv="Content-Type"
 content="text/html; charset=UTF-8">


	
<html>
 <title>게시판 회원가입</title>
 <body>
  <center>
   <BR><BR>
   <H1>회원가입</H1>
  

   <FORM name="formJoin" METHOD="POST">
    <TABLE ALIGN="CENTER">
    
 	 <TR>
 	     <TD>PW</TD>
 	     <TD>
 	         <INPUT TYPE="PASSWORD" ID="PSWD1" NAME="PSWD1" VALUE="<%=PSWD1%>" SIZE="20" required>
 	     </TD>
 	 </TR>
	 <TR>
 	     <TD>PW확인</TD>
 	     <TD>
 	         <INPUT TYPE="PASSWORD" ID="PSWD2" NAME="PSWD2" onkeyup="pwCheck()" SIZE="20" required>
 	     </TD>
 	 </TR>
    </TABLE>
	<P ID="PSWDCHECK" STYLE="COLOR:blue;"></P>
	<BR>
     <INPUT TYPE="SUBMIT" VALUE="확인">&nbsp;&nbsp;
     <INPUT TYPE="RESET" VALUE="취소">&nbsp;&nbsp;
	 <BUTTON ">로그인</BUTTON>
   </FORM>
  </center>
 </body>
</html>
  <SCRIPT type="text/javascript" language="javascript">
	function pwCheck(){
			
			var pw1 = document.getElementById('PSWD1').value;
			var pw2 = document.getElementById('PSWD2').value;
			if(pw2==""){
				document.getElementByID('PSWDCHECK').innerHTML="";
				}
			else if(pw1===pw2){
				document.getElementById('PSWDCHECK').innerHTML = "비밀번호 일치";
				}
				else{
					document.getElementById('PSWDCHECK').innerHTML = "비밀번호가 일치하지않습니다. 다시 입력해주세요.";
					}

		}
   </SCRIPT>
    <SCRIPT type="text/javascript" language="javascript">
	alert ("안녕하세여");
	;

	var pw1 = document.getElementById('PSWD1').value;

	 </SCRIPT>