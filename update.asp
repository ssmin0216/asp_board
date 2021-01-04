<!-- #include file="dbConnect.asp" -->
<%
  Dim strBid
  Dim InputID, InputTitle, InputContent

  strBid = Request.QueryString("bid")

  InputID = Trim(Request("ID"))
  InputTitle = Trim(Request("TITLE"))
  InputContent = Trim(Request("CONTENT"))


   sql = "UPDATE BOARD SET TITLE ='" &InputTitle&"', CONTENT ='"&InputContent&"', RDATE=GETDATE() WHERE BID ='" &strBid&"'"

   rs.open sql, cnn
	Response.AddHeader "REFRESH", "0;URL=board.asp?bid="&strBid

%>