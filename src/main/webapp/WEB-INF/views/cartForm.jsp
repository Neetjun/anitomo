<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <title>장바구니</title>
    <link rel="icon" href="/anitomo/resources/favicon.ico">
    <link rel="stylesheet" href="/anitomo/resources/css/cart.css">
</head>
<body>
    <c:import url="header.jsp" charEncoding="utf-8"></c:import>

    <div class="cartArea wrapper">
            <div class="menuTitle">
                <i class="fa-solid fa-cart-shopping"></i>
                <span>장바구니</span>
            </div>
            <div class="cartListArea">
                <form action="/anitomo/order" method="get" id="cartForm">
                    <input type="text" name="cartOrder" value="true" hidden="hidden">
                    <div class="cartBtnArea">
                        <div class="checkAllBoxArea">
                            <input type="checkbox" id="checkAll">
                            <label for="checkAll">전체선택</label>
                        </div>
                        <button type="button" id="checkDeleteBtn">선택삭제</button>
                    </div>

                    <div class="cartTotalPriceArea">
                        <span>총 구매금액</span>
                        <span id="cartTotalPrice">0</span>원
                        <button type="button" id="cartOrderBtn">구매하기</button>
                    </div>
                </form>
            </div>
    </div>

    <c:import url="footer.jsp"></c:import>

    <script>
        $(document).ready(function () {
            // 카트 목록 불러오기
            function showCartList()
            {
                $.ajax({
                    type : "GET"
                    , url : "/anitomo/cart/list"
                    , success : function (cartMap) {

                        $(".itemInCart").remove();

                        let cartList = cartMap.cartList;
                        let thumbnailList = cartMap.thumbnailList;

                        let cartListHtml = "";
                        let orderPrice = 0;

                        if(cartList.length == 0)
                        {
                            cartListHtml
                                += "<div class='noItem'>"
                                    +"<span id='noItemMessage'>장바구니가 비어있습니다!</span>"
                                + "</div>"

                            $(".cartBtnArea").css("display","none");
                            $(".cartTotalPriceArea").css("display","none");
                        }
                        else
                        {
                            for (let i = 0; i < cartList.length; i++)
                            {
                                let item = cartList[i];
                                let itemPrice = parseInt(item.itemPrice);

                                orderPrice = itemPrice * item.cartQuantity;

                                cartListHtml
                                += "<div class='itemInCart'>"
                                    +"<div class='deleteBtnArea'>"
                                        +"<button type='button' class='deleteFromCart' value='" + item.itemCode + "'>X</button>"
                                    +"</div>"
                                    +"<div class='itemInfoArea'>"
                                        +"<div class='itemInfo'>"
                                            +"<div class='thumbnailArea'>"
                                                +"<input type='checkbox' class='checkItem' name='checkItem'>"
                                                +"<input type='text' class='itemPrice' value='" + item.itemPrice + "' hidden='hidden' disabled='disabled'>"
                                                +"<input type='text' class='orderItemQuantity' value='" + item.cartQuantity + "' name='itemQuantityList' hidden='hidden' disabled='disabled'>"
                                                +"<input type='text' class='orderItemCode' value='"+ item.itemCode +"' name='itemCodeList' hidden='hidden' disabled='disabled'>"
                                                    +"<div class='thumbnailBox'>";
                                                        for (let i = 0; i < thumbnailList.length; i++)
                                                        {
                                                            let thumbnail = thumbnailList[i];
                                                            if(thumbnail.code == item.itemCode)
                                                            {
                                                                cartListHtml+="<img src='" + thumbnail.url + "' alt='' class='thumbnail'>";
                                                                break;
                                                            }
                                                        }
                                            cartListHtml+="</div>"
                                            +"</div>"
                                            +"<div class='itemNameAndPrice'>"
                                                +"<div class='itemName'>" + item.itemName  + "</div>"
                                                +"<div class='itemPrice'>" + itemPrice.toLocaleString() + "원</div>"
                                                +"<div class='orderQuantity'>"
                                                    +"<div class='orderQuantityInputArea'>"
                                                        +"<span>수량</span>"
                                                        +"<button type='button' class='quantityMinus'>-</button>"
                                                        +"<input type='text' class='currentQuantity' value='" + item.cartQuantity + "'>"
                                                        +"<input type='text' class='itemCode' value='"+ item.itemCode +"' hidden='hidden'>"
                                                        +"<button type='button' class='quantityPlus'>+</button>"
                                                    +"</div>"
                                                +"</div>"
                                            +"</div>"
                                            +"<div class='totalPriceArea'>"
                                                +"<span class='totalPriceText'>구매금액</span>"
                                                +"<span class='totalPrice'>" + orderPrice.toLocaleString() + "</span>원"
                                            +"</div>"
                                        +"</div>"
                                    +"</div>"
                                +"</div>";
                            }
                        }

                        $("#cartForm").prepend(cartListHtml);
                    }
                    , error : function (response) { console.log(response.responseText) }
                });
            }
            showCartList();

            // 장바구니 정보 업데이트
            function updateCartInfo(newQuantity, itemCode)
            {
                let newOrderData =  {"cartQuantity" : newQuantity, "itemCode" : itemCode}

                $.ajax({
                    type: "POST"
                    , url: "/anitomo/cart/update"
                    , contentType: "application/json"
                    , data : JSON.stringify(newOrderData)
                    , success : function () {
                        showCartList();
                        $("#cartTotalPrice").text("0");
                    }
                    , error : function (response) { console.log(response.responseText) }
                })
            }

            // 전체 체크박스 체크 이벤트
            $("#checkAll").click(function () {
                let checkFlag = $(this).prop("checked");
                let itemCodeList = $(".orderItemCode");
                let itemQuantityList = $(".orderItemQuantity");

                if(checkFlag)
                {
                    itemCodeList.removeAttr("disabled");
                    itemQuantityList.removeAttr("disabled");
                    $(".checkItem").prop("checked","true");
                }
                else if(!checkFlag)
                {
                    itemCodeList.attr("disabled","disabled");
                    itemQuantityList.attr("disabled","disabled");
                    $(".checkItem").prop("checked", "");
                }

                calculateTotalPrice();
            });

            // 체크박스 일부 해제 시 전체 체크박스 체크 해제
            $(document).on("click", ".checkItem", function () {
                let checkboxArray = $(".checkItem");

                calculateTotalPrice();

                if($(this).prop("checked"))
                {
                    // 체크 시 주문 대상에 다시 포함
                    $(this).siblings(".orderItemCode").removeAttr("disabled");
                    $(this).siblings(".orderItemQuantity").removeAttr("disabled");
                }
                else
                {
                    // 체크 해제 시 주문 대상에서 제외
                    $(this).siblings(".orderItemCode").attr("disabled","disabled");
                    $(this).siblings(".orderItemQuantity").attr("disabled","disabled");
                }

                for (let i = 0; i < checkboxArray.length; i++)
                {
                    let checkbox = checkboxArray.eq(i);

                    if(!checkbox.prop("checked"))
                    {
                        $("#checkAll").prop("checked","");
                        return;
                    }
                }

                // 모두가 체크 상태면 (수동으로 사용자가 전부 체크를 했다면) 전체 선택도 체크
                $("#checkAll").prop("checked","true");
            });

            $(document).on("change",".checkItem",function () {
                console.log($(this).siblings(".itemCode").val());
            })

            // 총 주문 가격 계산
            function calculateTotalPrice()
            {
                let checkboxArray = $(".checkItem");
                let totalPrice = 0;

                for (let i = 0; i < checkboxArray.length; i++)
                {
                    let checkbox = checkboxArray.eq(i);

                    if(checkbox.prop("checked"))
                        totalPrice += checkbox.siblings(".itemPrice").val() * checkbox.siblings(".orderItemQuantity").val();
                }
                $("#cartTotalPrice").text(totalPrice.toLocaleString());
            }

            // 장바구니 삭제 기능
            function deleteCart(mode, data)
            {
                if(mode == "btn")
                {
                    $.ajax({
                        type: "POST"
                        , url: "/anitomo/cart/delete"
                        , contentType: "application/json"
                        , data: JSON.stringify(data)
                        , success: function () {
                            showCartList();
                            $("#cartTotalPrice").text("0");
                        }
                        , error: function (response) {
                            console.log(response.responseText)
                        }
                    });
                }
                else if(mode == "checkbox")
                {
                    $.ajax({
                        type: "POST"
                        , url: "/anitomo/cart/delete"
                        , contentType: "application/json"
                        , data: JSON.stringify(data)
                        , success: function () {
                        }
                        , error: function (response) {
                            console.log(response.responseText)
                        }
                    });
                }
            }

            // 장바구니 삭제 (개별삭제 버튼)
            $(document).on("click",".deleteFromCart", function () {

                let data = {"itemCode" : $(this).val()};

                if(confirm("장바구니에서 삭제하시겠습니까?"))
                    deleteCart("btn", data);
            });

            // 장바구니 삭제 (선택삭제 버튼)
            $("#checkDeleteBtn").click(function () {

                if(confirm("장바구니에서 삭제하시겠습니까?"))
                {
                    let deleteItemArray = $(".checkItem");

                    for (let i = 0; i < deleteItemArray.length; i++)
                    {
                        let deleteItem = deleteItemArray.eq(i);

                        if(deleteItem.prop("checked"))
                        {
                            let data = {"itemCode" : deleteItem.siblings(".orderItemCode").val()};
                            deleteCart("checkbox",data);
                        }
                    }

                    setTimeout(showCartList,500);
                    $("#cartTotalPrice").text("0");
                }
            })

            // 주문수량 변경
            $(document).on("click", ".orderQuantityInputArea > button", function () {
                let currentQuantity = $(this).siblings(".currentQuantity");

                if($(this).attr("class") == "quantityPlus")
                {
                    currentQuantity.val(parseInt(currentQuantity.val())+1);
                }
                else
                {
                    if(parseInt(currentQuantity.val()) > 1)
                        currentQuantity.val(parseInt(currentQuantity.val())-1);
                    else
                        currentQuantity.val(1);
                }

                updateCartInfo(currentQuantity.val(), $(this).siblings(".itemCode").val())
            });

            // 수량 직접입력 시 잘못된 값 입력 방지
            $(document).on("change", ".currentQuantity", function () {
                let regex = /^[0-9]*$/;

                if(!regex.test($(this).val()) || $(this).val() < 1)
                {
                    alert("입력값이 올바르지 않습니다!");
                    $(this).val(1);
                }

                updateCartInfo($(this).val(), $(this).siblings(".itemCode").val())
            });

            // 주문하기
            $("#cartOrderBtn").click(function () {
                let orderItemList = $(".checkItem");
                let flag = 0;

                for (let i = 0; i < orderItemList.length; i++)
                {
                    let item = orderItemList.eq(i);

                    if(item.prop("checked"))
                        flag++;
                }

                if(flag == 0)
                {
                    alert("최소 한 개의 상품을 선택해 주세요.");
                    return;
                }

                $("#cartForm").submit();
            });
        })
    </script>

</body>
</html>
