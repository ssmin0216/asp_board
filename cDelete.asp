<!-- #include file="dbConnect.asp" -->
<%
  Dim strSess
  Dim strBid, strCid, iCgno, iCgord, iCgdepth

  strSess = Session("id")
  strBid = Request.QueryString("BID")
  strCid = Request.QueryString("CID")

  sql = "SELECT CGNO, CGORD, CGDEPTH FROM COMMENT WHERE CID="&strCid
  rs.open sql, cnn
  iCgno = rs(0)
  iCgord = rs(1)
  iCgdepth = rs(2)
  rs.close

   sql = "SELECT CID, CGNO, CGDEPTH FROM COMMENT WHERE CGNO = "&iCgno&" AND CGDEPTH >= "&iCgdepth&" ORDER BY CGNO DESC, CGORD"
   rs.open sql, cnn
   Response.Write "sql : "&sql&"<br>"

	'//해당 댓글
   sql = "DELETE COMMENT WHERE BID = '" &strBid& "' AND CID = '"&strCid&"'"
   cnn.Execute sql
   Response.Write "sql : "&sql&"<br>"
	'//해당 댓글의 좋아요
   sql = "DELETE GOOD WHERE BID = '" &strBid& "' AND CID = '"&strCid&"'"
   cnn.Execute sql
   Response.Write "sql : "&sql&"<br>"

	'//자식 댓글
	Do Until rs.eof
		if rs(0) = CInt(strCid) Then '//현재 rs 부터
		Response.Write "2<br>"
			rs.MoveNext'//현재 rs를 제외하고
			Do Until rs.eof
			Response.Write "3<br>"
				If rs(2) = CInt(iCgdepth) Then'//그의 자식들까지만 
					Exit Do 
				Else '//자식들 삭제
						sql = "DELETE COMMENT WHERE BID = '" &strBid& "' AND CID = '"&rs(0)&"'" '//자식 댓글
						 cnn.Execute sql
						 Response.Write "sql : "&sql&"<br>"
					 
						sql = "DELETE GOOD WHERE BID = '" &strBid& "' AND CID = '"&rs(0)&"'" '//자식 좋아요
						 cnn.Execute sql
						 Response.Write "sql : "&sql&"<br>"
				End If 
				rs.MoveNext
			Loop 
		Else 
			rs.MoveNext
		End If  
	Loop 

	Response.redirect "board.asp?bid="&strBid
%>