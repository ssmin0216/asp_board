<meta http-equiv="Content-Type"
 content="text/html; charset=UTF-8">
 <!-- #include file="boardTop.asp" -->
<%	
	'이사람의 레벨을 확인
	sql = "SELECT LEVEL FROM MEMBER WHERE ID='"&Session("id")&"'"
	rs.open sql, cnn

	'세션 ID의 level이 0이 아닌경우 강제적으로 meberList.asp에 접근하려고 하는 경우 login.asp로 강제 이동 - dbconnect.asp에서 한번에 처리하면저 주석처리함
	'If rs(0)<>0 Then
	'	Response.write ("<script language=""javascript"">alert('잘못된 접근입니다. '); history.go(-1); </script>")
	'End If
	rs.close

	Dim cnn, rs, bno

	Dim pageCount'//총 페이지 수 저장
	Dim page: page = 1'//

	If Request("page") <> "" Then
		page = Request.QueryString("page")'넘겨져온 페이지 값이 담긴다.
	End If
	
	sql="SELECT ID, NAME, LEVEL FROM MEMBER ORDER BY MID"

	rs.pageSize=10 '//페이지 사이즈 결정


	'ASP로 MySQL ODBC 3.51 연결 시 페이징 absolutepage에서 에러가 발생한다 
	'아래와 같이 CursorLocation = 3 으로 지정 하면 해결 할 수 있다.
	rs.CursorLocation = 3 '<-- 커서 Type3

	rs.open sql, cnn

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
	 #title{
		width:20%;
		background-color:lightgreen;
		text-align: center;
		font-weight:bold;
	 }
	 .btn{
	  margin-right:10%;
	 }

 </style>
 <body>
    <BR><BR>
    <FORM NAME="boardListForm" action="mUpdate.asp" method="POST">
		<span style="margin-left:10%">
			<INPUT TYPE="BUTTON"  VALUE="게시판 목록으로" ONCLICK="location.href='boardList.asp'">
		</span>
		<BR><BR>
		<span style="margin-left:10%">[회원 목록]</span>
		<div align="right">
			<INPUT TYPE="submit" VALUE="회원정보 수정완료" class="btn">
		</div>
		<p>
	<center>
     <TABLE>
 	  <TR STYLE="font-weight:bold" ID="title">
	    <TD>No.</TD>
        <TD>ID</TD>
		<TD>NAME</TD>
		<TD>LEVEL</TD>
      </TR>

<%
	Dim i: i=1 '//페이지 사이즈 카운트. 초기식
	bno = 1
	 
	If rs.BOF Or rs.EOF Then%>
		</table>
		<h1 align="center">검색된 데이터가 없습니다</h1>
<%
	Else

		PageCount = rs.PageCount'//총 페이지 값 저장

		rs.AbsolutePage = Page'//

		Call ShowRecordSet(rs)

	End If

	Sub ShowRecordSet(rs)
	
	Do Until (rs.eof Or i > rs.PageSize)
	Dim j 
	j = ((page-1)*10)+bno
	'NO.는 페이지수 -1 만큼 p*10+bno
%>
	  <TR ALIGN="center">
	  	<TD><%=j%></TD>
	  	<TD><%=rs(0)%></TD>
	  	<TD><%=rs(1)%></TD>
	  	<TD>
			<SELECT NAME="LEVEL" ID="LEVEL<%=j%>" onChange="test(id,this.value)">
				<option value="<%=rs(2)%>"><%=rs(2)%></option>
				<option value="0" name="0">0</option>
				<option value="1" name="1">1</option>
				<option value="2" name="2">2</option>
			</SELECT>
		</TD>
	  </TR>
	 <INPUT TYPE="TEXT" id="lvl<%=j%>" name="lvl<%=j%>" value="<%=rs(2)%>" hidden/>

<% 
	rs.MoveNext
	i=i+1 '//증감식
	bno= bno +1
	Loop
%>
	 </TABLE>
<%
	End Sub
%>
<%
	If page > 1 Then
%>
	 <A HREF="./memberList.asp?page=<%=page-1%>&searchTitle=<%=searchTitle%>">[이전]</A>
<%
	Else
%>
	 <span style="color:silver;">[이전]</span>
<%
	End If

	Response.Write("[" & page & "/" & pageCount & "]")

	If CInt(page) < CInt(pageCount) Then

%>
	 <A HREF="./memberList.asp?page=<%=page+1%>&searchTitle=<%=searchTitle%>">[다음]</A>
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
<script type="text/javascript">
	  function test(id, selectVal){
		  console.log('id: ' + id);
		  console.log('selectVal: ' + selectVal);
		  var i = id.substring(5,7);
		  document.getElementById('lvl'+i).value = selectVal;
		  }
	
</script>