<meta http-equiv="Content-Type"
 content="text/html; charset=UTF-8">
 <!-- #include file="dbConnect.asp" -->
 <!-- #include file="boardTop.asp" -->
<%
  Dim sql
  Dim strBid
  
  strBid = Request.QueryString("bid")

   sql = "SELECT TITLE, VCNT, RDATE, ID, CONTENT FROM BOARD WHERE BID =" & strBid
   rs.open sql, cnn
' rs(0) - 제목 
' rs(1) - 조회수
' rs(2) - 등록일
' rs(3) - 등록자
' rs(4) - 내용
	'등록자가 아닌 경우 강제적으로 boardUpdate.asp에 접근하려고 하는 경우 차단
   If rs(3)<>Session("id") Then
   		Response.write ("<script language=""javascript"">alert('잘못된 접근입니다. ');	history.go(-1); </script>")
	End If
%>
<html>
 <title>게시판 글쓰기</title>
 <style>
 table{
 	width:80%;
	height:60%;
	border-collapse: collapse;
 }
 td{
	border: 1px solid;
	border-collapse: collapse;
	padding:5px;
 }
 .t_content{
	height: 90%;
	padding-top:0px;
 }
 #t_title{
	width:20%;
	background-color:lightgray;
	text-align: center;
	font-weight:bold;
 }
 </style>
 <body>
  <center>
    <BR><BR>
    <FORM ACTION="update.asp?bid=<%=strBid%>" NAME="boardForm" METHOD="POST" ONSUBMIT="return noNull();">
     <TABLE>
 	  <TR>
        <TD id="t_title">제목</TD>
		<TD>
			<INPUT TYPE="TEXT" id="TITLE" NAME="TITLE" VALUE="<%=rs(0)%>" maxlength="50" SIZE="100" onblur="JavaScript:CheckStrLength(this, 50);" required>
		</TD>
	  </TR>
	  <TR class="t_content">
        <TD id="t_title">내용</TD>
		<TD>
			<TEXTAREA cols="80" rows="30" id="CONTENT" NAME="CONTENT" onblur="JavaScript:CheckStrLength(this, 1000);" required><%=rs(4)%></TEXTAREA>
		</TD>
	  </TR>
	  <TR>
	  	<TD colspan="4">
			<INPUT type="button" value="목록" onclick="location.href='boardList.asp'">
			<INPUT style="float:right" type="button" value="수정 취소" onclick="location.href='board.asp?bid=<%=strBid%>'">
			<INPUT style="float:right" type="submit" value="수정 완료">
		</TD>
	  </TR>
     </TABLE>
    </FORM>
  </center>
 </body>
</html>
<script type="text/javascript">  
		document.getElementById('TITLE').focus();
		function noNull(){

			var title = document.getElementById('TITLE');
			var content = document.getElementById('CONTENT');

				trimTitle = title.value.trim(); // 앞과 뒤의 공백만 제거
				trimContent = content.value.trim();
				if(trimTitle=="")
				{
					alert("제목을 다시 입력해주세요. 공백은 안되요~");
					title.value="";
					title.focus();

					return false;
				}
				if(trimContent=="")
				{
					alert("내용을 다시 입력해주세요. 공백은 안되요~");
					content.value=""
					content.focus();
					return false;
				}
				return true;
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
		if(MaxLength > 100){
			alert("내용은 "+ MaxLength + "byte를 넘을 수 없습니다. (한글은 글자당 2byte로 계산됩니다.)");	
		}
        else{
			alert("제목은 " + MaxLength + "byte를 넘을 수 없습니다. (한글은 글자당 2byte로 계산됩니다.)");
		}
		
        return false;
		
    }

 

    return true;

}

</script>  
