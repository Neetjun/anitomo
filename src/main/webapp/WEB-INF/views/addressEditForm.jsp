<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>배송지 관리</title>
    <link rel="stylesheet" href="/anitomo/resources/css/addressEditForm.css">
</head>
<body>
    <div class="addressEditForm">
        <div class="menuTitle">
            <span>${mode == 'new' ? '배송지 등록' : '배송지 변경'}</span>
        </div>
        <form action="/anitomo/user/address?mode=${mode}&order=${order}" method="post" id="addressForm">
            <table id="addressEditTable">
                <tr>
                    <th><i class="fa-solid fa-user"></i></th>
                    <td><input type="text" value="${address.recipient}" id="recipientNameInput" name="recipient" placeholder="받는분 성함"></td>
                </tr>
                <tr>
                    <th><i class="fa-solid fa-truck"></i></th>
                    <td id="addressTd">
                        <div id="addressInputArea"><input type="text" value="${address.addressArr[0]}" id="addressInput" name="addressArr" readonly></div>
                        <div id="addressDetailInputArea"><input type="text" value="${address.addressArr[1]}" id="addressDetailInput" name="addressArr" placeholder="상세주소"></div>
                        <div class="searchAddressArea">
                            <button id="searchAddress" type="button">주소찾기</button>
                            <label for="defaultCheck">기본 배송지 설정</label> <input type="checkbox" id="defaultCheck" ${address.defaultDeliveryAddress == 'Y' ? 'checked' : ''}>
                            <input type="text" id="defaultAddress" name="defaultDeliveryAddress" hidden="hidden" value="N">
                        </div>
                    </td>
                </tr>
                <tr>
                    <th><i class="fa-solid fa-mobile"></i></th>
                    <td>
                        <input type="tel" value="${address.recipientTelArr[0]}" name="recipientTelArr" placeholder="010">
                        - <input type="tel" value="${address.recipientTelArr[1]}" name="recipientTelArr" placeholder="1111">
                        - <input type="tel" value="${address.recipientTelArr[2]}" name="recipientTelArr" placeholder="2222">
                    </td>
                </tr>
                <tr>
                    <th><i class="fa-solid fa-message"></i></th>
                    <td><input type="text" value="${address.deliveryMessage}" id="deliveryMessageInput" name="deliveryMessage" placeholder="배송메세지 50자이내"></td>
                </tr>
            </table>
            <div class="addressEditBtn">
                <button id="submitBtn" type="button">${mode == 'new' ? '등록하기' : '변경하기'}</button>
                <button id="cancelBtn" type="button">취소하기</button>
            </div>
            <c:if test="${mode == 'update'}">
                <input type="text" name="addressCode" value="${address.addressCode}" hidden="hidden">
            </c:if>
        </form>
    </div>

    <script src="https://kit.fontawesome.com/0fa0e562e0.js" crossorigin="anonymous"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script>
        $(document).ready(function () {
            $("#searchAddress").click(function () {
                new daum.Postcode
                ({
                    oncomplete: function(data)
                    {
                        let roadAddress = data.roadAddress;
                        $("#addressInput").val(roadAddress);
                    }
                }).open();
            });

            $(".addressEditBtn > button").click(function () {
                if($(this).attr("id") == "cancelBtn")
                    window.location.href = "/anitomo/user/mypage/address?order=${order}";
                else
                {
                    if($("#defaultCheck").prop("checked"))
                        $("#defaultAddress").val("Y")
                    else
                        $("#defaultAddress").val("N")

                    $("#addressForm").submit();
                }
            })
        })
    </script>
</body>
</html>
