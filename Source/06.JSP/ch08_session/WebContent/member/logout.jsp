<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String conPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script>
	
	setTimeout(function () {
     location.href='main.jsp';
  }, 2000);
	 
  </script>
  <style>
		#mainForm_wrap{
			width:650px; 
			margin: 0 auto;
			height:600px; 
			line-height: 600px; 
			text-align: center;
			font-size:1.5em; 
			font-weight: bold;
		}
		
		div{
		font-weight: bold;
		color: #A47160;
		}
	</style>
</head>
<body>

<jsp:include page="header.jsp"/>
	<div id="mainForm_wrap">
		로그아웃 되었습니다. 잠시후 페이지 이동이 있겠습니다
	</div>
	<jsp:include page="footer.jsp"/>
	<%
	session.setMaxInactiveInterval(2);
	 %>
	
</body>
</html>