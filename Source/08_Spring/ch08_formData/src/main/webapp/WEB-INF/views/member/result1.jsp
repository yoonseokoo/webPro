<%@ page language="java" contentType="text/html; charset= UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${conPath }/css/style.css" rel="stylesheet">
</head>
<body>
	<h2>Printing cnt and list at every request</h2>
	<h3>cnt : ${cnt }</h3>
	<h3>list : ${list }</h3>
	<h3>Member's personal information that was sent to result1.jsp page </h3>
	
	<h4>Name: ${name }</h4>
	<h4>Id: ${id }</h4>
	<h4>Pw: ${pw }</h4>
	<h4>Age: ${age }</h4>
	<h4>Email: ${email }</h4>
	<h4>Address: ${address }</h4>
	<button onclick="history.back()">뒤로가기</button>
	<button onclick="location.href='${conPath }/'">처음으로</button>
	
	
</body>
</html>