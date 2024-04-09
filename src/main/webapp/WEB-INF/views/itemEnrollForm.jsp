<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <link rel="stylesheet" href="/anitomo/resources/css/itemEnrollForm.css">
</head>
<body>
    <div class="itemEnrollFormArea">
        <form action="${item eq null ? '/anitomo/item' : '/anitomo/item?mode=update&itemCode='}${item.itemCode}" method="post" id="itemEnrollForm">
            <div class="itemNameInputArea">
                <div class="inputType">상품명</div>
                <input type="text" id="itemNameInput" value="${item.itemName}" name="itemName">
            </div>
            <div class="itemInfoArea">
                <div class="inputType">상품가격</div>
                <input type="text" id="itemPriceInput" value="${item eq null ? '1' : item.itemPrice}">원
                <input type="text" name="itemPrice" value="${item eq null ? '1' : item.itemPrice}" hidden="hidden">
                <div class="inputType">상품사이즈</div>
                <input type="text" id="itemSizeInput" value="${item.itemSize}" name="itemSize">cm
                <div class="inputType">제조사</div>
                <select name="makerCode" id="makerInput">
                    <option value="">제조사</option>
                    <c:forEach var="maker" items="${makerList}">
                        <option value="${maker.makerCode}" ${maker.makerName eq item.makerName ? 'selected' : ''}>${maker.makerName}</option>
                    </c:forEach>
                </select>
                <div class="inputType">등록작품</div>
                <select name="seriesCode" id="seriesInput">
                    <option value="">등장작품</option>
                    <c:forEach var="series" items="${seriesList}">
                        <option value="${series.seriesCode}" ${series.seriesName eq item.seriesName ? 'selected' : ''}>${series.seriesName}</option>
                    </c:forEach>
                </select>
                <div class="inputType">상품종류</div>
                <select name="itemTypeCode" id="itemTypeInput">
                    <option value="">상품종류</option>
                    <c:forEach var="itemType" items="${itemTypeList}">
                        <option value="${itemType.itemTypeCode}" ${itemType.itemType eq item.itemType ? 'selected' : ''}>${itemType.itemType}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="itemDescriptionInputArea">
                <div class="inputType">상품설명</div>
                <textarea name="itemDescription" id="itemDescriptionInput" spellcheck="false">${item.itemDescription}</textarea>
            </div>
            <div class="submitBtnArea">
                <button type="button" id="itemSubmitBtn">${item eq null ? "등록하기" : "수정하기"}</button>
                <button type="button" id="cancelBtn">취소하기</button>
            </div>
        </form>
    </div>
    <script src="/anitomo/resources/ckeditor/ckeditor.js"></script>
    <script>
        $(document).ready(function () {

            function callEditor()
            {
                let placeholder = "모든 이미지는 상품상세 페이지에서 자동 가운데 정렬 됩니다. 가장 처음 등록된 이미지가 썸네일로 지정됩니다.";
                console.log(placeholder);
                CKEDITOR.replace('itemDescriptionInput', {
                    filebrowserUploadUrl : '/anitomo/item/image?itemCode='+"${item.itemCode}", // 이미지 업로드 Controller url
                    width : "99%",
                    height : "500px",
                    resize_enabled : false,
                    editorplaceholder : placeholder
                });
            }
            callEditor();

            let editorContent = CKEDITOR.instances.itemDescriptionInput;

            $("#adminPageBody").css("height","auto");
            $("#adminPageHtml").css("height","auto");

           // 가격 입력 시 제출되는 input에 값을 넣고 입력 input에는 보기 좋게 콤마 표시
            $("#itemPriceInput").keyup(function () {
                let regex = /^[0-9]*$/;
                let itemPrice =  $("input[name='itemPrice']");

                if($(this).val().replaceAll(" ","") == "")
                    return;

                if(!regex.test(itemPrice.val()) || parseInt(itemPrice.val()) < 1)
                {
                    alert("입력값이 올바르지 않습니다!");
                    itemPrice.val(1);
                    $(this).val(1);
                    return;
                }

                itemPrice.val($(this).val().replaceAll(" ","").replaceAll(",",""));

                let priceText = parseInt(itemPrice.val()).toLocaleString();
                $(this).val(priceText);
            })

            // update 폼인 경우 가격 불러올 때 콤마 처리
            function initialComma()
            {
                let priceText = $("#itemPriceInput").val();
                priceText = parseInt(priceText).toLocaleString();
                $("#itemPriceInput").val(priceText);
            }
            initialComma();

           $(".submitBtnArea > button").click(function () {
               if($(this).attr("id") == "cancelBtn")
                   return window.location.href = "/anitomo/admin/itemlist";
               else
               {
                   let data = editorContent.getData();
                   $("#itemDescriptionInput").val(data);

                    // 정규 표현식을 사용하여 파일명 추출
                   let regex = /src="\/img\/items\/(.*?)"/g;
                   let matches, output = [];

                   // exec() 메서드를 사용해 모든 매치를 찾습니다.
                   while ((matches = regex.exec(data)) !== null)
                   {
                       let result = matches[1].substring(matches[1].indexOf("/")+1);
                       output.push(result);
                   }

                   let imageNameList = "";

                   for (let i = 0; i < output.length; i++)
                   {
                       let name = output[i];

                       imageNameList += name;

                       if(i != output.length-1)
                           imageNameList += ",";
                   }

                   let input = $("<input name='imageNameList' value='" + imageNameList +"' hidden='hidden'>");

                   $("#itemEnrollForm").append(input);
                   $("#itemEnrollForm").submit();
               }
           })
        });
    </script>
</body>
</html>
