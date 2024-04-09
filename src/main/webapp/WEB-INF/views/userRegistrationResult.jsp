<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <title>환영해요</title>
    <link rel="stylesheet" href="/anitomo/resources/css/userRegistrationResult.css">
    <link rel="icon" href="/anitomo/resources/favicon.ico">
</head>
<body>
    <c:import url="header.jsp" charEncoding="utf-8"></c:import>

    <div class="resultFormArea wrapper">
        <div class="menuTitle">
            <i class="fa-solid fa-user"></i>
            <span>회원가입</span>
        </div>
        <div class="resultMessageArea">
            <span>회원가입이 완료되었습니다!</span>
            <div class="resultBtnArea">
                <button type="button">메인으로</button>
            </div>
        </div>
    </div>

    <c:import url="footer.jsp"></c:import>

    <script>
        $(document).ready(function () {
            $(".resultBtnArea > button").click(function () {
                    window.location.href = "/anitomo/";
            })
        })
    </script>
</body>
</html>
