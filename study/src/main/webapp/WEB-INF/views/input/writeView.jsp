<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<!-- Bootstrap theme -->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap-theme.min.css"> --%>



<link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css">    

<html>
	<head>
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<script src="/resources/js/summernote/summernote-lite.js"></script>
		<script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>
		
	 	<title>글쓰기</title>
	 	
	</head>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='writeForm']");		
			$(".write_btn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
				formObj.attr("action", "/input/write");
				formObj.attr("method", "post");
				formObj.submit();
			});
			fn_addFile();
			
			$('#summernote').summernote({
				  height: 300,                 // 에디터 높이
				  minHeight: null,             // 최소 높이
				  maxHeight: null,             // 최대 높이
				  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
				  lang: "ko-KR",					// 한글 설정
				  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
		          
			});
			
		})
		
		
		
		function fn_valiChk(){
			var regForm = $("form[name='writeForm'] .chk").length;
			for(var i = 0; i<regForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
		
		function fn_addFile(){
			var fileIndex = 1;
			//$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileAddBtn'>"+"추가"+"</button></div>");
			$(".fileAdd_btn").on("click", function(){
				$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:left;' id='fileDelBtn'>"+"삭제"+"</button></div><br/><br/>");
			});
			$(document).on("click","#fileDelBtn", function(){
				$(this).parent().remove();
				
			});
		}
	</script>
	<body>
	
		<div id="root">

			<%@include file="nav.jsp" %>
			<br>
			
			<div class="container">
			<h1>게시판 > 글작성</h1>
			
			<hr />
			
				<form name="writeForm" method="post" action="/input/write" enctype="multipart/form-data">
					<table width="100%">
						<tbody>
							<c:if test="${member.userId != null}">
								<tr>
									<td>
									<div class="form-group" style="width:100%; height:40px;">
										<input type="text" id="title" name="title" class="chk form-control" value="제목을 입력하세요." />
									</div>
									</td>
								</tr>	
								<tr>
									<td>
									<br>
									<div class="form-group">
										<textarea id="summernote" name="content" class="chk form-control">내용을 입력하세요.</textarea>
									</div>
									</td>
								</tr>
								<tr>
									<td>
										<input type="hidden" id="writer" name="writer" class="chk" title="작성자를 입력하세요." value="${member.userId}"/>
									</td>
								<tr>
								
								<tr>
									<td id="fileIndex">
									</td>									
								</tr>
								
								<tr>
									<td>					
										<button class="write_btn btn btn-success" type="submit">작성</button>	
										<button class="fileAdd_btn btn btn-warning" type="button">파일추가</button>	
									</td>
								</tr>	
								
							</c:if>
							<c:if test="${member.userId == null}">
								<p>로그인 후에 작성하실 수 있습니다.</p>
							</c:if>
							
						</tbody>			
					</table>
				</form>
				
			
			<hr />
			</div>
			
		</div>
		
	</body>
</html>