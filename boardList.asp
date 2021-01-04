<meta http-equiv="Content-Type"
 content="text/html; charset=UTF-8">
 <!-- #include file="boardTop.asp" -->
<%
	Dim cnn, rs, sql, bno
	Dim iBgno, iBgord, iBgdepth

	Dim pageCount'//총 페이지 수 저장
	Dim page: page = 1'//

	If Request("page") <> "" Then
		page = Request.QueryString("page")'넘겨져온 페이지 값이 담긴다.
	End If


	
	sql="SELECT BID, TITLE, ID, RDATE, VCNT, GUBN, BGNO, BGORD, BGDEPTH FROM BOARD ORDER BY GUBN DESC, BGNO DESC, BGORD"

	
	rs.pageSize=10 '//페이지당 갯수 결정


	'ASP로 MySQL ODBC 3.51 연결 시 페이징 absolutepage에서 에러가 발생한다 
	'아래와 같이 CursorLocation = 3 으로 지정 하면 해결 할 수 있다.
	rs.CursorLocation = 3 '<-- 커서 Type3

	rs.open sql, cnn

	
%>


<html>
 <title>게시판 목록</title>
 <style type="text/css">
	 table{
		width:80%;
		border-collapse: collapse;
	 }
	 td{
		border: 1px solid;
		border-collapse: collapse;
		padding:5px;
	 }
	 #title{
		width:20%;
		background-color:lightgray;
		text-align: center;
		font-weight:bold;
	 }
	.text{
		text-align:left;
	}
	a { /*하이퍼링크 밑줄 없애기*/
		text-decoration:none;
	} 

</style> 
 <body>
   <center>
    <BR><BR>

    <FORM NAME="boardListForm">
		<%
		Set brs = Server.CreateObject("ADODB.RecordSet") 

		sql = "SELECT LEVEL FROM MEMBER WHERE ID='"&Session("id")&"'"
		brs.open sql,cnn

		If brs(0)<>2 Then '레벨이 2가 아닌 경우만 글쓰기 가능
		%>
			<INPUT TYPE="button" STYLE="float:left; margin-left:10%" VALUE="글쓰기" ID="btn_write" ONCLICK="location.href='boardWrite.asp'">
		<%
		End If
		brs.close
		Set brs=nothing
		%>
		<br><br>
     <TABLE>
 	  <TR BGCOLOR="lightgray"STYLE="font-weight:bold" ID="title">
	    <TD width="5%">No.</TD>
        <TD width="50%" class="text">제목</TD>
		<TD width="15%" class="text">글쓴이</TD>
		<TD width="25%">등록일</TD>
		<TD width="5%">조회수</TD>
      </TR>

<%
	Dim i: i=1 '//페이지 사이즈 카운트. 초기식
	bno = 1
	 
	If rs.BOF Or rs.EOF Then%>
		</table>
		<h1 align="center">데이터가 없습니다</h1>
<%
	Else
		
		PageCount = rs.PageCount'//총 페이지 값 저장
		rs.AbsolutePage = Page'//
		Call ShowRecordSet(rs)

	End If

	Sub ShowRecordSet(rs)
	
	
	Do Until (rs.eof Or i > rs.PageSize)
		iBgno = rs(6) 
		iBgord = rs(7)
		iBgdepth = rs(8)
		
		If rs(5)="Y" Then '공지사항일 경우
	%>
			<TR ALIGN="center" style="background-color:lightyellow;">
			<TD><%=((page-1)*10)+bno%></TD>
			<TD class="text">
			   <A HREF="board.asp?bid=<%=rs(0)%>&page=<%=page%>&gubn=<%=rs(5)%>&bgno=<%=iBgno%>&bgord=<%=iBgord%>&bgdepth=<%=iBgdepth%>">
			   <공지사항>&nbsp;<%=rs(1)%>
				
	<%
		Else '공지사항이 아닌경우(답글 포함)
		dim nbsp
			for j=1 To iBgdepth-1 Step 1
			 nbsp = nbsp+"&nbsp;&nbsp;&nbsp;"
			Next
	%>
		  <TR ALIGN="center">
		  <TD><%=((page-1)*10)+bno%></TD>
			<TD class="text">
			    <A HREF="board.asp?bid=<%=rs(0)%>&page=<%=page%>&gubn=<%=rs(5)%>&bgno=<%=iBgno%>&bgord=<%=iBgord%>&bgdepth=<%=iBgdepth%>">
				<%=nbsp%><%=rs(1)%>	
			<%
				nbsp = ""
		End If
				 '제목에 댓글 갯수 뜨게 함
				Set crs = Server.CreateObject("ADODB.RecordSet") 
				sql = "SELECT COUNT(CONTENT) FROM COMMENT WHERE BID='"&rs(0)&"'"
				crs.open sql, cnn
				If crs(0)<>0 Then
				'댓글 수
			%>
				(<%=crs(0)%>)	
			<%
				End If

				crs.close
				Set crs=nothing
			%>
				</A>
			</TD>
			<TD class="text"><%=rs(2)%></TD> 
			<TD><%=rs(3)%></TD>
			<TD><%=rs(4)%></TD>
		  </TR>
	<% 
		rs.MoveNext
		i=i+1 '//증감식
		bno=bno +1
		Loop		
%>
	 </TABLE>
<%
	End Sub
%>
<%
	If page > 1 Then
%>
	 <A HREF="./boardList.asp?page=<%=page-1%>">[이전]</A>
<%
	Else
%>
	 <span style="color:silver;">[이전]</span>
<%
	End If

	Response.Write("[" & page & "/" & pageCount & "]")

	If CInt(page) < CInt(pageCount) Then

%>
	 <A HREF="./boardList.asp?page=<%=page+1%>">[다음]</A>
<%
	Else
%>
	 <span style="color:silver;">[다음]</span>
<%
	End If
%>
    </FORM>
  </center>
 </body>

</html>
