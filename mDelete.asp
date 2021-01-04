<!-- #include file="dbConnect.asp" -->
<%
  Dim strSess
  strSess = Session("id")

  If strSess="" Then
    Response.redirect "login.asp"
  End If
	'//탈퇴한 회원의 회원정보, 게시글, 댓글, 좋아요 삭제
   sql = "DELETE MEMBER WHERE ID ='" &strSess&"'"
   cnn.Execute sql
   
   sql = "DELETE BOARD WHERE ID ='" &strSess&"'"
   cnn.Execute sql

   sql = "DELETE COMMENT WHERE ID = '"&strSess&"'"
   cnn.Execute sql

   sql = "DELETE GOOD WHERE ID ='" &strSess&"'"
   cnn.Execute sql
   

   Session.abandon
   Response.AddHeader "REFRESH", "0;URL=login.asp"

%>