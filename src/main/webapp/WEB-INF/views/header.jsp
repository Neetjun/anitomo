<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
  <link rel="stylesheet" href="/resources/css/header.css">
</head>
<body>
  <div class="headerArea">
    <div class="gnbArea">
      <ul>
        <a href=""><li>고객센터</li></a>
        <a href=""><li>마이페이지</li></a>
        <a href=""><li>장바구니</li></a>
        <c:choose>
          <c:when test="${loginUser.userName eq null}">
            <a href="/user"><li>회원가입</li></a>
            <a href="/user/login"><li>로그인</li></a>
          </c:when>
          <c:otherwise>
            <a href="/user/logout"><li>로그아웃</li></a>
            <li id="loginUserName">${loginUser.userName}님 어서오세요!</li>
          </c:otherwise>
        </c:choose>



      </ul>
    </div>
    <div class="logoArea">
      <a href="/"><span>Anitomo!</span></a>
      <input type="text" id="searchInput">
      <i class="fa-solid fa-magnifying-glass"></i>
    </div>
    <div class="menuArea">
      <ul>
        <li>신규상품</li>
        <li>작품별</li>
        <li>제조사별</li>
        <li>종류별</li>
      </ul>
    </div>
  </div>

  <script src="https://kit.fontawesome.com/0fa0e562e0.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</body>
</html>


