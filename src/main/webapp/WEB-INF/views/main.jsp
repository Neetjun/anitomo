<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Anitomo!</title>
    <link rel="stylesheet" href="/anitomo/resources/css/main.css">
    <link rel="icon" href="/anitomo/resources/favicon.ico">
</head>
<body>
    <%-- 헤더영역 --%>
    <c:import url="header.jsp" charEncoding="utf-8"></c:import>

    <%-- 메인 페이지 영역 --%>
    <div class="mainArea wrapper">

        <%-- 배너 영역 --%>
        <div class="bannerArea">
            <div class="bannerImgBox">
                <div id="bannerImgArea">
                    <a href="#">
                        <img class="bannerImg" src="/anitomo/resources/img/b1.png" alt="">
                    </a>
                    <a href="#">
                        <img class="bannerImg" src="/anitomo/resources/img/b2.png" alt="">
                    </a>
                    <a href="#">
                        <img class="bannerImg" src="/anitomo/resources/img/b3.png" alt="">
                    </a>
                </div>
            </div>
            <div class="bannerBtnArea">
                <i class="fa-solid fa-chevron-left bannerBtn" id="bannerLeft"></i>
                <ul id="bannerIndexList">
                    <li><button style="background-color: darkred"></button></li>
                    <li><button></button></li>
                    <li><button></button></li>
                </ul>
                <i class="fa-solid fa-chevron-right bannerBtn" id="bannerRight"></i>
            </div>
        </div>

        <%-- 상품 목록 영역 --%>
        <div class="mainItemArea">
            <div class="popularItemList">
                <div class="listTitle">인기 상품</div>
                <div class="listTitleLine"></div>
                <div class="itemList">
                </div>
            </div>

            <div class="newItemList">
                <div class="listTitle">신규 상품</div>
                <div class="listTitleLine"></div>
                <div class="itemList">
                </div>
            </div>
        </div>
    </div>

    <c:import url="footer.jsp"></c:import>

    <%-- 스크립트 영역 --%>
    <script>
        let bannerIndex = 0; // 배너 최초 위치
        let bannerLength = 3; // 배너 갯수
        let bannerWidth = 1600; // 배너 노출 영역 넓이
        let interval = setInterval(function () {$("#bannerRight").click()}, 3000); // 배너 자동넘기기 인터벌
        let bannerMargin = parseInt($(".bannerImgBox").css("marginLeft"))-800;
        $(".bannerImgBox").css("marginLeft",bannerMargin);
        console.log(bannerMargin);
        $(document).ready(function () {
            // 배너 좌우 버튼 클릭 시 배너 넘기기
            $(".bannerBtn").click(function () {
                let newIndex;

                clearInterval(interval);

                if($(this).attr("id") == "bannerLeft")
                {
                    newIndex = bannerIndex-1; // 왼쪽 배너를 노출해야 하므로 인덱스-1

                    // 첫 배너에서 왼쪽 클릭 시 끝 배너로 이동
                    if(newIndex < 0)
                        newIndex = bannerLength-1;

                    bannerSlide(newIndex)
                }
                else
                {
                    newIndex = bannerIndex+1; // 오른쪽 배너를 노출해야 하므로 인덱스+1

                    // 끝 배너에서 오른쪽 클릭 시 첫 배너로 이동
                    if(newIndex >= bannerLength)
                        newIndex = 0;

                    bannerSlide(newIndex);
                }

                interval = setInterval(function () {$("#bannerRight").click()}, 3000);
            });

            // 배너 슬라이드 메서드
            function bannerSlide (newIndex) {
                let newPosition = -bannerWidth * newIndex;

                $("#bannerImgArea").stop();
                $("#bannerImgArea").animate({left: newPosition}, 200);

                let bannerIndexList = $("#bannerIndexList > li > button");

                for (let i = 0; i < bannerLength; i++)
                {
                    if(i == newIndex)
                        bannerIndexList.eq(newIndex).css("background","darkRed");
                    else if(i != newIndex)
                        bannerIndexList.eq(i).css("background","");
                }
                bannerIndex = newIndex;
            }

            // 상품이 한 개일 때는 마진값 0으로 주기 (한 개 일때 오른쪽으로 쏠리는게 보기 안 좋음)
            function itemMarginArrange() {
                if ($(".popularItemList > .itemList > .item").length == 1)
                    $(".popularItemList > .itemList > .item").css("marginLeft", "0");

                if ($(".newItemList > .itemList > .item").length == 1)
                    $(".newItemList > .itemList > .item").css("marginLeft", "0");
            }
            itemMarginArrange();

            // 아이템 목록 불러오기 ajax
            function showMainItemList()
            {
                $.ajax({
                    url: "/anitomo/item/mainlist"
                    , type: "GET"
                    , success: function (resultMap) {
                        let newestList = resultMap.newestList;
                        let popularList = resultMap.popularList;
                        let thumbnailList = resultMap.thumbnailList;
                        let newestListHtml = "";
                        let popularListHtml = "";

                        for (let i = 0; i < newestList.length; i++)
                        {
                            let newestItem = newestList[i];
                            newestListHtml += "<div class='item' data-itemcode='" + newestItem.itemCode + "'>"
                                + "<div class='thumbnail'>"
                            if(thumbnailList != null)
                            {
                                for (let thumbnail of thumbnailList)
                                {
                                    let code = thumbnail.code;
                                    if(code == newestItem.itemCode)
                                    {
                                        newestListHtml += "<img src='"+ thumbnail.url +"'>"
                                        break;
                                    }
                                }
                            }
                            newestListHtml += "</div>"
                                + "<div class='itemTitle'>" + newestItem.itemName + "</div>"
                                + "<div class='priceLine'></div>"
                                + "<div class='itemPrice'>￦" + newestItem.itemPrice + "</div>"
                                + "</div>";
                        }

                        for (let i = 0; i < popularList.length; i++)
                        {
                            let popularItem = popularList[i];
                            popularListHtml += "<div class='item' data-itemcode='" + popularItem.itemCode + "'>"
                                + "<div class='thumbnail'>"
                                if(thumbnailList != null)
                                {
                                    for (let thumbnail of thumbnailList)
                                    {
                                        let code = thumbnail.code;
                                        if(code == popularItem.itemCode)
                                        {
                                            popularListHtml += "<img src='"+ thumbnail.url +"'>"
                                            break;
                                        }
                                    }
                                }
                                popularListHtml += "</div>"
                                + "<div class='itemTitle'>" + popularItem.itemName + "</div>"
                                + "<div class='priceLine'></div>"
                                + "<div class='itemPrice'>￦" + popularItem.itemPrice + "</div>"
                                + "</div>";
                        }

                        $(".popularItemList > .itemList").html(popularListHtml);
                        $(".newItemList > .itemList").html(newestListHtml);
                    }
                    , error: function (response) {
                        console.log(response.text);
                    }
                });
            }
            showMainItemList();

            // 상품 상세페이지 이동
            $(document).on("click", ".item" ,function () {
                let url = "/anitomo/item/" + $(this).data("itemcode"); // 커스텀 속성 data-itemcode의 값을 가져옴
                window.location.href = url;
            });
        })
    </script>
</body>
</html>
