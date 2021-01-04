<!-- #include file="dbConnect.asp" -->
<%
  Dim intBid, intCid, strId, strGubn

  intBid = Request.QueryString("bid")
  strId = LCase(Session("id"))
  intCid = Request.QueryString("cid")
  strGubn = Request.QueryString("gubn")
  
'///////////////////////////////////////////////////

with cmd
    .ActiveConnection = cnn
	.CommandText = "sp_insert_good"
	.CommandType = adCmdStoredProc
    .Parameters.Append .CreateParameter("@intBid", adInteger, adParamInput)
    .Parameters.Append .CreateParameter("@intCid", adInteger, adParamInput)
	.Parameters.Append .CreateParameter("@strId", advarwchar, adParamInput,20)
	.Parameters.Append .CreateParameter("@strGubn", advarwchar, adParamInput,1)
	.Parameters.Append .CreateParameter("@intResult",adInteger,adParamOutPut,0)

	.Parameters("@intBid") = intBid
	.Parameters("@intCid") = intCid
	.Parameters("@strId") = strId
	.Parameters("@strGubn") = strGubn
	.Parameters("@intResult") = 0

    .Execute , , adExecuteNoRecords
	Dim intResult
    intResult = .Parameters("@intResult")
End With
Set cnn = Nothing 
Set cmd = Nothing
	If ( intResult <> 0 ) Then
		   Response.write "<script language=""javascript"">alert('데이터 저장중 에러가 발생했습니다. 다시 한번 시도해 주세요.');</script>"
		   Response.AddHeader "REFRESH", "0;URL=board.asp?bid="&intBid
    Else 
		   Response.AddHeader "REFRESH", "0;URL=board.asp?bid="&intBid
    End If 

'///////////////////////////////////////////////////
  
'	If strGubn="Y" Then	'좋아요를 이미 눌렀다면
'		sql = "DELETE GOOD WHERE BID='"&intBid&"' AND CID='"&intCid&"' AND ID='"&strId&"' AND GUBN='Y'"
'		
'	ElseIf strGubn="N" Then 
'		sql = "INSERT INTO GOOD(BID, CID, ID, GUBN) VALUES('"&intBid&"', '"&intCid&"', '"&strId&"', 'Y')"
'		   
'	End If
'
'	rs.open sql, cnn
'
'    Response.AddHeader "REFRESH", "0;URL=board.asp?bid="&intBid
  

%>

