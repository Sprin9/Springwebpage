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

<link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css">    

<html>
<head>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="/resources/js/summernote/summernote-lite.js"></script>
<script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<title>게시판</title>
</head>
<script type="text/javascript">
	$(document).ready(
			function() {
				var formObj = $("form[name='updateForm']");

				$(document).on("click", "#fileDel", function() {
					$(this).parent().remove();
				})

				fn_addFile();

				$(".cancel_btn").on(
						"click",
						function() {
							event.preventDefault();
							location.href = "/readView?bno=${update.bno}"
									+ "&page=${scri.page}"
									+ "&perPageNum=${scri.perPageNum}"
									+ "&searchType=${scri.searchType}"
									+ "&keyword=${scri.keyword}";
						})

				$(".update_btn").on("click", function() {
					if (fn_valiChk()) {
						return false;
					}
					formObj.attr("action", "/update");
					formObj.attr("method", "post");
					formObj.submit();
				})

				$('#summernote').summernote({
					height : 300, // 에디터 높이
					minHeight : null, // 최소 높이
					maxHeight : null, // 최대 높이
					focus : true, // 에디터 로딩후 포커스를 맞출지 여부
					lang : "ko-KR", // 한글 설정
					placeholder : '최대 2048자까지 쓸 수 있습니다' //placeholder 설정

				});
			})

	function fn_valiChk() {
		var updateForm = $("form[name='updateForm'] .chk").length;
		for (var i = 0; i < updateForm; i++) {
			if ($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null) {
				alert($(".chk").eq(i).attr("title"));
				return true;
			}
		}
	}

	function fn_addFile() {
		var fileIndex = 1;
		//$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileAddBtn'>"+"추가"+"</button></div>");
		$(".fileAdd_btn")
				.on(
						"click",
						function() {
							$("#fileIndex")
									.append(
											"<div><input type='file' style='float:left;' name='file_"
													+ (fileIndex++)
													+ "'>"
													+ "</button>"
													+ "<button type='button' style='float:right;' id='fileDelBtn'>"
													+ "삭제" + "</button></div>");
						});
		$(document).on("click", "#fileDelBtn", function() {
			$(this).parent().remove();

		});
	}
	var fileNoArry = new Array();
	var fileNameArry = new Array();
	function fn_del(value, name) {

		fileNoArry.push(value);
		fileNameArry.push(name);
		$("#fileNoDel").attr("value", fileNoArry);
		$("#fileNameDel").attr("value", fileNameArry);
	}
</script>
<body>
	<div>
		<%@include file="nav.jsp"%>
	</div>
	<div class="container">
		<div id="root">
			<hr />

			<section id="container">
				<form name="updateForm" role="form" method="post" action="/update"
					enctype="multipart/form-data">
					<input type="hidden" name="bno" value="${update.bno}"
						readonly="readonly" /> <input type="hidden" id="page" name="page"
						value="${scri.page}"> <input type="hidden" id="perPageNum"
						name="perPageNum" value="${scri.perPageNum}"> <input
						type="hidden" id="searchType" name="searchType"
						value="${scri.searchType}"> <input type="hidden"
						id="keyword" name="keyword" value="${scri.keyword}"> <input
						type="hidden" id="fileNoDel" name="fileNoDel[]" value="">
					<input type="hidden" id="fileNameDel" name="fileNameDel[]" value="">

					<table style="width: 100%;">
						<tbody>
							<tr>
								<td>
									<div class="form-group" style="width: 100%; height: 40px;">
										<input type="text" id="title" name="title"
											class="chk form-control" value="${update.title}" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="form-group">
										<textarea id="summernote" name="content"
											class="chk form-control"><c:out
												value="${update.content}" /></textarea>
									</div>
								</td>
							</tr>
							<tr>
								<td><label for="writer">작성자: <c:out value="${update.writer}" /></label></td>
							</tr>
							<tr>
								<td><label for="regdate">작성날짜: </label> <fmt:formatDate
										value="${update.regdate}" pattern="yyyy-MM-dd" /></td>
							</tr>

							<tr>
								<td id="fileIndex"><c:forEach var="file" items="${file}"
										varStatus="var">
										<div>
											<input type="hidden" id="FILE_NO" name="FILE_NO_${var.index}"
												value="${file.FILE_NO }"> <input type="hidden"
												id="FILE_NAME" name="FILE_NAME" value="FILE_NO_${var.index}">
											<a href="#" id="fileName" onclick="return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)
											<button id="fileDel"
												onclick="fn_del('${file.FILE_NO}','FILE_NO_${var.index}');"
												class="deletefile_btn" type="button">삭제</button>
											<br>
										</div>
									</c:forEach></td>
							</tr>

						</tbody>
					</table>
					<br />
					<div>
						<button type="submit" class="update_btn btn btn-success">저장</button>
						<button type="submit" class="cancel_btn btn btn-danger">취소</button>
						<button type="button" class="fileAdd_btn btn btn-warning">파일추가</button>
					</div>
				</form>
			</section>
			<hr />
		</div>
	</div>
</body>
</html>