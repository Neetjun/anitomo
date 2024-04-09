<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>페이지를 찾을 수 없습니다.</title>
    <link rel="stylesheet" href="/anitomo/resources/css/orderResult.css">
    <link rel="icon" href="/anitomo/resources/favicon.ico">
</head>
<body>

    <c:import url="header.jsp"></c:import>

    <div class="wrapper">
        <div class="menuTitle"></div>
        <div class="resultMessageArea">
            <span>페이지를 찾을 수 없습니다 ㅠㅠ</span>
            <div class="resultBtnArea">
                <button type="button" id="toMainBtn">메인으로</button>
            </div>
        </div>
    </div>

    <c:import url="footer.jsp"></c:import>
    <script>
        $("#toMainBtn").click(function () {
            window.location.href = "/";
        })
    </script>
</body>
</html>
