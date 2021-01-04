<!-- #include file="dbConnect.asp" -->
<%
  Dim strId, strTitle, strContent, InputGubn

  strId = LCase(Session("id"))
  strTitle = Trim(Request.Form("TITLE"))
  strContent = Trim(Request.Form("CONTENT"))

Dim strBid, strGubn, iBgno, iBgord, iBgdepth
  strBid = Request.Form("bid")
  strGubn = Request.Form("gubn")
  iBgno = Request.Form("bgno")
  iBgord = Request.Form("bgord")
  iBgdepth = Request.Form("bgdepth")

	'Response.write "bid : "&strBid&"<BR>"
	'Response.write "iBgno : "&iBgno&"<BR>"
	'Response.write "strGubn : "&strGubn&"<BR>"
	'Response.write "strId : "&strId&"<BR>"
	'Response.write "strTitle : "&strTitle&"<BR>"
	'Response.write "strContent : "&strContent&"<BR>"

 sql = "UPDATE BOARD SET BGORD=BGORD+1 WHERE BGORD > "&iBgord
 rs.open sql, cnn


 sql = "INSERT INTO BOARD (ID, TITLE, CONTENT, RDATE, GUBN, BGNO, BGORD, BGDEPTH) VALUES ('"&strId&"', '└RE."&strTitle&"','"&strContent&"', GETDATE(), '"&strGubn&"', "&iBgno&", "&iBgord&"+1, "&iBgdepth&"+1)"
 rs.open sql, cnn

 Response.redirect "boardList.asp"
%>