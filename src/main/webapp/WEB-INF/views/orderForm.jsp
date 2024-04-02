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
            <form action="/order?cartOrder=${cartOrder}" method="post" id="orderForm">
                <div class="buyerInfoArea">
                    <span class="infoType">구매자 정보</span>
                    <table id="buyerInfoTable">
                        <tr>
                            <th>이름</th>
                            <td>${userInfo.userName}</td>
                        </tr>
                        <tr>
                            <th>전화번호</th>
                            <td>${userInfo.userTel}</td>
                        </tr>
                    </table>
                </div>

                <div class="deliveryAddressInfoArea">
                    <input type="text" id="orderAddressCode" name="addressCode" hidden="hidden">
                    <span class="infoType">받는 사람 정보</span>
                    <button type="button" id="addressChangeBtn">배송지 변경</button>
                    <table id="deliveryAddressTable">
                        <tr>
                            <th>이름</th>
                            <td id="recipient">기본 배송지를 설정하거나 새로운 배송지를 선택해주세요.</td>
                        </tr>
                        <tr>
                            <th>배송주소</th>
                            <td id="address">기본 배송지를 설정하거나 새로운 배송지를 선택해주세요.</td>
                        </tr>
                        <tr>
                            <th>전화번호</th>
                            <td id="recipientTel">기본 배송지를 설정하거나 새로운 배송지를 선택해주세요.</td>
                        </tr>
                        <tr>
                            <th>배송메시지</th>
                            <td id="deliveryMessage">기본 배송지를 설정하거나 새로운 배송지를 선택해주세요.</td>
                        </tr>
                    </table>
                </div>

                <div class="itemBuyInfoArea">
                    <span class="infoType">구매상품</span>
                    <table id="itemBuyInfoTable">
                        <tr>
                            <th class="buyInfoTableTh">상품명</th>
                            <th id="buyQuantity" class="buyInfoTableTh">개수</th>
                            <th id="buyPrice" class="buyInfoTableTh">가격</th>
                        </tr>
                        <c:forEach var="orderInfo" items="${orderInfoList}">
                            <tr >
                                <td class="buyInfoTableTd">${orderInfo[0].itemName}</td>
                                <td class="buyInfoTableTd">${orderInfo[1]}</td>
                                <td id="priceText" class="buyInfoTableTd">${orderInfo[0].itemPrice * orderInfo[1]}</td>
                                <td class="itemPrice" hidden="hidden">${orderInfo[0].itemPrice * orderInfo[1]}</td>
                                <input type="text" value="${orderInfo[0].itemCode}" class="itemCodeArr" name="itemCodeArr" hidden="hidden">
                                <input type="text" value="${orderInfo[0].itemName}" class="itemNameArr" name="itemNameArr" hidden="hidden">
                                <input type="text" value="${orderInfo[0].itemPrice}" class="itemPriceArr" name="itemPriceArr" hidden="hidden">
                                <input type="text" value="${orderInfo[1]}" class="orderQuantityArr" name="orderQuantityArr" hidden="hidden">
                            </tr>
                        </c:forEach>
                    </table>
                </div>

                <div class="paymentInfoArea">
                    <span class="infoType">결제정보</span>
                    <table id="paymentInfoTable">
                        <tr>
                            <th>총상품가격</th>
                            <td id="itemTotalPrice"></td>
                        </tr>
                        <tr>
                            <th>할인가격</th>
                            <td id="discountAmount">0원</td>
                        </tr>
                        <tr>
                            <th>배송비</th>
                            <td id="deliveryPee">2,500원</td>
                        </tr>
                        <tr>
                            <th>총결제금액</th>
                            <td id="orderTotalPrice"></td>
                        </tr>
                        <tr>
                            <th>결제방법</th>
                            <td>
                                <input type="radio" id="accountTransfer" name="payment"> <label for="accountTransfer">계좌이체</label>
                                <input type="radio" id="creditCard" name="payment"> <label for="creditCard">신용/체크카드</label>
                                <input type="radio" id="simpleDeposit" name="payment"> <label for="simpleDeposit">무통장입금</label>
                                <div class="paymentMethodDetail">
                                    <div id="accountTransferDetail">
                                        <span>결제 계좌 선택</span>
                                        <select name="paymentOption">
                                            <option value="">계좌를 선택해주세요.</option>
                                            <option value="transfer">신한은행 | 110-383-******-44</option>
                                        </select>
                                    </div>
                                    <div id="creditCardDetail">
                                        <span>결제 카드 선택</span>
                                        <select name="paymentOption">
                                            <option value="">카드를 선택해주세요.</option>
                                            <option value="card">현대카드 | 1234-4321-****-12</option>
                                        </select>
                                    </div>
                                    <div id="simpleDepositDetail">
                                        카카오뱅크 3333-02-123456 | 예금주 : JYJ <span>(꼭 구매자 이름으로 입금해주세요)</span>
                                    </div>
                                    <input type="text" name="paymentMethod" hidden="hidden">
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
        // 배송지 호출 (팝업창에서 호출하기 위해 ready 함수 밖으로 빼냄. 스코프 문제인듯.)
        function drawAddress(addressCode)
        {
            $.ajax({
                url : "/order/address?addressCode="+addressCode
                , type : "GET"
                , success : function (address) {
                    if(address.adressCode == "")
                        return;
                    else
                    {
                        $("#recipient").text(address.recipient);
                        $("#address").text(address.address);
                        $("#recipientTel").text(address.recipientTel);
                        $("#deliveryMessage").text(address.deliveryMessage);
                        $("#orderAddressCode").val(address.addressCode);
                    }
                }
                , error : function (response) {
                    console.log(response.responseText)
                }
            })
        }

        $(document).ready(function () {
            // 가격 콤마 찍기
            function drawComma()
            {
                let itemTotalPrice = 0;

                let itemPrice = $(".itemPrice");

                for (let i = 0; i < itemPrice.length; i++)
                {
                    let price = parseInt(itemPrice.eq(i).text());
                    $(itemPrice.eq(i)).siblings("#priceText").text(price.toLocaleString()+"원");
                    itemTotalPrice += price;
                }

                let itemTotalPriceText = itemTotalPrice.toLocaleString();
                let orderTotalPriceText = (itemTotalPrice+2500).toLocaleString();

                $("#itemTotalPrice").text(itemTotalPriceText+"원");
                $("#orderTotalPrice").text(orderTotalPriceText+"원");
            }
            drawComma();

            drawAddress("");

            // 배송지 변경
            $("#addressChangeBtn").click(function () {
                let width = '750';
                let height = '600';

                // 팝업창 가운데로 위치시키기
                let left = Math.ceil(($(window).width() - width)/2);
                let top = Math.ceil(($(window).height() - height)/2);

                window.open('/user/mypage/address?order=true','', 'width=' + width + ',height=' + height + ',left=' + left + ',top=' + top);
            })

            // 결제방식 변경
            $("input[type='radio']").change(function () {
                $(".paymentMethodDetail > div").css("display","none");
                $("input[type='radio']").css("marginTop","25px");

                $("input[name='paymentMethod']").val("");
                for (let i = 0; i < $("select").length; i++)
                {
                    let selectBox = $("select").eq(i);
                    selectBox.val("");
                }

                let id = $(this).attr("id");

                if(id == "accountTransfer")
                    $("#accountTransferDetail").css("display","block");
                else if(id == "creditCard")
                    $("#creditCardDetail").css("display", "block");
                else
                {
                    $("#simpleDepositDetail").css("display", "block");
                    $("input[name='paymentMethod']").val("deposit");
                }

                $(".paymentMethodDetail").css("display","block");
            });

            // 결제수단 변경 사항 반영
            $("select[name='paymentOption']").change(function () {

                $("input[name='paymentMethod']").val($(this).val());
            })

            $(".orderBtnArea > button").click(function () {
                if($(this).attr("id") == "orderBtn")
                {
                    // 배송지를 선택했는가?
                    if($("#orderAddressCode").val() == "")
                    {
                        alert("배송지를 선택해 주세요!");
                        return;
                    }
                    // 결제수단을 선택했는가?
                    if($("input[name='paymentMethod']").val() == "")
                    {
                        alert("결제수단을 선택해 주세요!")
                        return;
                    }

                    $("#orderForm").submit();
                }

                else // 취소 버튼 클릭 시 이전 페이지로 돌아가기
                    window.location.href = document.referrer;
            });
        })
    </script>

</body>
</html>
