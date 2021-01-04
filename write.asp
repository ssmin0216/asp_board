<!-- #include file="dbConnect.asp" -->
<%
  Dim InputID, InputTitle, InputContent, InputGubn

  InputID = LCase(Session("id"))
  InputTitle = Trim(Request("TITLE"))
  InputContent = Trim(Request("CONTENT"))
  InputGubn = Request("gubn")

	Response.write InputGubn

	sql = "SELECT MAX(BGNO) FROM BOARD"
	rs.open sql, cnn

	If InputGubn="on" Then	
		sql = "INSERT INTO BOARD (ID, TITLE, CONTENT, RDATE, VCNT, GUBN, BGNO, BGORD, BGDEPTH) VALUES('"&InputID&"', '"&InputTitle&"', '"&InputContent&"', GETDATE(), '0', 'Y', "&rs(0)&"+1, 0, 1)"
		'sql = "INSERT INTO BOARD(ID, TITLE, CONTENT, RDATE, VCNT, GUBN) VALUES('"&InputID&"', '"&InputTitle&"', '"&InputContent&"', GETDATE(), '0', 'Y')"

	Else
		sql = "INSERT INTO BOARD(ID, TITLE, CONTENT, RDATE, VCNT, GUBN, BGNO, BGORD, BGDEPTH) VALUES('"&InputID&"', '"&InputTitle&"', '"&InputContent&"', GETDATE(), '0', 'N', "&rs(0)&"+1, 0, 1)"
	End If
	rs.close
	
    rs.open sql, cnn
	
    Response.AddHeader "REFRESH", "0;URL=boardList.asp"

%>