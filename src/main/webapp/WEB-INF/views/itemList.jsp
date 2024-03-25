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
            <span>임시메뉴</span>
        </div>
        <div class="itemList">
            <div class="searchArea">
                <form action="" method="get" name="searchForm">
                    <div class="searchType">
                        <div>작품명</div>
                        <input type="text" id="searchSeries" name="searchSeries">
                    </div>
                    <div class="searchSuggest">
                        <div class="suggestList">자동검색</div>
                        <div class="suggestList">자동검색</div>
                        <div class="suggestList">자동검색</div>
                        <div class="suggestList">자동검색</div>
                    </div>
                    <div class="searchMaker">
                        <div>제조사</div>
                        <select name="searchMaker">
                            <option value="*">제조사</option>
                            <option value="굿스마일">굿스마일</option>
                        </select>
                    </div>
                    <div class="searchItemType">
                        <div>상품분류</div>
                        <select name="searchMaker">
                            <option value="*">상품종류</option>
                            <option value="p">피규어</option>
                        </select>
                    </div>
                    <div class="searchKeyword">
                        <div>키워드</div>
                        <input type="text" id="keywordInput" name="keyword">
                    </div>
                    <div class="searchBtn">
                        <div></div>
                        <button id="searchBtn" type="button">검색하기</button>
                    </div>
                </form>
            </div>
            <div class="menuTitle sortBtnArea">
                검색결과
                <button type="button">가격낮은순</button>
                <button type="button">가격높은순</button>
                <button type="button">인기순</button>
                <button type="button">최신순</button>
            </div>
            <div class="searchedItemList">
                <div class="item">
                    <div class="thumbnail"></div>
                    <div class="itemTitle">테스트용 제목입니다1. 신경쓰지 마시길. 그런데 피규어는 꽤 비싸요.</div>
                    <div class="priceLine"></div>
                    <div class="itemPrice">￦2,500</div>
                    <div class="itemStatusArea">
                        <span class="newItem">new</span>
                        <span class="onSale">sale</span>
                    </div>
                </div>
                <div class="item">
                    <div class="thumbnail"></div>
                    <div class="itemTitle">테스트용 제목입니다2. 신경쓰지 마시길. 그런데 피규어는 꽤 비싸요.</div>
                    <div class="priceLine"></div>
                    <div class="itemPrice">￦2,500</div>
                </div>
                <div class="item">
                    <div class="thumbnail"></div>
                    <div class="itemTitle">테스트용 제목입니다3. 신경쓰지 마시길. 그런데 피규어는 꽤 비싸요.</div>
                    <div class="priceLine"></div>
                    <div class="itemPrice">￦2,500</div>
                </div>
                <div class="item">
                    <div class="thumbnail"></div>
                    <div class="itemTitle">테스트용 제목입니다4. 신경쓰지 마시길. 그런데 피규어는 꽤 비싸요.</div>
                    <div class="priceLine"></div>
                    <div class="itemPrice">￦2,500</div>
                </div>
                <div class="item">
                    <div class="thumbnail"></div>
                    <div class="itemTitle">테스트용 제목입니다5. 신경쓰지 마시길. 그런데 피규어는 꽤 비싸요.</div>
                    <div class="priceLine"></div>
                    <div class="itemPrice">￦2,500</div>
                </div>
                <div class="item">
                    <div class="thumbnail"></div>
                    <div class="itemTitle">테스트용 제목입니다1. 신경쓰지 마시길. 그런데 피규어는 꽤 비싸요.</div>
                    <div class="priceLine"></div>
                    <div class="itemPrice">￦2,500</div>
                    <div class="itemStatusArea">
                        <span class="newItem">new</span>
                        <span class="onSale">sale</span>
                    </div>
                </div>
                <div class="item">
                    <div class="thumbnail"></div>
                    <div class="itemTitle">테스트용 제목입니다2. 신경쓰지 마시길. 그런데 피규어는 꽤 비싸요.</div>
                    <div class="priceLine"></div>
                    <div class="itemPrice">￦2,500</div>
                </div>
                <div class="item">
                    <div class="thumbnail"></div>
                    <div class="itemTitle">테스트용 제목입니다3. 신경쓰지 마시길. 그런데 피규어는 꽤 비싸요.</div>
                    <div class="priceLine"></div>
                    <div class="itemPrice">￦2,500</div>
                </div>
                <div class="item">
                    <div class="thumbnail"></div>
                    <div class="itemTitle">테스트용 제목입니다4. 신경쓰지 마시길. 그런데 피규어는 꽤 비싸요.</div>
                    <div class="priceLine"></div>
                    <div class="itemPrice">￦2,500</div>
                </div>
                <div class="item">
                    <div class="thumbnail"></div>
                    <div class="itemTitle">테스트용 제목입니다5. 신경쓰지 마시길. 그런데 피규어는 꽤 비싸요.</div>
                    <div class="priceLine"></div>
                    <div class="itemPrice">￦2,500</div>
                </div>
            </div>
            <div class="pageArea">
                <a href=""><</a>
                <a href="">1</a>
                <a href="">2</a>
                <a href="">3</a>
                <a href="">4</a>
                <a href="">5</a>
                <a href="">6</a>
                <a href="">7</a>
                <a href="">8</a>
                <a href="">9</a>
                <a href="">10</a>
                <a href="">></a>
            </div>
        </div>
    </div>

    <c:import url="footer.jsp"></c:import>
</body>
</html>
