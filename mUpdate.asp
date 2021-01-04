<!-- #include file="dbConnect.asp" -->
<%
  Dim InputID, InputName, InputPswd, InputLevel, sql

  If Session("id")="" Then
    Response.redirect "login.asp"
  End If

  InputID = Session("id")
  InputName = LCase(Request("NAME"))
  InputPswd = LCase(Request("PSWD1"))
	
	If InputName="" Then	'LEVEL변경
		

		sql="SELECT ID, NAME, LEVEL FROM MEMBER ORDER BY MID"
		rs.open sql, cnn
		Dim i : i=1
		Do Until (rs.eof)

		InputLevel = Request("lvl"&i)
		If InputLevel<>"" Then
			sql = "UPDATE MEMBER SET level='"&InputLevel&"' WHERE ID = '"&rs(0)&"'"
			cnn.Execute sql
		End IF
		
		rs.MoveNext
		i=i+1		

		Loop
		Response.write "<script language=""javascript"">alert('정보수정 완료');</script>"
		Response.AddHeader "REFRESH", "0;URL=memberList.asp"
	Else	'회원 정보 변경
			
		   sql = "UPDATE MEMBER SET NAME ='" &InputName&"', PSWD ='"&InputPswd&"' WHERE ID = '"&InputID&"'"

		   rs.open sql, cnn

		   sql = "UPDATE COMMENT SET NAME ='" &InputName&"' WHERE ID = '"&InputID&"'"
		   rs.open sql, cnn



		   Response.write "<script language=""javascript"">alert('회원정보 수정완료');</script>"
		   Response.AddHeader "REFRESH", "0;URL=boardList.asp"
		   		 
	End if
	  
%>
<html>
<BR><BR>

</html>