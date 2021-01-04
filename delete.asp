<!-- #include file="dbConnect.asp" -->
<%
  Dim strBid
  Dim iBgno, iBgord, iBgdepth

  strBid = Request.QueryString("bid")
  iBgno = Request.QueryString("bgno")
  iBgord = Request.QueryString("bgord")
  iBgdepth = Request.QueryString("bgdepth")

	sql = "SELECT BID, BGNO, BGDEPTH FROM BOARD WHERE BGNO = "&iBgno&" AND BGDEPTH >= "&iBgdepth&" ORDER BY GUBN DESC, BGNO DESC, BGORD"
	rs.open sql, cnn
	'Response.Write "sql : "&sql&"<br>"

    '//해당 게시글
	sql = "DELETE BOARD WHERE BID="&strBid	'//해당 게시글
	 cnn.Execute sql

    sql = "DELETE COMMENT WHERE BID="&strBid '//해당 게시글댓글
     cnn.Execute sql
 
    sql = "DELETE GOOD WHERE BID=" &strBid '//해당 좋아요
     cnn.Execute sql

	'//자식 게시글
	Do Until rs.eof
		if rs(0) = CInt(strBid) Then '//현재 rs 부터
			rs.MoveNext'//현재 rs를 제외하고
			Do Until rs.eof
				If rs(2) = CInt(iBgdepth) Then'//그의 자식들까지만
					Response.Write "끝 <br>"
					Exit Do 
				Else '//자식들 삭제
						sql = "DELETE BOARD WHERE BID="&rs(0)	'//자식 게시글
						 cnn.Execute sql

						sql = "DELETE COMMENT WHERE BID="&rs(0) '//자식 게시글댓글
						 cnn.Execute sql
					 
						sql = "DELETE GOOD WHERE BID=" &rs(0) '//자식 좋아요
						 cnn.Execute sql
				End If 
				rs.MoveNext
			Loop 
		Else 
			rs.MoveNext
		End If  
	Loop 

	Response.AddHeader "REFRESH", "0;URL=boardList.asp"
	rs.close
	Set rs = nothing
%>