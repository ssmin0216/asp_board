<!-- #include file="dbConnect.asp" -->
<%
  Dim InputID, InputPSWD

  InputID = Request("ID")
  InputPSWD = Request("PSWD")
  Session("id")=InputID

   sql = "SELECT * FROM MEMBER WHERE ID='"&InputID&"'"
   
   rs.open sql, cnn
'rs가 끝날때까지
   If Not rs.EOF Then
     If rs("PSWD") = InputPSWD Then
	  
	  rs_member = True
	  rs_id   = LCase(rs("ID"))
	  rs_name = LCase(rs("NAME"))
	  rs_pswd = LCase(rs("PSWD"))
	  
      Response.Redirect "boardList.asp"
	  
     Else
      rs_member = False
	  'rs_id = InputID
      
      Response.Redirect "login.asp?WrongPass=True"
	 End If
	Else 'DB에 더이상 일치하는 ID값이 없으면
	  Response.Redirect "login.asp?WrongID=True"
	End IF
%>