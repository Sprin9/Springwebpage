<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">

<!-- Bootstrap theme -->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap-theme.min.css"> --%>

<html>
<head>
<title>Login</title>
</head>

<script type="text/javascript">
	$(function() {
		$('input').iCheck({
			checkboxClass : 'icheckbox_square-blue',
			radioClass : 'iradio_square-blue',
			increaseArea : '20%' // optional

		});
	});
</script>

<body class="text-center">
	<div>
		<%@include file="../input/nav.jsp"%>
	</div>

	<div class="container">
		<br /> <br /> <br /> <br />

		<form class="form-signin" name='homeForm' method="post"
			action="/member/login">
			<table border="0" width="400px" align="center">
			<tr><td align="center">
				<h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
				<br>
			</td></tr>
			
			<tr><td align="center">
				<c:if test="${member == null}">
					<div id="center">
						<label for="userId" class="sr-only">ID</label> <input type="text"
							id="userId" name="userId" class="form-control" placeholder="ID"
							required="" autofocus="">
					</div>
					<br>
					<div id="center">
						<label for="userPass" class="sr-only">Password</label> <input
							type="password" id="userPass" name="userPass"
							class="form-control" placeholder="Password" required="">
					</div>
					<br />
				</c:if>

				<div class="checkbox icheck">
					<label> <input type="checkbox" id="useCookie"
						name="useCookie" value="true"> 로그인유지
					</label>
				</div>

				<div id="center">
					<button id="LoginBtn" class="btn btn-lg btn-primary btn-block"
						type="submit">Sign in</button>
				</div>

				<c:if test="${msg == false}">
					<p style="color: red;">로그인 실패! 아이디와 비밀번호 확인해주세요.</p>
				</c:if>
				</td></tr>
			</table>
		</form>
	</div>
</body>

</html>