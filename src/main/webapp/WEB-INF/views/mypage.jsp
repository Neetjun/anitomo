<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>마이페이지</title>
    <link rel="stylesheet" href="/resources/css/mypageCommon.css">
</head>
<body>

    <c:import url="header.jsp"></c:import>


    <div class="sidebarMenuArea">
        <div class="menuText">
            마이페이지
        </div>
        <div class="sidebarMenuList">
            <ul class="sidebarMenu">
                <li class="userMenu"><a href="/user/mypage/orderlist">주문내역</a></li>
                <li class="userMenu"><a href="/user/mypage/reviewlist">리뷰관리</a></li>
                <li class="userMenu"><a href="/user/mypage/inquirylist">문의관리</a></li>
                <li class="userMenu"><a href="/user/mypage/paymentmethod">결제수단관리</a></li>
                <li class="userMenu"><a href="/user/mypage/userinfo">개인정보변경</a></li>
            </ul>
        </div>
    </div>

    <div class="mypageContentArea wrapper">
        <c:choose>
            <c:when test="${page eq 'orderlist'}">
                <c:import url="mypageOrderList.jsp"></c:import>
            </c:when>
            <c:when test="${page eq 'reviewlist'}">
                <c:import url="reviewManagement.jsp"></c:import>
            </c:when>
            <c:when test="${page eq 'review'}">
                <c:import url="reviewForm.jsp"></c:import>
            </c:when>
            <c:otherwise>
                <div style="margin-left: 500px">미구현 페이지입니다.</div>
            </c:otherwise>
        </c:choose>
    </div>

    <c:import url="footer.jsp"></c:import>

    <script>
        $(document).ready(function () {

            // 사이드메뉴 위치 조정
            function setSidebarPosition()
            {
                let position = $(".wrapper").offset();
                console.log(position.top);
                console.log(position.left);

                let sidebar = $(".sidebarMenuArea");

                sidebar.css("top",position.top);
                sidebar.css("left",position.left);
            }
            setSidebarPosition();

            // 사이드메뉴에 현재 페이지 표시하기
            function markCurrentPage()
            {
                let currentPage = $(".menuTitle > span").text();
                let sidemenu = $(".sidebarMenu > li > a");

                for (let i = 0; i < sidemenu.length; i++)
                {
                    let menu = sidemenu.eq(i);

                    if(menu.text() == currentPage)
                        menu.css("color","darkred");
                }
            }
            markCurrentPage();
        })
    </script>
</body>
</html>
