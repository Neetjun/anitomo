<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
  <link rel="stylesheet" href="/anitomo/resources/css/mypageOrderList.css">
</head>
<body>

<div class="menuTitle">
  <i class="fa-solid fa-bars"></i>
  <span>리뷰관리</span>
</div>

<div class="mypageContent">
  <c:choose>
    <c:when test="${orderList eq []}">
      <div class="noItem">
        <span>등록 및 확인 가능한 리뷰가 존재하지 않습니다.</span>
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
              <c:set var="reviewCount" value="${reviewCountMap[order.orderCode]}"></c:set>
              <div class="orderStatusText">
                <span class="orderCode">주문번호 : ${order.orderCode}</span>
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
                                <c:forEach var="thumbnail" items="${thumbnailList}">
                                  <c:if test="${thumbnail.code eq orderDetail.itemCode}">
                                    <img src='${thumbnail.url}' alt='' class='thumbnail'>
                                  </c:if>
                                </c:forEach>
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
                    <c:choose>
                      <c:when test="${reviewCount eq 0}">
                        <button type="button" value="${order.orderCode}" class="postReviewBtn">리뷰작성</button>
                      </c:when>
                      <c:otherwise>
                        <button type="button" value="${order.orderCode}" class="checkReviewBtn">리뷰확인</button>
                      </c:otherwise>
                    </c:choose>
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

<script>
  $(document).ready(function () {
    // 리뷰작성 및 확인
    $(".btnBox > button").click(function () {
      let requestType = $(this).text();
      let orderCode =$(this).val();

      if(requestType == "리뷰작성")
        window.location.href = "/anitomo/user/mypage/review?reviewOrderCode="+orderCode;
      else
        window.location.href = "/anitomo/user/review/" + orderCode;
    })
  })
</script>

</body>
</html>
