<meta http-equiv="Content-Type"
 content="text/html; charset=UTF-8">
    <!-- #include file="boardTop.asp" -->
<%
  Dim sql
  Dim strBid, strPage, strId, strRPage, strGubn
  Dim iBgno, iBgord, iBgdepth
  
  strBid = Request.QueryString("bid")
  strPage = Request.QueryString("page")
  strRPage = Request.QueryString("rpage")
  strGubn = Request.QueryString("gubn")

  iBgno = Request.QueryString("bgno")
  iBgord = Request.QueryString("bgord")
  iBgdepth = Request.QueryString("bgdepth")


   sql = "UPDATE BOARD SET VCNT = VCNT + 1"
   sql = sql & "WHERE BID =" & strBid
   cnn.Execute sql
   
   sql = "SELECT TITLE, VCNT, RDATE, ID, CONTENT FROM BOARD WHERE BID ='" & strBid &"'"
   
' rs(0) - 제목  TITLE
' rs(1) - 조회수 VCNT
' rs(2) - 등록일 RDATE
' rs(3) - 등록자 ID
' rs(4) - 내용  CONTENT
   
   rs.open sql, cnn
   strSess = LCase(Session("id"))
   strId = rs(3)
%>
<html>
 <title>게시판 목록</title>
 <style>
 table{
 	width:80%;
	
	border-collapse: collapse;
 }
 td{
	border: 1px solid;
	border-collapse: collapse;
	padding:5px;
 }
 .content{
	height: 90%;
	padding-top:0px;
 }
 #title{
	width:20%;
	background-color:lightgray;
	text-align: center;
	font-weight:bold;
 }
div {
	margin-left:10%
}
hr {
 text-align:center;
 width:80%;
}
 </style>
 <body>
  <center>
    <BR><BR>
	<BR><BR>
	
	
    <FORM name="boardForm">
	<TABLE style="height:60%;">
 	  <TR>
        <TD id="title">제목</TD>
		<TD><%=rs(0)%></TD>
		<TD id="title">조회수</TD>
		<TD><%=rs(1)%></TD>
      </TR>
      <TR>
        <TD id="title">등록일</TD>
		<TD><%=rs(2)%></TD>
		<TD id="title">글쓴이</TD>
		<TD><%=rs(3)%></TD>
      </TR>
      <TR>
        <TD id="title" class="content">내용</TD>
		<TD class="content" colspan="3" ><%=rs(4)%></TD>
      </TR>
	  <TR>
	  	<TD colspan="4">
			<INPUT type="button" value="목록" onclick="location.href='boardList.asp?page=<%=strPage%>'">
			<%
			
			If strGubn ="N" Then  '//공지사항이 아닌 경우 '//0
		'//이전글
				Set ars = Server.CreateObject("ADODB.RecordSet") 
				'//1.공지사항이 아닌 것중에 가장 상위의 그룹을 추출
				sql = "SELECT MAX(BGNO) FROM BOARD WHERE GUBN='N'" 
				ars.open sql, cnn
				'//제일 끝 그룹인 경우
				If ars(0)=CInt(iBgno) Then'//1
					If iBgord <> 0 Then '//2 제일 끝그룹의 0이 아닌경우 INPUT
				 		
						Set brs = Server.CreateObject("ADODB.RecordSet") 

						sql="SELECT BID, GUBN, BGNO, BGORD, BGDEPTH"
						sql = sql&" FROM BOARD"
						sql = sql&" WHERE BGNO = "&iBgno
						sql = sql&" AND BGORD = (SELECT MAX(BGORD)"
						sql = sql&" 			FROM BOARD"
						sql = sql&" 			WHERE BGNO="&iBgno
						sql = sql&" 			AND BGORD<"&iBgord&")"
						brs.open sql, cnn
						
			%>
						<input type="button" value="이전글" onclick="location.href='board.asp?bid=<%=brs(0)%>&page=<%=strPage%>&gubn=<%=brs(1)%>&bgno=<%=brs(2)%>&bgord=<%=brs(3)%>&bgdepth=<%=brs(4)%>'">
			<%
					End If '//2
				'//제일 끝그룹이 아닌경우 (전부 다 이전 가능)
				Else '//1
				Set brs = Server.CreateObject("ADODB.RecordSet") 
					'//같은 그룹에 이전값이 있을때 즉, bgord<>0일때
					If iBgord<>0 Then '//3
						'Set brs = Server.CreateObject("ADODB.RecordSet") 
						sql = "SELECT BID, GUBN, BGNO, BGORD, BGDEPTH"
						sql = sql & " FROM BOARD"
						sql = sql & " WHERE BGNO = "&iBgno
						sql = sql & " AND BGORD = (SELECT MAX(BGORD)"
						sql = sql & " 			FROM BOARD"
						sql = sql & " 			WHERE BGNO="&iBgno
						sql = sql & " 			AND BGORD<"&iBgord&")"
						
					'//같은 그룹에 이전값이없어서 이전 그룹의 최고 
					Else '//3
					
						sql = "SELECT BID, GUBN, BGNO, BGORD, BGDEPTH"
						sql = sql & " FROM BOARD"
						sql = sql & " WHERE BGNO=("
						sql = sql & "			SELECT MIN(BGNO)"
						sql = sql & "			FROM BOARD"
						sql = sql & "			WHERE BGNO>"&iBgno
						sql = sql & "			AND GUBN='N')"
						sql = sql & "	AND BGORD=("
						sql = sql & "			SELECT MAX(BGORD)"
						sql = sql & "			FROM BOARD"
						sql = sql & "			WHERE BGNO = ("
						sql = sql & "						SELECT MIN(BGNO)"
						sql = sql & "						FROM BOARD"
						sql = sql & "						WHERE BGNO>"&iBgno
						sql = sql & "						AND GUBN='N'))"
						
					End If '//3
					
					brs.open sql, cnn
			%>
					<input type="button" value="이전글" onclick="location.href='board.asp?bid=<%=brs(0)%>&page=<%=strPage%>&gubn=<%=brs(1)%>&bgno=<%=brs(2)%>&bgord=<%=brs(3)%>&bgdepth=<%=brs(4)%>'">
			<%
			
				End If'//1
				ars.close
				Set ars = Nothing
				
				
		'//다음글
				Set ars = Server.CreateObject("ADODB.RecordSet") 
				'//1.공지사항이 아닌 것중에 가장 하위의 그룹을 추출
				sql = "SELECT MIN(BGNO) FROM BOARD WHERE GUBN='N'" 
				ars.open sql, cnn
				'//제일 하위 그룹인 경우
				If ars(0)=CInt(iBgno) Then'//1

					Set brs = Server.CreateObject("ADODB.RecordSet") 
					sql = "SELECT MAX(BGORD)"
					sql = sql & " FROM BOARD"
					sql = sql & " WHERE BGNO = (SELECT MIN(BGNO)"
					sql = sql & "				FROM BOARD"
					sql = sql & "               WHERE GUBN='N')"

					brs.open sql, cnn
					If brs(0) <> CInt(iBgord) Then '//2 제일 하위그룹의 마지막이 아닌경우 INPUT
				 		
						Set crs = Server.CreateObject("ADODB.RecordSet") 
						sql="SELECT BID, GUBN, BGNO, BGORD, BGDEPTH"
						sql = sql&" FROM BOARD"
						sql = sql&" WHERE BGNO = "&iBgno
						sql = sql&" AND BGORD = (SELECT MIN(BGORD)"
						sql = sql&" 			FROM BOARD"
						sql = sql&" 			WHERE BGNO="&iBgno
						sql = sql&" 			AND BGORD>"&iBgord&")"
						crs.open sql, cnn
						
			%>
						<input type="button" value="다음글" onclick="location.href='board.asp?bid=<%=crs(0)%>&page=<%=strPage%>&gubn=<%=crs(1)%>&bgno=<%=crs(2)%>&bgord=<%=crs(3)%>&bgdepth=<%=crs(4)%>'">
			<%
					brs.close
					Set brs = Nothing 
					End If '//2
				'//제일 하위그룹이 아닌경우 (전부 다 다음 가능)
				Else '//1
					Set brs = Server.CreateObject("ADODB.RecordSet") 
					sql = "SELECT BID, GUBN, BGNO, BGORD, BGDEPTH"
					sql = sql & " FROM BOARD"
					sql = sql & " WHERE BGNO = "&iBgno
					sql = sql & " AND BGORD = (SELECT MIN(BGORD)"
					sql = sql & "				FROM BOARD"
					sql = sql & "				WHERE BGNO="&iBgno
					sql = sql & "				AND BGORD>"&iBgord&")"
					brs.open sql, cnn

					If brs.BOF Or brs.EOF Then   '//3
						Set crs = Server.CreateObject("ADODB.RecordSet")
					
							sql = "SELECT BID, GUBN, BGNO, BGORD, BGDEPTH"
							sql = sql & " FROM BOARD"
							sql = sql & " WHERE BGNO=("
							sql = sql & "		SELECT MAX(BGNO)"
							sql = sql & "		FROM BOARD"
							sql = sql & "		WHERE BGNO<"&iBgno
							sql = sql & "		AND GUBN='N')"
							sql = sql & "	AND BGORD=0"
							sql = sql & "	AND GUBN='N'"
					Else 
						If brs(3) <> CInt(iBgord) Then '//2. 같은 그룹에 다음값이 있을때		
							Set crs = Server.CreateObject("ADODB.RecordSet")
							sql = "SELECT BID, GUBN, BGNO, BGORD, BGDEPTH"
							sql = sql & " FROM BOARD"
							sql = sql & " WHERE BGNO = "&iBgno
							sql = sql & " AND BGORD = (SELECT MIN(BGORD)"
							sql = sql & " 			FROM BOARD"
							sql = sql & " 			WHERE BGNO="&iBgno
							sql = sql & " 			AND BGORD>"&iBgord&")"
						'//같은 그룹에 다음값이없어서 다음 그룹의 최소
						End If '//2
					End If '//3
					crs.open sql, cnn
			%>
					<input type="button" value="다음글" onclick="location.href='board.asp?bid=<%=crs(0)%>&page=<%=strPage%>&gubn=<%=crs(1)%>&bgno=<%=crs(2)%>&bgord=<%=crs(3)%>&bgdepth=<%=crs(4)%>'">
			<%
				End If'//1
			End If '//0
			%>


			<%	
				Set rs = Server.CreateObject("ADODB.RecordSet") 
				sql = "SELECT ID FROM MEMBER WHERE LEVEL = 0"
				
				rs.open sql, cnn
				Do Until rs.eof
					If strSess = rs(0) And strSess <> strId Then '자신이 작성한 글이 아닌데 level 이 0인 사용자의 경우
				%>
						<INPUT style="float:right" type="button" value=" 삭제 "  onclick="Delete()">
				<%
					End If
					
				rs.MoveNext
				Loop
				rs.close
				Set rs = Nothing 

				Set rs = Server.CreateObject("ADODB.RecordSet") 
				sql = "SELECT ID FROM MEMBER WHERE LEVEL < 2"
				
				rs.open sql, cnn
				Do Until rs.eof
					If strSess = rs(0) And strGubn<>"Y" Then 'level이 2 이상인 사용자의 경우(글쓰기가 가능한 사용자들이 답글달기도 가능), 공지사항은 답글달기 불가능
				%>
						<INPUT style="float:right" type="button" value=" 답글달기 "  onclick="location.href='boardReply.asp?bid=<%=strBid%>&gubn=<%=strGubn%>&bgno=<%=iBgno%>&bgord=<%=iBgord%>&bgdepth=<%=iBgdepth%>'">
				<%
					End If
					
				rs.MoveNext
				Loop
				rs.close
				Set rs = Nothing 
				%>
					
				<%
				If strSess = strId Then '자신이 작성한 글은 삭제, 수정 가능
			%>
					<INPUT style="float:right" type="button" value=" 삭제 "  onclick="Delete()">
					<INPUT style="float:right" type="button" value=" 수정 "  onclick="location.href='boardUpdate.asp?bid=<%=strBid%>'">
			<%
					End If
			%>
		</TD>
	  </TR>
     </TABLE>
    </FORM>
	</center>
	<br>
	<br>
	<br>
	<hr>
	<!-- #include file="reply.asp" -->

<SCRIPT type="text/javascript" language="javascript">
	function Delete(){
			if(confirm("해당 게시글과 댓글은 모두 삭제됩니다. 정말 삭제하시겠습니까?"))
			{
				alert('게시글이 삭제되었습니다.');
				location.href="delete.asp?bid=<%=strBid%>&bgno=<%=iBgno%>&bgord=<%=iBgord%>&bgdepth=<%=iBgdepth%>"	
			}
			else
			{
			}
		}
	
	function CheckStrLength(obj, MaxLength)
	{
		var i, len = 0;

		if (typeof obj == "undefined")

		{
			return true;
		}

		var str = obj.value;

		for(i = 0; i < str.length; i++) (str.charCodeAt(i) > 255) ? len += 2 : len++;

		if (MaxLength < len)
		{
			
			alert("댓글은 " + MaxLength + "byte를 넘을 수 없습니다. (한글은 글자당 2byte로 계산됩니다.)");
		}
			return false;
			
	}
</SCRIPT>