<meta http-equiv="Content-Type"
 content="text/html; charset=UTF-8">
  <!-- #include file="dbConnect.asp" -->
<html>
 <title>게시판</title>
 <body>
    <FORM>
    <center>
	<H1 onclick="location.href='boardList.asp'" style="cursor:pointer; margin-top:5%">게시판</H1>
	</center>
	<div align="right" style="margin-right:10%">
	<%
	Dim strSess
	strSess = Session("id")
	Response.Write strSess&"님"

	'세션값이 없으면 로그인 페이지로 강제이동
		If strSess="" Then
		    Response.AddHeader "REFRESH", "0;URL=login.asp"
		End if

	%>
	<!-- 세션 고유의 아이디 값 확인 <%=Session.SessionID%> -->
	<input type="button" name="logout" value="로그아웃" onclick="location.href='logout.asp'">
	<input type="button" name="logout" value="내 정보" onclick="location.href='memberUpdate.asp'">&nbsp;&nbsp;
	
	<%	
		Set rs = Server.CreateObject("ADODB.RecordSet") 
		sql = "SELECT ID FROM MEMBER WHERE LEVEL=0"
		
		rs.open sql, cnn
		Do Until rs.eof
			If strSess = rs(0) Then 
			%>
				<INPUT style="float:right" type="button" value=" 회원목록 " id="btn_delete" onclick="location.href='memberList.asp'">
			<%
			End If
		rs.MoveNext
		Loop
		rs.close
	%>
	</div>
    </FORM>
 </body>
</html>