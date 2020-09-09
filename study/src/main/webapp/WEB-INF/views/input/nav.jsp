<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

<!-- Bootstrap theme -->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap-theme.min.css"> --%>

<!-- 부트스트랩 바 -->

<div class="container">
<nav class="navbar navbar-expand navbar-dark bg-dark">
  <a class="navbar-brand" href="/"><h1>SPRING</h1></a>

  <div class="collapse navbar-collapse" id="navbarsExample02">
    <ul class="navbar-nav mr-auto">
    
      <li class="nav-item active">
        <a class="nav-link" href="/list">게시판 <span class="sr-only">(current)</span></a>
      </li>
      
       <li class="nav-item active">
        <c:if test="${member == null}"><a class="nav-link" href="/member/register">회원가입<span class="sr-only">(current)</span></a></c:if>
      </li>
      
      <li class="nav-item active">
        <c:if test="${member != null}"><a class="nav-link" href="/member/logout">로그아웃<span class="sr-only">(current)</span></a></c:if>
        <c:if test="${member == null}"><a class="nav-link" href="/member/login">로그인<span class="sr-only">(current)</span></a></c:if>
      </li>
      

      <li class="nav-item active">
        <c:if test="${member != null}"><a class="nav-link" href="/member/memberUpdateView">회원정보수정<span class="sr-only">(current)</span></a></c:if>
      </li>
      
      <li class="nav-item active">
    	<c:if test="${member != null}"><a class="nav-link">이름: ${member.userName}님<span class="sr-only">(current)</span></a></c:if>
      </li>
      
    </ul>
    
  </div>
</nav>
</div>