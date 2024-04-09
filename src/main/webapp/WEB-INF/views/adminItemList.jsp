<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <link rel="stylesheet" href="/resources/css/adminItemList.css">
</head>
<body>

    <div class="itemListArea">
        <div class="itemSearchArea">
            <form action="/admin/itemlist" id="adminItemListSearchForm">
                <input type="text" id="adminItemSearchInput" name="keyword" placeholder="상품명 / 상품코드">
                <input type="text" name="page" value="1" hidden="hidden">
                <i id="adminItemSearchIcon" class="fa-solid fa-magnifying-glass searchIcon"></i>
            </form>
        </div>
        <div class="itemListTableArea">
            <table id="adminItemListTable">
                <tr class="tableHead">
                    <th id="adminItemCheckBox"><input type="checkbox" id="checkAll"></th>
                    <th id="adminItemCode">상품코드</th>
                    <th id="adminItemType">상품종류</th>
                    <th id="adminItemName">상품명</th>
                    <th id="adminItemPrice">상품가격</th>
                    <th id="adminItemDate">상품등록일</th>
                    <th id="tableBtn">상품관리</th>
                </tr>
                <c:forEach var="item" items="${itemList}">
                    <tr class="itemListContent">
                        <td class="tableCheckbox"><input type="checkbox" class="adminItemCheckBox" value="${item.itemCode}"></td>
                        <td class="adminItemCode">${item.itemCode}</td>
                        <td class="adminItemType">${item.itemType}</td>
                        <td class="adminItemName">
                            <div class='thumbnailArea'>
                                <div class='thumbnailBox'>
                                    <c:forEach var="thumbnail" items="${thumbnailList}">
                                        <c:if test="${thumbnail.code eq item.itemCode}">
                                            <img src='${thumbnail.url}' alt='' class='thumbnail'>
                                        </c:if>
                                    </c:forEach>
                                </div>
                                <div>${item.itemName}</div>
                            </div>
                        </td>
                        <td class="adminItemPrice">${item.itemPrice}원</td>
                        <td class="adminItemDate">${item.itemDate}</td>
                        <td class="tableBtn">
                            <button type="button" value="${item.itemCode}" class="itemUpdateBtn">상품수정</button>
                            <button type="button" value="${item.itemCode}" class="itemDeleteBtn">상품삭제</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <div class="adminItemBtnArea">
            <button type="button" id="checkedItemDeleteBtn">선택삭제</button>
            <button type="button" id="itemEnrollBtn">상품등록</button>
        </div>
        <form action="/item?mode=delete" method="post" id="itemDeleteForm" hidden="hidden">
            <input type="text" id="deleteItemCodeInput" name="itemCode"/>
        </form>
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

    <script>
        $(document).ready(function () {

            $("#adminItemSearchIcon").click(function () {
                if($("#adminItemSearchInput").val().trim() == "")
                {
                    alert("검색어를 입력해주세요.");
                    return;
                }
                $("#adminItemListSearchForm").submit();
            })

            // 전체 체크박스 체크 이벤트
            $("#checkAll").click(function () {
                let checkFlag = $(this).prop("checked");

                if(checkFlag)
                    $(".adminItemCheckBox").prop("checked","true");
                else if(!checkFlag)
                    $(".adminItemCheckBox").prop("checked", "");
            });

            // 체크박스 일부 해제 시 전체 체크박스 체크 해제
            $(document).on("click", ".adminItemCheckBox", function () {
                let checkboxArray = $(".adminItemCheckBox");

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

            $(".adminItemName").click(function () {
                window.location.href = "/item/"+$(this).siblings(".adminItemCode").text();
            })

            // 상품 삭제 버튼
            $(".itemDeleteBtn").click(function () {
                if(confirm("상품을 삭제하시겠습니까?"))
                {
                    $("#deleteItemCodeInput").val($(this).val());
                    $("#itemDeleteForm").submit();
                }
            })

            // 상품 수정 버튼
            $(".itemUpdateBtn").click(function () {
                window.location.href = "/admin/item?mode=update&itemCode="+$(this).val();
            })
            
            // 선택 삭제 버튼
            $("#checkedItemDeleteBtn").click(function () {
                if(confirm("정말 삭제하시겠습니까?"))
                {
                    let itemList = $(".adminItemCheckBox");
                    let deleteItems = "";

                    for (let i = 0; i < itemList.length; i++)
                    {
                        let item = itemList.eq(i);

                        if(item.prop("checked"))
                            deleteItems += item.val()+" ";
                    }
                    deleteItems = deleteItems.trim();

                    $("#deleteItemCodeInput").val(deleteItems);
                    $("#itemDeleteForm").submit();
                }
            })

            // 상품 등록 폼
            $("#itemEnrollBtn").click(function () {
                window.location.href = "/admin/item";
            })

            $("button[value='${param.page}']").css("backgroundColor","darkred");

            // 페이지 이동
            $(".page").click(function () {
                let url = new URL(window.location.href);
                url.searchParams.set("page",$(this).val());
                window.location.href = url.toString();
            })
        })
    </script>

</body>
</html>
