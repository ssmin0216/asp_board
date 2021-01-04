<!-- #include file="dbConnect.asp" -->
<%
	Dim strId, strBid, strName, strContent
	Dim iCgno
	strId = Session("id")
	strBid = LCase(Request.Form("bid"))
    strContent = Trim(Request.Form("content"))
	
  If strContent<>"" Then
   sql = "SELECT NAME FROM MEMBER WHERE ID='"&strId&"'"
   rs.open sql, cnn
   strName = rs(0)
	rs.close

   sql = "SELECT MAX(CGNO) FROM COMMENT"
	rs.open sql, cnn
	iCgno=rs(0)
	rs.close

   sql = "INSERT INTO COMMENT (BID, ID, NAME, CONTENT, RDATE, CGNO, CGORD, CGDEPTH) VALUES ('"&strBid&"', '"&strId&"', '"&strName&"','"&strContent&"', GETDATE(), "&iCgno&"+1, 0, 1)"
   cnn.Execute sql

   Response.write "<script language=""javascript"">alert('댓글을 등록하였습니다.');</script>"



   sql =       "SELECT M.ID"
   sql = sql & "  FROM MEMBER M"
   sql = sql & " WHERE LEVEL=2"
   sql = sql & "   AND ID = ("
   sql = sql & "               SELECT DISTINCT(id)"
   sql = sql & "                 FROM COMMENT"
   sql = sql & "                WHERE ID='" &strId& "'"
   sql = sql & "                  AND (SELECT COUNT(*)"
   sql = sql & "                         FROM COMMENT"
   sql = sql & "                        WHERE ID='" &strId& "') >= 10"
   sql = sql & "              )"

   rs.open sql, cnn
	'//https://lefigaro.tistory.com/16
		If Not rs.BOF Or Not rs.EOF  Then
		  sql = "UPDATE MEMBER SET LEVEL = 1 WHERE ID='"&strId&"'"

		  cnn.Execute sql
		  Response.write "<script language=""javascript"">alert('level이 1로 올랐습니다. 이제부터 글쓰기가 가능합니다^_^');</script>"
		End If

    Response.AddHeader "REFRESH", "0;URL=board.asp?bid="&strBid
  Else
   Response.redirect "board.asp?bid="&strBid


  End If
%>
