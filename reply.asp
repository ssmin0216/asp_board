<!--METADATA TYPE= "typelib" NAME= "ADODB Type Library"
FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll" -->
<meta http-equiv="Content-Type"
 content="text/html; charset=UTF-8">
<%
  Dim rPageCount'//총 페이지 수 저장
  Dim rpage: rpage = 1
  Dim strCid, iCgno, iCgord, iCgdepth

  'Dim iBgno, iBgord, iBgdepth	
  'iBgno = Request.QueryString("bgno")
  'iBgord = Request.QueryString("bgord")
  'iBgdepth = Request.QueryString("bgdepth")

	If Request("rpage") <> "" Then
		rpage = Request.QueryString("rpage")'넘겨져온 페이지 값이 담긴다.
	End If


  strBid = Request.QueryString("bid")
  strRPage = Request.QueryString("rpage")

  
  ' sql = "UPDATE BOARD SET VCNT = VCNT + 1"
  ' sql = sql & "WHERE BID =" & strBid
  ' cnn.Execute sql
   
   Set rs = Server.CreateObject("ADODB.RecordSet") 

   sql = "SELECT CID, ID, NAME, CONTENT, RDATE, CGNO, CGORD, CGDEPTH FROM COMMENT WHERE BID = '"&strBid&"' ORDER BY CGNO DESC, CGORD"



	rs.pageSize=5 '//페이지당 갯수 결정


	'ASP로 MySQL ODBC 3.51 연결 시 페이징 absoluterpage에서 에러가 발생한다 
	'아래와 같이 CursorLocation = 3 으로 지정 하면 해결 할 수 있다.
	rs.CursorLocation = 3 '<-- 커서 Type3

   rs.open sql, cnn
   strSess = LCase(Session("id"))
   
   
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
#hr0 {
 text-align:center;
 width:80%;
}
#hr1 {
 width:50%;
 margin-left : 10%;
 border-style : dashed;
 color : gray;

}
 </style>
 <body>
<form action="cReply.asp" method="post">
		<div><h2>댓글</h2></div>
		<INPUT TYPE="TEXT" name="bid" value="<%=strBid%>" hidden/>
		<div>
			<textarea cols="100%" rows="3" id="content" name="content" placeholder="댓글을 작성해보세요:)"maxlength="100" required></textarea>
			<INPUT type="submit" value="등록">
		</div>
</form>
<form action="good.asp" method="post">
		<div>최신순</div><p>
			<%	
				Dim i: i=1 '//페이지 사이즈 카운트. 초기식
			
				If rs.BOF Or rs.EOF Then
			%>
					
					<div><h3 align="center" style="color:gray">등록된 댓글이 없습니다</h3><div>
			<%
				Else
				
					rPageCount = rs.PageCount'//총 페이지 값 저장

					rs.AbsolutePage = rpage'//

					Call ShowRecordSet(rs)

				End If
			
				Sub ShowRecordSet(rs)

					Do Until (rs.eof Or i > rs.PageSize)
					iCgno = rs(5)
				    iCgord = rs(6)
				    iCgdepth = rs(7)

						dim nbsp
						for j=1 To iCgdepth-1 Step 1
						 nbsp = nbsp+"&nbsp;&nbsp;&nbsp;"
						Next	
			%>		
						<div><!-- ID -->
			<%
						If iCgdepth=1 Then '//자식인 글이면 └RE.표시
			%>
						<span style="font-weight:bold"><%=nbsp%><%=rs(1)%></span>
			<%
						Else 
			%>
						<span><%=nbsp%>└RE.</span><span style="font-weight:bold"> <%=rs(1)%></span>
			<%
						End If 
			%>			
							<span style="font-size:13px">
								<script>
								//익명성
								var name="<%=rs(2)%>";
								var oneName = name.substring(1,0);
								var ann = ""
								for(var j=0; j<name.length-1; j++){
									ann = ann+'*';
								}
								</script>
								<%
									strName = "<script>document.write('('+oneName+ann+')');</script>"
									Response.Write (strName)
								%>
							</span>
						</div>
						<!-- 내용, 좋아요 -->
						<div>&nbsp;&nbsp;&nbsp;&nbsp;<%=nbsp%><%=rs(3)%></div>
						<div style="color:gray; font-size:12px; margin-left:10%;">
			<%
							'해당 댓글(cid)의 총 좋아요 갯수
							Set grs = Server.CreateObject("ADODB.RecordSet") 
							sql = "SELECT COUNT(CID) FROM GOOD GROUP BY CID HAVING CID='"&rs(0)&"'"
							grs.open sql,cnn
							If grs.EOF Then
			%>
								<span><%=nbsp%>0</span>
			<%
							Else 
			%>
								<span><%=nbsp%><%=grs(0)%></span>
			<%
							End If 
							nbsp = ""


							Set grs = Server.CreateObject("ADODB.RecordSet") 
							sql = "SELECT CID, ID, GUBN FROM GOOD  WHERE ID='"&strSess&"' AND CID = '"&rs(0)&"' ORDER BY CID DESC"
							grs.open sql,cnn

							strCid=rs(0)
							
							If  grs.EOF Or grs.BOF Then '좋아요를 안눌렀으면	
			%>
								<span id="good<%=strCid%>" name="gy" onclick="gy(id)">좋아요♡</span>
			<%		
							Else	'좋아요를 눌렀으면		
			%>
								<span id="good<%=strCid%>" name="gn" onclick="gn(id)">좋아요♥</span>
			<%
							End If
			%>
							</div>
								
						
						
						<!-- 등록일, 삭제버튼 -->
						<div style="color:gray; font-size:12px"><%=nbsp%><%=rs(4)%>
			<%	
						Set rrs = Server.CreateObject("ADODB.RecordSet") 
						sql = "SELECT ID FROM MEMBER WHERE LEVEL = 0"
						
						rrs.open sql, cnn
			%>
						
			<%

						Do Until rrs.eof
							If strSess <> rs(1) And  strSess = rrs(0) Then '자신이 작성한 댓글이 아니고 level이 0인경우 삭제 가능
			%>
							<INPUT type="button" value=" 삭제 " id="delete<%=strCid%>" onclick="cDelete(id)">
			<%
							End If
							rrs.MoveNext
						Loop
						'rrs.close
						If strSess = rs(1) Then '자신이 작성한 댓글인경우 삭제 가능 
			%>
							<INPUT type="button" id="delete<%=strCid%>" value=" 삭제 " onclick="cDelete(id)">
			<%
						End If
			%>
			</form>
			<form action="cReply.asp" method="post">
				<INPUT TYPE="TEXT" name="bid" value="<%=strBid%>" hidden/>
				<INPUT TYPE="TEXT" name="cid" value="<%=strCid%>" hidden/>
				<INPUT TYPE="TEXT" name="cgno" value="<%=iCgno%>" hidden/>
				<INPUT TYPE="TEXT" name="cgord" value="<%=iCgord%>" hidden/>
				<INPUT TYPE="TEXT" name="cgdepth" value="<%=iCgdepth%>" hidden/>
				<INPUT TYPE="TEXT" name="bgno" value="<%=iBgno%>" hidden/>
				<INPUT TYPE="TEXT" name="bgord" value="<%=iBgord%>" hidden/>
				<INPUT TYPE="TEXT" name="bgdepth" value="<%=iBgdepth%>" hidden/>
					<INPUT type="button" value="답글달기" onclick="showHide('show_creply<%=strCid%>');"><br>
						</div>
						<div id="show_creply<%=strCid%>" style="display:none">
							<textarea cols="80%" rows="3" id="comment<%=strCid%>" name="comment<%=strCid%>" placeholder="답글을 작성해보세요:)"maxlength="100" required></textarea>
							<INPUT type="submit" value="등록" onclick="location.href='cReply.asp?bid=<%=strBid%>&cid=<%=strCid%>&cgno=<%=iCgno%>&cgord=<%=iCgord%>&cgdepth=<%=iCgdepth%>'">
						</div>
						<%
						If iCgdepth=1 Then '//부모인 글이면 
			%>
							<hr id="hr0">
			<%
						Else 
			%>
							<hr id="hr1">
			<%
						End If 
			%>			
						
			<%
						rs.MoveNext
						i=i+1 '//증감식
					Loop
				End Sub
			%>
			<div>
			<%
				If rpage > 1 Then
			%>
				 <A HREF="./board.asp?bid=<%=strBid%>&rpage=<%=rpage-1%>">[이전]</A>
			<%
				Else
			%>
				 <span style="color:silver;">[이전]</span>
			<%
				End If

				Response.Write("[" & rpage & "/" & rpageCount & "]")

				If CInt(rpage) < CInt(rpageCount) Then

			%>
				 <A HREF="./board.asp?bid=<%=strBid%>&rpage=<%=rpage+1%>">[다음]</A>
			<%
				Else
			%>
				 <span STYLE="color:silver;" >[다음]</span>

			<%
				End If
			%>
			</div>
	</form>
 </body>
</html>

<script type='text/javascript'>
	function showHide(obj){
		var creply = document.getElementById(obj);
		if(creply.style.display != 'none'){
				creply.style.display = 'none';
			}
		else{
				creply.style.display = '';
			}
		}

	function gy(id){ 
		alert("좋아요를 눌렀습니다.");
		var cid=id.substring(4,10);
		location.href="good.asp?bid=<%=strBid%>&cid="+cid+"&gubn=N" 
		} 
	function gn(id){
		alert("좋아요가 취소되었습니다."); 
		var cid=id.substring(4,10);
		location.href="good.asp?bid=<%=strBid%>&cid="+cid+"&gubn=Y"	
			} 
	function cDelete(id){
		var cid=id.substring(6,10);
			if(confirm("해당 댓글과 답글 모두 삭제됩니다. 정말 삭제하시겠습니까?"))
			{
				alert('댓글이 삭제되었습니다.');
				location.href="cDelete.asp?bid=<%=strBid%>&cid="+cid
			}
			else
			{
			}
		}
</script>
