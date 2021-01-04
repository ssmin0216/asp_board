<!--METADATA
TYPE="TypeLib"
NAME="Microsoft ActiveX Data Objects 2.6 Library"
UUID="{00000206-0000-0010-8000-00AA006D2EA4}"
VERSION="2.6"
-->
<!-- #include file="dbConnect.asp" -->
<%
     '<!-- ASP + MS-SQL연결 IP주소:10.2.40.199, 포트번호:1433, DB명:ssmDB, 사용자이름:ssm, 사용자비번:ssm1324 -->
     'Set cnn = Server.CreateObject("ADODB.Connection")
     'cnn.open "Provider=SQLOLEDB; Data Source=10.2.40.199,1433; Initial Catalog=ssmDB; User ID=ssm; Password=ssm1234;"
    
  
     '<!--  레코드값 가져옴 -->
     'Set rs = Server.CreateObject("ADODB.RecordSet") 
     
     rs.open "MEMBER", cnn, adOpenForwardOnly, adLockOptimistic, adCmdTable

     rs.Filter = "ID='"& Request.Form("ID") & "'"

     <!-- rs가 끝날때까지 -->
     If rs.EOF Then
	    rs.AddNew

	  rs("ID")   = LCase(Request.Form("ID"))
  	  rs("NAME") = LCase(Request.Form("NAME"))
  	  rs("PSWD") = LCase(Request.Form("PSWD1"))
	  

  	  rs.Update

	  rs_id = rs("ID")

	  Response.Write "<center><font size=20 color=blue>"&rs_id&"</font>님 회원가입을 축하합니다.</center>"
	  Response.Write "<center>3초후 로그인화면으로 자동전환됩니다.</center>"
 	  Response.AddHeader "REFRESH", "3;URL=login.asp"

	 Else
	 Response.Redirect "join.asp?OverID=True"
	 End If
%>

	