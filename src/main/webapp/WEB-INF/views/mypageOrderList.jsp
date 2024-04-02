<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <link rel="stylesheet" href="/resources/css/mypageOrderList.css">
</head>
<body>

    <div class="menuTitle">
        <i class="fa-solid fa-bars"></i>
        <span>주문내역</span>
    </div>

    <div class="mypageContent">
        <c:choose>
            <c:when test="${orderList eq []}">
                <div class="noItem">
                    <span>주문 내역이 존재하지 않습니다. 사주세요 ㅠㅠ..</span>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="orderDate" items="${orderDateList}">
                    <div class='orderList'>
                        <div class='orderDateText'>
                            <span class="orderDate">
                                ${orderDate}
                            </span>
                        </div>
                        <c:forEach var="order" items="${orderList}">
                            <c:if test="${order.orderDate eq orderDate}">
                                <c:set var="orderDetailList" value="${orderDetailMap[order.orderCode]}"></c:set>
                                <div class="orderStatusText">
                                    <span class="orderCode">주문번호 : ${order.orderCode}</span>
                                    <span class="orderStatus">${order.orderStatus}</span>
                                </div>
                                <div class="orderListItem">
                                    <div class="orderItemArea">
                                        <c:forEach var="orderDetail" items="${orderDetailList}">
                                            <div class="orderItem">
                                                <div class="orderInfo">
                                                    <div class='itemInfoArea'>
                                                        <div class='itemInfo'>
                                                            <div class='thumbnailArea'>
                                                                <div class='thumbnailBox'>
                                                                    <img src='/resources/img/tmpItemImage.jpg' alt='' class='thumbnail'>
                                                                </div>
                                                            </div>
                                                            <div class='itemNameAndPrice'>
                                                                <div class='itemName'> ${orderDetail.itemName}</div>
                                                                <div class='itemPrice'> ${orderDetail.itemPrice}원</div>
                                                                <div class='orderQuantity'> 수량 ${orderDetail.orderQuantity}개</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <div class="orderListBtnArea">
                                        <div class="btnBox">
                                            <button type="button" value="${order.orderCode}" class="orderDetailBtn">주문상세</button>
                                            <c:choose>
                                                <c:when test="${order.orderStatusCode eq 'OS1' || order.orderStatusCode eq 'OS2'}">
                                                    <button type="button" value="${order.orderCode}" class="cancelOrderBtn">주문취소</button>
                                                </c:when>
                                                <c:when test="${order.orderStatusCode eq 'OS3' || order.orderStatusCode eq 'OS6'}">
                                                    <button type="button" value="${order.orderCode}" class="cancelOrderBtn">교환/환불</button>
                                                </c:when>
                                                <c:otherwise></c:otherwise>
                                            </c:choose>
                                            <button type="button" value="${order.orderCode}" class="deleteOrderListBtn">삭제하기</button>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
    <form action="" method="post" id="orderListForm">
        <input type="text" value="${order.orderCode}" id="orderCodeInput" name="orderCode" hidden="hidden">
    </form>

    <script>
        $(document).ready(function () {
            // 주문상세, 주문 취소, 주문내역 삭제
            $(".btnBox > button").click(function () {
                let requestType = $(this).text();
                let orderCode =$(this).val();

                console.log(orderCode);

                $("#orderListForm").attr("method","post");

                if(requestType == "삭제하기")
                    $("#orderListForm").attr("action","/user/orderlist?mode=delete");
                else if(requestType == "주문취소")
                    $("#orderListForm").attr("action","/user/orderlist?mode=cancel");
                else if(requestType == "교환/환불")
                    $("#orderListForm").attr("action","/user/orderlist?mode=refund");
                else
                {
                    $("#orderListForm").attr("method","get");
                    $("#orderListForm").attr("action","/user/mypage/orderdetail");
                }

                $("#orderCodeInput").val(orderCode);

                $("#orderListForm").submit();
            })
        })
    </script>

</body>
</html>
