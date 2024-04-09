<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html id="adminPageHtml">
<head>
    <title>운영자메뉴</title>
    <link rel="stylesheet" href="/resources/css/adminCommon.css">
</head>
<body id="adminPageBody">

    <c:import url="header.jsp"></c:import>

    <div class="wrapper">
        <div class="adminMenuArea">
            <div class="adminMenuListArea">
                <ul class="adminMenuList">
                    <li><a href="itemlist">상품관리</a></li>
                    <li><a href="iteminfolist">등장작품/상품종류 관리</a></li>
                    <li><a href="inquirylist">문의관리</a></li>
                    <li><a href="reportlist">신고관리</a></li>
                </ul>
            </div>
        </div>
        <div class="adminMenuContentArea">
            <div class="adminMenuContent">
                <c:choose>
                    <c:when test="${menuType eq 'itemlist'}">
                        <c:import url="adminItemList.jsp"></c:import>
                    </c:when>
                    <c:when test="${menuType eq 'item'}">
                        <c:import url="itemEnrollForm.jsp"></c:import>
                    </c:when>
                    <c:otherwise>
                        미구현 페이지입니다.
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <c:import url="footer.jsp"></c:import>

    <script>
        $(document).ready(function () {
            $("a[href='${menuType}']").css("color","darkred");
        })
    </script>
</body>
</html>
