<!-- #include file="dbConnect.asp" -->
<%
  Dim strId, strComment, strContent
  Dim intBid, intCid, iCgno, iCgord, iCgdepth
  Dim iBgno, iBgord, iBgdepth
  'iBgno = Request.Form("bgno")
  'iBgord = Request.Form("bgord")
  'iBgdepth = Request.Form("bgdepth")

  intBid = Request.Form("bid")
  intCid = Request.Form("cid")
  strId = LCase(Session("id"))
  strComment = Trim(Request("comment"&intCid))
  iCgno = Request.Form("cgno")
  iCgord = Request.Form("cgord")
  iCgdepth = Request.Form("cgdepth")
  strContent = Trim(Request.Form("content"))

with cmd
    .ActiveConnection = cnn
	If iCgno<>"" then	'//댓글의 답글
		.CommandText = "sp_insert_creply"
		.CommandType = adCmdStoredProc
		.Parameters.Append .CreateParameter("@intBid", adInteger, adParamInput)
		.Parameters.Append .CreateParameter("@strId", advarwchar, adParamInput,20)
		.Parameters.Append .CreateParameter("@strComment", advarwchar, adParamInput,100)
		.Parameters.Append .CreateParameter("@iCgno", adInteger, adParamInput)
		.Parameters.Append .CreateParameter("@iCgord", adInteger, adParamInput)
		.Parameters.Append .CreateParameter("@iCgdepth", adInteger, adParamInput)
		.Parameters.Append .CreateParameter("@intResult",adInteger,adParamOutPut,0)
		

		.Parameters("@intBid") = intBid
		.Parameters("@strId") = strId
		.Parameters("@strComment") = strComment
		.Parameters("@iCgno") = iCgno
		.Parameters("@iCgord") = iCgord
		.Parameters("@iCgdepth") = iCgdepth
		.Parameters("@intResult") = 0
		
	Else '//댓글
		.CommandText = "sp_insert_comment"
		.CommandType = adCmdStoredProc
		.Parameters.Append .CreateParameter("@intBid", adInteger, adParamInput)
		.Parameters.Append .CreateParameter("@strId", advarwchar, adParamInput,20)
		.Parameters.Append .CreateParameter("strContent", advarwchar, adParamInput,100)
		.Parameters.Append .CreateParameter("@intResult",adInteger,adParamOutPut,0)

		.Parameters("@intBid") = intBid
		.Parameters("@strId") = strId
		.Parameters("strContent") = strContent
		.Parameters("@intResult") = 0
	End If 
	

    .Execute , , adExecuteNoRecords
	Dim intResult, intLevelUp
    intResult = .Parameters("@intResult")
End With
Set cnn = Nothing 
Set cmd = Nothing
	If ( intResult <> 0 ) Then
		   Response.write "<script language=""javascript"">alert('데이터 저장중 에러가 발생했습니다. 다시 한번 시도해 주세요.');</script>"
		   Response.AddHeader "REFRESH", "0;URL=board.asp?bid="&intBid
    Else 
		 
		   Response.write "<script language=""javascript"">alert('댓글을 등록하였습니다.');</script>"
					'&"&gubn=N&bgno="&iBgno&"&bgord="&iBgord&"&bgdepth="&iBgdepth
			Response.AddHeader "REFRESH", "0;URL=board.asp?bid="&intBid
    End If 

 'sql = "UPDATE COMMENT SET CGORD = CGORD + 1 WHERE CGORD > "&iCgord
 'cnn.Execute sql
 '
 '
 'sql = "SELECT NAME FROM MEMBER WHERE ID = '"&strId&"'"
 'rs.open sql, cnn
 'strName = rs(0)
 '
 'sql = "INSERT INTO COMMENT (BID, ID, NAME, CONTENT, RDATE, CGNO, CGORD, CGDEPTH) VALUES '('"&intBid&"', '"&strId&"', '"&strName&"','"&strComment&"', GETDATE(), "&iCgno&", "&iCgord&"+1, '"&iCgdepth&"+1)"
 'cnn.Execute sql
 'Response.write "sql : "&sql&"<BR>"

'//└RE.는 리스트로 띄울때 CGDEPTH가 0이 아닐때 쓰도록 하기..
'Response.write "<script language=""javascript"">alert('댓글을 등록하였습니다.');</script>"
' Response.AddHeader "REFRESH", "0;URL=board.asp?bid="&intBid
%>