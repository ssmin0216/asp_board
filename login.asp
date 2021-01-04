<meta http-equiv="Content-Type"
 content="text/html; charset=UTF-8">
 <%
	'Session.abandon
 %>
 <style>
 input{
	text-transform:lowercase;
 }
 </style>
<html>
 <title>게시판 로그인</title>
 <body>
   <center>
    <BR><BR>
    <H1 ONCLICK="location.href='login.asp'" style="cursor:pointer; margin-top:100">LOGIN</H1>
    <!-- loginCheck.asp에서 비밀번호가 틀렸을경우 -->
    <% 
     If Request("wrongPass")="True" Then
        Response.Write "<font color=red>비밀번호가 틀립니다</font>."
     End If

    %>
    <% 
      If Request("WrongID")="True" THEN
         Response.Write "<font color=red>존재하지않는 ID입니다.</font>"
      End If
    %>
   
    <FORM ACTION="loginCheck.asp" name="loginForm" METHOD="POST" AUTOCOMPLETE="OFF">
     <TABLE ALIGN="CENTER">
      <TR>
        <TD>ID</TD>
        <TD>
            <INPUT TYPE="TEXT" id="ID" NAME="ID"SIZE="20" required autofocus>
        </TD>
      </TR>
      <TR>
        <TD><label>PW</label></TD>
        <TD>
            <INPUT TYPE="PASSWORD" NAME="PSWD" SIZE="20" required>
        </TD>
      </TR>
     </TABLE>
     <INPUT TYPE="SUBMIT" VALUE="로그인">&nbsp;&nbsp;
     <INPUT TYPE="RESET" VALUE="취소">&nbsp;&nbsp;
     <INPUT TYPE="BUTTON" VALUE="회원가입" ONCLICK="location.href='join.asp'">
    </FORM>
  </center>
 </body>
</html>
<script type="text/javascript">  
</script>