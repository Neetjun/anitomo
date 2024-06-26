<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
  <link rel="stylesheet" href="/anitomo/resources/css/header.css">
</head>
<body>
  <div class="headerArea">
    <div class="gnbArea">
      <ul>
        <a href="/anitomo/user/cs"><li>고객센터</li></a>
        <c:choose>
          <c:when test="${loginUser.userType ne null && loginUser.userType eq 0}">
            <a href="/anitomo/user/mypage/orderlist"><li>마이페이지</li></a>
          </c:when>
          <c:when test="${loginUser.userType ne null && loginUser.userType eq 1}">
            <a href="/anitomo/admin/itemlist"><li>운영자메뉴</li></a>
            <a href="/anitomo/user/mypage/orderlist"><li>마이페이지</li></a>
          </c:when>
        </c:choose>
        <c:choose>
          <c:when test="${loginUser.userName eq null}">
            <a href="/anitomo/user"><li>회원가입</li></a>
            <a href="/anitomo/user/login"><li>로그인</li></a>
          </c:when>
          <c:otherwise>
            <a href="/anitomo/cart"><li>장바구니</li></a>
            <a href="/anitomo/user/logout"><li>로그아웃</li></a>
            <li id="loginUserName">${loginUser.userName}님 어서오세요!</li>
          </c:otherwise>
        </c:choose>
      </ul>
    </div>
    <div class="logoArea">
      <div id="logoText"><a href="/anitomo/"><span>Anitomo!</span></a></div>
      <form action="" method="get" id="mainSearchFrom">
        <input type="text" id="searchInput" name="keyword">
        <i class="fa-solid fa-magnifying-glass searchIcon"></i>
      </form>
    </div>
    <div class="menuArea">
      <ul>
        <li><a href="/anitomo/item/list?listType=newest&sort=newest&page=1">신규상품</a></li>
        <li><a href="/anitomo/item/list?listType=series&sort=newest&page=1">작품별</a></li>
        <li><a href="/anitomo/item/list?listType=maker&sort=newest&page=1">제조사별</a></li>
        <li><a href="/anitomo/item/list?listType=itemType&sort=newest&page=1">종류별</a></li>
      </ul>
    </div>
  </div>

  <input type="text" id="errInput" value="${errorType}" hidden="hidden">

  <script src="https://kit.fontawesome.com/0fa0e562e0.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script>
    $(document).ready(function () {
      // 각종 에러 알림
      if($("#errInput").val() != "")
      {
        let errorType = $("#errInput").val();

        if(errorType == "userRegistrationError")
        {
          alert("회원가입에 실패했습니다. 다시 시도해주세요.");
          return;
        }
        else if(errorType == "loginRequired")
        {
          alert("로그인이 필요합니다!");
          return;
        }
      }
    })
  </script>
</body>
</html>


