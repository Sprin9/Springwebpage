<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

<!-- Bootstrap theme -->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap-theme.min.css"> --%>

<html>
<head>
	<title>Login</title>
</head>

<script type="text/javascript">
	$(function() {
	 $('input').iCheck({
		checkboxClass: 'icheckbox_square-blue',
		radioClass: 'iradio_square-blue',
		increaseArea: '20%' // optional
	
		});
	});
		
	
</script>

<body class="text-center">
	<div class="container">
		<div>
			<%@include file="../input/nav.jsp"%>
		</div>
	<br/>
	<br/>
	<br/>
	<form class="form-signin" name='homeForm' method="post" action="/member/login">

    <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
  
 	<c:if test="${member == null}">
 	<div>
		<label for="userId" class="sr-only">ID</label>
		<input type="text" id="userId" name="userId" class="form-control" placeholder="Email address" required="" autofocus="">
	</div>
	<div>
		<label for="userPass" class="sr-only">Password</label>
		<input type="password" id="userPass" name="userPass" class="form-control" placeholder="Password" required="">
	</div>
	</c:if>
	
	<div class="checkbox icheck">
	  <label>
	    <input type="checkbox" value="useCookie"> 로그인유지
	  </label>
	</div>
  
  
 	 <button id="LoginBtn" class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
	
	<c:if test="${msg == false}">
			<p style="color: red;">로그인 실패! 아이디와 비밀번호 확인해주세요.</p>
		</c:if>
	</form>
	
</div>
</body>

</html>