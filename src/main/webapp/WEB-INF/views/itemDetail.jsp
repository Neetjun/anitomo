<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상품상세</title>
    <link rel="stylesheet" href="/anitomo/resources/css/itemDetail.css">
    <link rel="stylesheet" href="/anitomo/resources/css/toastr.min.css"> <%-- 토스트 메시지 라이브러리 --%>
    <link rel="icon" href="/anitomo/resources/favicon.ico">
</head>
<body>
    <c:import url="header.jsp"></c:import>
    <div class="itemDetailArea wrapper">
        <div class="itemSummaryArea">
            <div class="itemImage">
                <img src="${thumbnailUrl}" alt="">
            </div>
            <div class="itemSummary">
                <div class="itemName">
                    ${item.itemName}
                </div>
                <div class="itemPrice">
                    ${item.itemPrice}원
                </div>
                <div class="itemInfoArea">
                    <div class="itemInfo">
                        <div class="itemSeries">
                            <div class="infoType">
                                작품
                            </div>
                            <div class="infoContent">
                                ${item.seriesName}
                            </div>
                        </div>
                        <div class="itemMaker">
                            <div class="infoType">
                                제조사
                            </div>
                            <div class="infoContent">
                                ${item.makerName}
                            </div>
                        </div>
                        <div class="itemSize">
                            <div class="infoType">
                                크기
                            </div>
                            <div class="infoContent">
                                ${item.itemSize}cm
                            </div>
                        </div>
                        <div class="orderQuantity">
                            <div class="infoType">
                                수량
                            </div>
                            <div class="infoContent">
                                <div id="orderQuantityInput">
                                    <button type="button" id="quantityMinus">-</button>
                                    <input type="text" id="currentQuantity" value="1">
                                    <button type="button" id="quantityPlus">+</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="priceAndOrderArea">
                    <div class="totalPriceArea">
                        <span id="totalPriceText">총구매금액</span>
                        <span id="totalPrice">${item.itemPrice}</span>원
                        <form action="/anitomo/order" method="get" id="orderForm" hidden="hidden">
                            <input type="text" id="orderQuantity" name="itemQuantityList">
                            <input type="text" value="${item.itemCode}" name="itemCodeList">
                        </form>
                    </div>
                    <button type="button" id="orderBtn">바로구매</button>
                    <button type="button" id="cartBtn">장바구니</button>
                </div>
            </div>
        </div>

        <div class="itemDetailNav" id="detailNav">
            <a href="#detailNav" class="scrollNav"><span>상품상세</span></a>
            <a href="#reviewNav" class="scrollNav"><span>리뷰(${reviewCount})</span></a>
            <a href="#inquiryNav" class="scrollNav"><span class="inquiryCount"></span></a>
        </div>

        <div class="itemDetailContentArea">
            <p>${item.itemDescription}</p>
        </div>

        <div class="itemDetailNav" id="reviewNav">
            <a href="#detailNav" class="scrollNav"><span>상품상세</span></a>
            <a href="#reviewNav" class="scrollNav"><span>리뷰(${reviewCount})</span></a>
            <a href="#inquiryNav" class="scrollNav"><span class="inquiryCount"></span></a>
        </div>

        <div class="reviewArea">
            <span id="reviewGuide">리뷰 등록은 마이페이지의 리뷰관리에서 가능합니다!</span>
            <div class="reviewListArea">
                <table id="reviewTable">
                    <tr class="tableHead reviewHead">
                        <th>번호</th>
                        <th>제목</th>
                        <th>별점</th>
                        <th>작성자</th>
                        <th>작성일</th>
                    </tr>
                    <c:forEach var="review" items="${reviewList}">
                        <c:set var="imageList" value="${imageMap[review.reviewCode]}"></c:set>
                        <tr class="reviewTitle">
                            <td>${review.reviewCode}</td>
                            <td>${review.reviewTitle}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${review.itemRate eq null}">
                                        평가안함
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach begin="1" end="${review.itemRate}">
                                            ★
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${review.userName}</td>
                            <td>${review.reviewDate}</td>
                        </tr>
                        <tr class='reviewContent' hidden='hidden'>
                            <td colspan='5'>
                                <div class='inquiryContentArea'>
                                    <div class='inquiryContent'>${review.reviewContent}</div>
                                    <div class="reviewImageArea">
                                        <c:forEach var="imageUrl" items="${imageList}">
                                            <div class="reviewImageList">
                                                <div class="reviewImage">
                                                    <img src="${imageUrl}" alt="" class="reviewImg">
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>

        <div class="itemDetailNav" id="inquiryNav">
            <a href="#detailNav" class="scrollNav"><span>상품상세</span></a>
            <a href="#reviewNav" class="scrollNav"><span>리뷰(${reviewCount})</span></a>
            <a href="#inquiryNav" class="scrollNav"><span class="inquiryCount"></span></a>
        </div>

        <div class="inquiryArea">
            <div class="inquiryListArea">
                <button id="inquiryBtn" ${sessionScope.get("loginUser").userCode eq null ? 'disabled title="로그인해주세요."' : ''}>문의등록</button>
                <table id="inquiryTable">
                    <tr class="tableHead inquiryHead">
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>상태</th>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <%-- 상품 문의등록 modal 영역 --%>
    <div class="modalArea">
        <div class="modal">
            <div class="modal-title">
                <span>상품문의</span>
                <button id="modalCloseBtn">X</button>
            </div>
            <form action="/anitomo/inquiry" id="inquiryForm" method="post">
                <div class="modal-content">
                    <input type="text" id="itemCode" value="${item.itemCode}" name="inquiryItemCode" hidden="hidden">
                    <div class="inquiryTitleInputArea">
                        <span>문의제목</span>
                        <input type="text" id="inquiryTitleInput" name="inquiryTitle">
                    </div>
                    <div class="inquiryContentInputArea">
                        <span>문의내용</span>
                        <textarea id="inquiryContentInput"></textarea>
                        <input type="text" name="inquiryContent" hidden="hidden">
                    </div>
                </div>
                <div class="modal-btnArea">
                    <button id="inquirySubmitBtn" type="button">등록하기</button>
                    <button id="inquiryCancelBtn" type="button">취소</button>
                </div>
            </form>
        </div>
    </div>

    <%--정보성 hidden input 영역--%>
    <input type="text" id="itemPrice" value="${item.itemPrice}" hidden="hidden">

    <c:import url="footer.jsp"></c:import>

    <%--스크립트 영역--%>
    <script src="/anitomo/resources/js/toastr.min.js"></script> <%-- 토스트메시지 라이브러리 --%>
    <script>
        $(document).ready(function () {
            // 각 영역 네비게이션 제목에 색 칠해주기
            function navColor() 
            {
                for (let i = 0; i < $(".itemDetailNav").length; i++)
                {
                    let nav = $(".itemDetailNav").eq(i);
                    let target = nav.children("a").eq(i);
                    target.css("color", "orange");
                }
            }
            navColor();

            // 페이지 초기 가격에 콤마 찍어주기
            function drawComma()
            {
                let price = parseInt($("#itemPrice").val());
                let priceText = price.toLocaleString();

                $(".itemPrice").text(priceText+"원");
                $("#totalPrice").text(priceText);
            }
            drawComma();

            // 변동된 주문 가격에 콤마 찍어주기
            function drawNewComma(quantity)
            {
                quantity = parseInt(quantity);
                let newOrderPrice = parseInt($("#itemPrice").val()) * quantity;

                let priceText = newOrderPrice.toLocaleString();

                $("#totalPrice").text(priceText);
            }


            // 네비게이션 클릭 시 해당 영역으로 이동
            $(".scrollNav").click(function (event) {
                event.preventDefault();
                $("html,body").animate({scrollTop:$(this.hash).offset().top},300);
            });

            // 주문수량 변경
            $("#orderQuantityInput > button").click(function () {
                let currentQuantity = $("#currentQuantity");

                if($(this).attr("id") == "quantityPlus")
                    currentQuantity.val(parseInt(currentQuantity.val())+1);
                else
                {
                    if(parseInt(currentQuantity.val()) > 1)
                        currentQuantity.val(parseInt(currentQuantity.val())-1);
                    else
                        currentQuantity.val(1);
                }
                drawNewComma(currentQuantity.val());

            });

            // 수량 직접입력 시 잘못된 값 입력 방지
            $("#currentQuantity").change(function () {
                let regex = /^[0-9]*$/;

                if(!regex.test($(this).val()) || $(this).val() < 1)
                {
                    alert("입력값이 올바르지 않습니다!");
                    $(this).val(1);
                }

                drawNewComma($(this).val());

            });

            // 바로구매 버튼
            $("#orderBtn").click(function () {
                $("#orderQuantity").val($("#currentQuantity").val());
                $("#orderForm").submit();
            })

            // 장바구니 메시지
            function cartMessage(resultMessage)
            {
                // 토스트 메시지 속성값 정의
                toastr.options =
                    {
                        "positionClass" : "toast-bottom-center"
                        , "timeOut" : "1500"
                    }

                if(resultMessage == "success")
                    toastr.success("","장바구니 추가 완료!");
                else if(resultMessage == "duplication")
                    toastr.info("","이미 장바구니에 추가된 물품입니다.");
                else if(resultMessage == "loginRequired")
                    toastr.error("", "로그인이 필요합니다.");
                else
                    toastr.error("","장바구니 추가에 실패했습니다.\n다시 시도해주세요.");
            }
            // 장바구니 담기
            $("#cartBtn").click(function () {
                let cartData =
                    {
                        "userCode" : "${sessionScope.get("loginUser").userCode}"
                        , "userId" : "${sessionScope.get("loginUser").userId}"
                        , "itemCode" : "${item.itemCode}"
                        , "itemName" : "${item.itemName}"
                        , "itemPrice" : "${item.itemPrice}"
                        , "cartQuantity" : $("#currentQuantity").val()
                    }

                //장바구니 추가 ajax
                $.ajax({
                    type : "POST"
                    , url : "/anitomo/cart"
                    , contentType : "application/json"
                    // , dataType :  "json"
                    , data : JSON.stringify(cartData)
                    , success : function (resultMessage) {
                        cartMessage(resultMessage);
                    }
                    , error : function (response) { console.log(response.responseText) }
                });
            })

            // 리뷰 상세내용 노출
            $(document).on("click", ".reviewTitle", function () {
                if($(this).next(".reviewContent").attr("hidden") == "hidden")
                    $(this).next(".reviewContent").removeAttr("hidden");
                else
                    $(this).next(".reviewContent").attr("hidden","hidden");
            });

            // 리뷰 이미지 클릭 시 새탭 열기
            $('.reviewImg').click(function(){
                let imageUrl = $(this).attr('src');
                window.open(imageUrl, '_blank');
            });

            // 문의하기 목록 가져오기
            function showInquiryList() {
                $.ajax({
                    type: "POST"
                    , url: "/anitomo/inquiry/list"
                    , contentType : "text/plain"
                    , data : $("#itemCode").val()
                    , success: function (inquiryMap) {
                        let inquiryArr = inquiryMap.inquiryList;
                        let inquiryCount = inquiryMap.inquiryCount;

                        for(let i = 0; i < $(".inquiryCount").length; i++)
                        {
                            let inquiryCountText = "문의("+ inquiryCount +")";
                            $(".inquiryCount").eq(i).text(inquiryCountText);
                        }

                        let inquiryListHtml = "";

                        for (let i = 0; i < inquiryArr.length; i++)
                        {
                            let inquiry = inquiryArr[i];

                            inquiryListHtml
                                += "<tr class='inquiryInfo'>"
                                    + "<td>" + inquiry.inquiryCode + "</td>"
                                    + "<td>" + inquiry.inquiryTitle + "</td>"
                                    + "<td>" + inquiry.inquiryUserName + "</td>"
                                    + "<td>" + inquiry.inquiryDate + "</td>"
                                    + "<td>" + inquiry.inquiryStatus + "</td>"
                                + "</tr>"
                                + "<tr class='inquiryDetail' hidden='hidden'>"
                                    + "<td colspan='5'>"
                                        + "<div class='inquiryContentArea'>"
                                        + "<div class='inquiryDetailTitle'>질문내용</div>"
                                        + "<div class='inquiryContent'>" + inquiry.inquiryContent + "</div>"
                                        + "<div class='inquiryDetailTitle'>답변내용</div>"
                                        + "<div class='inquiryAnswer'>" + inquiry.inquiryAnswer + "</div>"
                                        + "</div>"
                                    + "</td>"
                                +"</tr>";
                        }
                        $(".inquiryHead").after(inquiryListHtml);
                    }
                    , error: function (response) {
                        console.log(response.responseText);
                    }
                })
            }
            showInquiryList();

            // 문의하기 상세내용 노출
            $(document).on("click", ".inquiryInfo", function () {
                if($(this).next(".inquiryDetail").attr("hidden") == "hidden")
                    $(this).next(".inquiryDetail").removeAttr("hidden");
                else
                    $(this).next(".inquiryDetail").attr("hidden","hidden");
            })

            // 문의하기 폼 노출
            $("#inquiryBtn").click(function () {
                $(".modalArea").fadeIn();
            });

            // 문의하기 창 닫기
            $(".modal-title > button").click(function () {
                $("#inquiryCancelBtn").click();
            });

            $("#inquiryCancelBtn").click(function () {
                $("#inquiryTitleInput").val("");
                $("#inquiryContentInput").val("");
                $(".modalArea").fadeOut();
            });

            // 모달 회색영역 클릭 시 창 닫기
            $(".modalArea").click(function (e) {
                // 이벤트 발생 주체(target)가 매개변수로 오는 선택자와 일치한다면
                if($(e.target).is($(".modalArea"))) // is(선택자) = 제이쿼리 셀렉터 비교함수
                    $("#inquiryCancelBtn").click();
                else
                    return;
            });

            // 문의등록하기
            $("#inquirySubmitBtn").click(function () {
                if($("#inquiryTitleInput").val().replaceAll(" ", "") == "" || $("#inquiryContentInput").val().replaceAll(" ", "") == "")
                {
                    alert("제목과 내용을 모두 입력해주세요!");
                    return;
                }
                else
                {
                    //enter => <br>
                    let content = $('textarea').val();
                    content = content.replace(/(?:\r\n|\r|\n)/g, '<br>');

                    $("input[name='inquiryContent']").val(content);
                    $("#inquiryForm").submit();
                }
            });
        })
    </script>
</body>
</html>
