<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<!-- Bootstrap theme -->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap-theme.min.css"> --%>

<html>
<head>

<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>회원가입</title>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		// 취소
		$(".cencle").on("click", function() {

			location.href = "/";

		})

		$("#submit").on("click", function() {
			if ($("#userPass").val() == "") {
				alert("비밀번호를 입력해주세요.");
				$("#userPass").focus();
				return false;
			}
			if ($("#userName").val() == "") {
				alert("성명을 입력해주세요.");
				$("#userName").focus();
				return false;
			}
			$.ajax({
				url : "/member/passChk",
				type : "POST",
				dateType : "json",
				data : $("#updateForm").serializeArray(),
				success : function(data) {

					if (data == true) {
						if (confirm("회원수정하시겠습니까?")) {
							$("#updateForm").submit();
						}

					} else {
						alert("패스워드가 틀렸습니다.");
						return;

					}
				}
			})
		});
	})
</script>
<body>
	<div>
		<%@include file="../input/nav.jsp"%>
	</div>
	<br>
	<div class="container">


		<section id="container">
			<form id="updateForm" action="/member/memberUpdate" method="post">
				<div class="form-group has-feedback">
					<label class="control-label" for="userId">아이디</label> <input
						class="form-control" type="text" id="userId" name="userId"
						value="${member.userId}" readonly="readonly" />
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userPass">현재 패스워드</label> <input
						class="form-control" type="password" id="userPass" name="userPass" />
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="ChangeuserPass">변경 패스워드</label> <input
						class="form-control" type="password" id="ChangeuserPass"
						name="ChangeuserPass" />
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userName">성명</label> <input
						class="form-control" type="text" id="userName" name="userName"
						value="${member.userName}" />
				</div>
			</form>
			<div class="form-group has-feedback">
				<button class="btn btn-success" type="button" id="submit">회원정보수정</button>
				<button class="cencle btn btn-danger" type="button">취소</button>
			</div>
		</section>
	</div>
</body>

</html>