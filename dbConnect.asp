<!--METADATA TYPE= "typelib"  NAME= "ADODB Type Library" FILE="C:\Program Files\Common Files\System\ado\msado15.dll"  --> 


<%
'@Language="VBScript" CODEPAGE="65001" 
Response.CharSet="utf-8"
 
Session.codepage="65001"
 
Response.codepage="65001"
 
Response.ContentType="text/html;charset=utf-8"

'IF Len(Request.ServerVariables("HTTP_REFERER")) = 0 Then
'   response.write "<script>alert('잘못된 접근경로입니다. 다시 로그인 하십시오.');</script>"
'   Session.abandon
'	Response.AddHeader "REFRESH", "0,URL=login.asp"
'   response.End
'END IF

' ASP + MS-SQL연결 IP주소:10.2.40.199, 포트번호:1433, DB명:ssmDB, 사용자이름:ssm, 사용자비번:ssm1324
   Set cnn = Server.CreateObject("ADODB.Connection")
   cnn.open "Provider=SQLOLEDB; Data Source=10.2.40.199,1433; Initial Catalog=ssmDB; User ID=ssm; Password=ssm1234;"
  

'레코드값 가져옴
   Set rs = Server.CreateObject("ADODB.RecordSet") 

'//Procedure Command
Set cmd = Server.CreateObject("ADODB.Command")
%>
