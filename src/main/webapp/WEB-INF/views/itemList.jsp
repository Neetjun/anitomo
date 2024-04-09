<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상품목록</title>
    <link rel="stylesheet" href="/resources/css/itemList.css">
    <link rel="icon" href="/resources/favicon.ico">
</head>
<body>
    <c:import url="header.jsp"></c:import>

    <div class="itemListArea wrapper">
        <div class="menuTitle">
            <span>${param.listType eq "newest" ? "신규상품" : param.listType eq "series" ? "작품별" : param.listType eq "maker" ? "제조사별" : "종류별"}</span>
        </div>
        <div class="itemList">
            <div class="searchArea">
                <form action="/item/list" method="get" id="itemSearchForm">
                    <c:if test="${param.listType ne 'newest'}">
                        <input type="text" name="listType" value="${param.listType}" hidden="hidden">
                        <c:if test="${param.listType eq 'mainSearch' || param.listType eq 'series'}">
                            <div class="searchType">
                                <div>작품명</div>
                                <input type="text" id="searchSeries">
                                <input type="text" name="seriesCode" hidden="hidden">
                            </div>
                            <div class="searchSuggest">
                                <c:forEach var="series" items="${seriesList}">
                                    <div class="suggestList" data-seriescode="${series.seriesCode}">${series.seriesName}</div>
                                </c:forEach>
                            </div>
                        </c:if>
                        <c:if test="${param.listType eq 'mainSearch' || param.listType eq 'maker'}">
                            <div class="searchMaker">
                                <div>제조사</div>
                                <select name="makerCode" id="makerInput">
                                    <option value="">제조사</option>
                                    <c:forEach var="maker" items="${makerList}">
                                        <option value="${maker.makerCode}" ${maker.makerName eq item.makerName ? 'selected' : ''}>${maker.makerName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </c:if>
                        <c:if test="${param.listType eq 'totalSearch' || param.listType eq 'itemType'}">
                            <div class="searchItemType">
                                <div>상품분류</div>
                                <select name="itemTypeCode" id="itemTypeInput">
                                    <option value="">상품종류</option>
                                    <c:forEach var="itemType" items="${itemTypeList}">
                                        <option value="${itemType.itemTypeCode}" ${itemType.itemType eq item.itemType ? 'selected' : ''}>${itemType.itemType}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </c:if>
                            <div class="searchKeyword">
                                <div>키워드</div>
                                <input type="text" id="keywordInput" name="keyword">
                            </div>
                        <div class="searchBtn">
                            <div></div>
                            <button id="searchBtn" type="button">검색하기</button>
                        </div>
                    </c:if>
                </form>
            </div>
            <div class="menuTitle sortBtnArea">
                검색결과
                <button type="button" id="price" class="sortBtn">가격낮은순</button>
                <button type="button" id="priceDesc" class="sortBtn">가격높은순</button>
                <button type="button" id="popular" class="sortBtn">인기순</button>
                <button type="button" id="newest" class="sortBtn">최신순</button>
            </div>
            <div class="searchedItemList">
                <c:forEach var="item" items="${itemList}">
                    <div class="item" data-itemcode="${item.itemCode}">
                        <div class="thumbnail">
                            <c:set var="noImage" value="true"></c:set>
                            <c:forEach var="thumbnail" items="${thumbnailList}">
                                <c:if test="${thumbnail.code eq item.itemCode}">
                                    <img src='${thumbnail.url}' alt='' class='thumbnailImg'>
                                    ${noImage = "false"}
                                </c:if>
                            </c:forEach>
                            <c:if test="${noImage eq 'true'}">
                                <img src='/resources/img/tmpItemImage.jpg' alt='' class='thumbnailImg'>
                            </c:if>
                        </div>
                        <div class="itemTitle">${item.itemName}</div>
                        <div class="priceLine"></div>
                        <div class="itemPrice">${item.itemPrice}</div>
                        <div class="itemStatusArea">
                            <span class="newItem">new</span>
                            <span class="onSale">sale</span>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="pageArea">
                <c:set var="endPage" value="${10 - (param.page%10 == 0 ? param.page : param.page%10) + param.page}"></c:set>
                <c:set var="startPage" value="${endPage - 9}"></c:set>
                <c:set var="pages" value="${startPage}"></c:set>
                <c:set var="flag" value="${countItemList/10}"></c:set>
                <c:if test="${param.page - 10 > 0}">
                    <button class="page" value="${startPage-1}"><</button>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}">
                    <c:if test="${pages <= (flag+(1-flag%1))}">
                        <button class="page" value="${pages}">${pages}</button>
                        <c:set var="pages" value="${pages+1}"></c:set>
                    </c:if>
                </c:forEach>
                <c:if test="${endPage <= flag+(1-flag%1)}">
                    <button class="page" value="${endPage+1}">></button>
                </c:if>
            </div>
        </div>
    </div>

    <c:import url="footer.jsp"></c:import>

    <script>
        $(document).ready(function () {
            $("#searchSeries").keyup(function () {
                let seriesKeyword = $(this).val().replaceAll(" ","");
                let seriesList = $(".suggestList");

                console.log(seriesKeyword);

                for (let i = 0; i < seriesList.length; i++)
                {
                    let series = $(seriesList).eq(i);
                    let seriesName = seriesList.eq(i).text().replaceAll(" ","");

                    if(seriesName.indexOf(seriesKeyword) >= 0 && seriesKeyword != "")
                        $(series).css("display","block");
                    else
                        $(series).css("display","none");

                    console.log(seriesName.indexOf(seriesKeyword));
                }
            })

            $(".suggestList").click(function () {
                $("#searchSeries").val($(this).text());
                $("input[name='seriesCode']").val($(this).data("seriescode"))
                $(".suggestList").css("display","none");
            })

            $("#searchBtn").click(function () {
                if($("input[name='seriesCode']").val() == "" || $("#keywordInput").val() == "")
                {
                    alert("검색 내용을 입력해주세요.");
                    return;
                }
                $("#itemSearchForm").submit();
            })

            $(".item").click(function () {
                window.location.href = "/item/"+$(this).data("itemcode");
            });

            $(".sortBtn").click(function () {
                let url = new URL(window.location.href);
                url.searchParams.set("sort",$(this).attr("id"));
                window.location.href = url.toString();
            });

            $("button[id='${param.sort}']").css("backgroundColor","darkred");

            $("button[value='${param.page}']").css("backgroundColor","darkred");

            $(".page").click(function () {
                let url = new URL(window.location.href);
                url.searchParams.set("page",$(this).val());
                window.location.href = url.toString();
            })
        })
    </script>
</body>
</html>
