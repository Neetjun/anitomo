<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>배송지 관리</title>
    <link rel="stylesheet" href="/anitomo/resources/css/address.css">
</head>
<body>
    <div class="addressListArea">

        <c:forEach var="address" items="${addressList}">
            <div class="addressList">
                <div class="recipient">${address.recipient} ${address.defaultDeliveryAddress eq 'Y' ? '<i class="fa-solid fa-check"></i>' : ''}</div>
                <div class="address">${address.address}</div>
                <div class="recipientTel">${address.recipientTel}</div>
                <div class="deliveryMessage">배송메시지 : ${address.deliveryMessage}</div>
                <div class="addressBtn">
                    <div>
                        <button type="button" class="addressInfoChangeBtn" value="${address.addressCode}">변경</button>
                        <form action="" method="post" class="addressDeleteForm">
                            <button type="button" class="addressDeleteBtn" value="${address.addressCode}">삭제</button>
                        </form>
                    </div>
                    <c:if test="${sessionScope.get('loginUser') ne null && order eq 'true'}">
                        <button type="button" class="addressSelectBtn" value="${address.addressCode}">선택</button>
                    </c:if>
                </div>
            </div>
        </c:forEach>

        <div class="addressAddBtn">
            <button id="addressAddBtn">배송지 추가</button>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/0fa0e562e0.js" crossorigin="anonymous"></script>
    <script>
        $(document).ready(function () {

            $("#addressAddBtn").click(function () {
                window.location.href = "/anitomo/user/address?order=${order}&mode=new";
            });
            $(".addressInfoChangeBtn").click(function () {
                window.location.href = "/anitomo/user/address?order=${order}&mode=update&addressCode="+$(this).val();
            });
            $(".addressDeleteBtn").click(function () {

                if(confirm("배송지를 삭제하시겠습니까?"))
                {
                    let action = "/anitomo/user/address?order=${order}&mode=delete&addressCode="+$(this).val();
                    let form = $(this).parent(".addressDeleteForm");
                    form.attr("action",action);
                    form.submit();
                }
            });
            $(".addressSelectBtn").click(function () {
                $(opener.location).attr("href", "javascript:drawAddress('"+ $(this).val() +"');"); // 부모창 함수 호출
                window.close();    //현재 팝업창 Close
            })
        });
    </script>
</body>
</html>
