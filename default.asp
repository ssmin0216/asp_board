  <meta http-equiv="Content-Type"
        content="text/html; charset=UTF-8">
  <title>Document</title>
 <body>
  <% Response.Write "ASP 테스트입니다." %>
  <BR>
 
<!-- ASP + MS-SQL연결 IP주소:10.2.40.199, 포트번호:1433, DB명:ssmDB, 사용자이름:ssm, 사용자비번:ssm1324 -->
  <%
   Set cnn = Server.CreateObject("ADODB.Connection")
   cnn.open "Provider=SQLOLEDB; Data Source=10.2.40.199,1433; Initial Catalog=ssmDB; User ID=ssm; Password=ssm1234;"
  %>

<!--  레코드값 가져옴 -->
  <%
   Set Rs = Server.CreateObject("ADODB.RecordSet") 
   SQL = "Select * from TT"
   
   Rs.open SQL, cnn
  %>
  
  <%
   Rs_name = Rs("name")
   
   Response.write Rs_name
  %>
 </body>
