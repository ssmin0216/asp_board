<meta http-equiv="Content-Type"
 content="text/html; charset=UTF-8">
 <!-- #include file="dbConnect.asp" -->
 <%
  Dim sql, strSess

  strSess = Session("id")
  sql = "SELECT ID, LEVEL, NAME FROM MEMBER WHERE ID = '" & strSess & "'" 
  rs.open sql, cnn
' rs(0) - ID 
' rs(1) - LEVEL
' rs(2) - NAME
   
   
'strId = rs(3)

%>
 <style>
 input{
	text-transform:lowercase;
 }
 </style>
<html>
 <title>게시판 내 정보</title>
 <body>
  <center>
   <BR><BR>
   <H1 style="margin-top:100">회원 정보 수정</H1>
   <FORM ACTION="mUpdate.asp" onsubmit="return checkAll();" NAME="formMemberUpdate" METHOD="POST" AUTOCOMPLETE="OFF">
   <%
	If rs(1) = 2 Then
   %>
   	※댓글을 10개 이상 등록하시면 LEVEL 1로 등업되며, LEVEL 1부터 글쓰기가 가능합니다.※<p>
   <%
	End If
   %>
    <TABLE ALIGN="CENTER">
     <TR>
 	     <TD>ID</TD>
 	     <TD COLSPAN=2>
 	         <INPUT TYPE="TEXT" ID="ID" NAME="ID" VALUE="<%=rs(0)%>" MINLENGTH="4" MAXLENGTH="20" SIZE="20" REQUIRED READONLY >
 	     </TD>
 	 </TR>
	 <TR>
 	     <TD>LEVEL</TD>
 	     <TD>
 	         <INPUT TYPE="TEXT" ID="LEVEL" NAME="LEVEL" VALUE="<%=rs(1)%>"  MAXLENGTH="20" SIZE="20" REQUIRED READONLY>
 	     </TD>
 	 </TR>
 	 <TR>
 	     <TD>이름</TD>
 	     <TD>
 	         <INPUT TYPE="TEXT" ID="NAME" NAME="NAME" VALUE="<%=rs(2)%>" MINLENGTH="1" MAXLENGTH="20" SIZE="20" REQUIRED autofocus>
 	     </TD>
 	 </TR>
 	 <TR>
 	     <TD>PW</TD>
 	     <TD>
 	         <INPUT TYPE="PASSWORD" ID="PSWD1" NAME="PSWD1" MINLENGTH="6" MAXLENGTH="20" SIZE="20" ONKEYUP="pwSame()" REQUIRED>
 	     </TD>
 	 </TR>
	 <TR>
 	     <TD>PW 확인</TD>
 	     <TD>
 	         <INPUT TYPE="PASSWORD" ID="PSWD2" NAME="PSWD2" MINLENGTH="6" MAXLENGTH="20" SIZE="20" ONKEYUP="pwSame()" REQUIRED>
 	     </TD>
 	 </TR>
    </TABLE>
	<P ID="PSWDCHECK"></P>
	
	<BR>
	 <INPUT TYPE="SUBMIT" VALUE="수정완료">&nbsp;&nbsp;
	 <INPUT TYPE="BUTTON" VALUE="목록으로" ONCLICK="location.href='boardList.asp'">&nbsp;&nbsp;
	 <INPUT TYPE="BUTTON" VALUE="회원탈퇴" style="color:red" ONCLICK="mDelete()">

   </FORM>
  </center>
 </body>
</html>
<SCRIPT type="text/javascript" language="javascript">
	
	function checkAll() {
		var id = formMemberUpdate.ID.value;
		var name = formMemberUpdate.NAME.value;
		var pw1 = formMemberUpdate.PSWD1.value;
		var pw2 = formMemberUpdate.PSWD2.value;

		if(!nameCheck(name)){
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

<!-- 이름 유효성 체크 -->
	function nameCheck(name){
		var nameRegExp = /^[a-zA-Zㄱ-힣]{1,20}$/;
		if(!nameRegExp.test(name)){
			alert("이름은 영문 소문자, 한글 1~20자리로 입력해야합니다!");
			formMemberUpdate.NAME.value="";
			formMemberUpdate.NAME.focus();
			return false;
		}
		return true;
	}
<!-- 비밀번호 유효성 체크 -->
	function pwCheck(id, pw1, pw2){
		var pw1RegExp = /^[a-z0-9~!@#$%^&*()_|:]{6,20}$/;
		if(!pw1RegExp.test(pw1)){
				alert("비밀번호는 영문 소문자, 숫자, 특정 특수문자 6~20자리로 입력해야합니다!");
			formMemberUpdate.PSWD1.value="";
			formMemberUpdate.PSWD1.focus();
			return false;
		}

		if(id === pw1) {
			alert("아이디와 비밀번호는 같을 수 없습니다!");
			formMemberUpdate.PSWD1.value="";
			formMemberUpdate.PSWD2.value="";
			formMemberUpdate.PSWD1.focus();
			return false;
		}
		return true;
	}
<!-- 비밀번호확인 체크 -->
	function pwSame(){
		var pw1 = formMemberUpdate.PSWD1.value;
		var pw2 = formMemberUpdate.PSWD2.value;

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
	function mDelete(){
			if(confirm("게시된 글과 댓글은 모두 삭제됩니다. 정말 탈퇴하시겠습니까?"))
			{
				var id = formMemberUpdate.ID.value;
				alert(id + '님 탈퇴되었습니다.');
				location.href="mDelete.asp"	
			}
			else
			{
				return false;
			}
		}
</SCRIPT>
   