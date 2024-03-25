<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <title>주문완료</title>
    <link rel="stylesheet" href="/resources/css/orderResult.css">
    <link rel="icon" href="/resources/favicon.ico">
</head>
<body>
<c:import url="header.jsp" charEncoding="utf-8"></c:import>

<div class="resultFormArea wrapper">
    <div class="menuTitle">
        <span>주문완료</span>
    </div>
    <div class="resultMessageArea">
        <span>주문이 완료되었습니다!</span>
        <div class="resultBtnArea">
            <button type="button" id="toOrderBtn">주문확인</button>
            <button type="button" id="toMainBtn">메인으로</button>
        </div>
    </div>
</div>

<c:import url="footer.jsp"></c:import>

<script>
    $(document).ready(function () {
        $(".resultBtnArea > button").click(function () {
            if($(this).attr("id") == "toMainBtn")
                window.location.href = "/";
            else
                window.location.href = "/mypage/orderlist";
        })
    })
</script>

</body>
</html>
