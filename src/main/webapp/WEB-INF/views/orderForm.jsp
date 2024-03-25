<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>주문/결제</title>
    <link rel="stylesheet" href="/resources/css/order.css">
</head>
<body>

<c:import url="header.jsp"></c:import>

    <div class="orderFormArea wrapper">
        <div class="menuTitle">
            <i class="fa-solid fa-credit-card"></i>
            <span>주문/결제</span>
        </div>
        <div class="orderForm">
            <form action="/order" method="post">
                <div class="buyerInfoArea">
                    <span class="infoType">구매자 정보</span>
                    <table id="buyerInfoTable">
                        <tr>
                            <th>이름</th>
                            <td>비밀이다</td>
                        </tr>
                        <tr>
                            <th>전화번호</th>
                            <td>010-1111-2222</td>
                        </tr>
                    </table>
                </div>

                <div class="deliveryAddressInfoArea">
                    <span class="infoType">받는 사람 정보</span>
                    <button type="button" id="addressChangeBtn">배송지 변경</button>
                    <table id="deliveryAddressTable">
                        <tr>
                            <th>이름</th>
                            <td>비밀이다</td>
                        </tr>
                        <tr>
                            <th>배송주소</th>
                            <td>별나라</td>
                        </tr>
                        <tr>
                            <th>전화번호</th>
                            <td>010-3333-4444</td>
                        </tr>
                        <tr>
                            <th>배송메시지</th>
                            <td>안전하게 배송좀 ㅠㅠ</td>
                        </tr>
                    </table>
                </div>

                <div class="itemBuyInfoArea">
                    <span class="infoType">구매상품</span>
                    <table id="itemBuyInfoTable">
                        <tr>
                            <th class="buyInfoTableTh">상품명</th>
                            <th id="buyQuantity" class="buyInfoTableTh">개수</th>
                        </tr>
                        <tr >
                            <td class="buyInfoTableTd">귀여운 피규어</td>
                            <td class="buyInfoTableTd">2</td>
                        </tr>
                        <tr>
                            <td class="buyInfoTableTd">섹시한 피규어</td>
                            <td class="buyInfoTableTd">1</td>
                        </tr>
                    </table>
                </div>

                <div class="paymentInfoArea">
                    <span class="infoType">결제정보</span>
                    <table id="paymentInfoTable">
                        <tr>
                            <th>총상품가격</th>
                            <td>20,000원</td>
                        </tr>
                        <tr>
                            <th>할인가격</th>
                            <td>0원</td>
                        </tr>
                        <tr>
                            <th>배송비</th>
                            <td>2,500원</td>
                        </tr>
                        <tr>
                            <th>총결제금액</th>
                            <td>22,500원</td>
                        </tr>
                        <tr>
                            <th>결제방법</th>
                            <td>
                                <input type="radio" id="accountTransfer" name="paymentMethod"> <label for="accountTransfer">계좌이체</label>
                                <input type="radio" id="creditCard" name="paymentMethod"> <label for="creditCard">신용/체크카드</label>
                                <input type="radio" id="simpleDeposit" name="paymentMethod"> <label for="simpleDeposit">무통장입금</label>
                                <div class="paymentMethodDetail">
                                    <div id="accountTransferDetail">
                                        <span>결제 계좌 선택</span>
                                        <select name="accountNumber">
                                            <option value="1">신한은행 | 110-383-******-44</option>
                                        </select>
                                    </div>
                                    <div id="creditCardDetail">
                                        <span>결제 카드 선택</span>
                                        <select name="creditCardNumber">
                                            <option value="1">현대카드 | 1234-4321-****-12</option>
                                        </select>
                                    </div>
                                    <div id="simpleDepositDetail">
                                        카카오뱅크 3333-02-123456 | 예금주 : JYJ <span>(꼭 구매자 이름으로 입금해주세요)</span>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="orderBtnArea">
                    <button id="orderBtn" type="button">결제하기</button>
                    <button id="orderCancelBtn" type="button">취소하기</button>
                </div>
            </form>
        </div>
    </div>

    <c:import url="footer.jsp"></c:import>

    <script>
        $(document).ready(function () {
            $("input[type='radio']").change(function () {
                $(".paymentMethodDetail > div").css("display","none");
                $("input[type='radio']").css("marginTop","25px");

                let id = $(this).attr("id");

                if(id == "accountTransfer")
                    $("#accountTransferDetail").css("display","block");
                else if(id == "creditCard")
                    $("#creditCardDetail").css("display","block");
                else
                    $("#simpleDepositDetail").css("display","block");

                $(".paymentMethodDetail").css("display","block");
            });

            $(".orderBtnArea > button").click(function () {
                if($(this).attr("id") == "orderBtn")
                    window.location.href = "/order/result";
                else
                    window.location.href = "/";
            });
        })
    </script>

</body>
</html>
