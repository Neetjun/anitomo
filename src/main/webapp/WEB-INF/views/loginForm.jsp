<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Neetjun
  Date: 2024-03-16
  Time: 오전 5:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
  <link rel="stylesheet" href="/resources/css/loginForm.css">
  <link rel="icon" href="/resources/favicon.ico">
</head>
<body>
  <c:import url="header.jsp"></c:import>

  <div class="loginFormArea wrapper">
    <div class="menuTitle">
      <i class="fa-solid fa-user"></i>
      <span>로그인</span>
    </div>
    <form action="/user/login" method="post" id="loginForm">
      <div class="inputArea">
        <div class="inputId">
          <div>아이디</div>
          <input type="text" id="userId" name="userId">
        </div>
        <div class="inputPw">
          <div>비밀번호</div>
          <input type="password" id="userPw" name="userPw">
          <button type="button" id="loginBtn">로그인</button>
        </div>
      </div>
      <input type="text" value="${referer}" name="referer" hidden="hidden">
    </form>
  </div>

  <input type="text" id="errInput" value="${errorType}" hidden="hidden">

  <c:import url="footer.jsp"></c:import>

  <script>
    $(document).ready(function () {
        if($("#errInput").val() == "loginError")
        {
          alert("아이디 또는 비밀번호를 확인해주세요!");
        }

        $("#loginBtn").click(function () {
          $("#loginForm").submit();
        });
    })
  </script>
</body>
</html>
