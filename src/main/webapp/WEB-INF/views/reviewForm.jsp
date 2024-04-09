<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="/resources/css/reviewForm.css">
</head>
<body>
    <div class="menuTitle">
        <i class="fa-solid fa-bars"></i>
        <span>${reviewCode eq null ? "리뷰등록" : "리뷰확인"}</span>
    </div>

    <div class="mypageContent">
        <div class="reviewFormArea">
            <c:forEach var="item" items="${orderItemList}">
                <div class="orderItem">
                    <div class="orderInfo">
                        <div class='itemInfoArea'>
                            <div class='itemInfo'>
                                <div class='thumbnailArea'>
                                    <div class='thumbnailBox'>
                                        <img src='/resources/img/tmpItemImage.jpg' alt='' class='thumbnail'>
                                    </div>
                                </div>
                                <div class='itemNameAndPrice'>
                                    <div class='itemName'> ${item.itemName}</div>
                                    <div class="itemRateArea">
                                        <div class="ratingStar" id="${item.itemCode}">
                                            <span class="star" data-value="1">★</span>
                                            <span class="star" data-value="2">★</span>
                                            <span class="star" data-value="3">★</span>
                                            <span class="star" data-value="4">★</span>
                                            <span class="star" data-value="5">★</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <div class="reviewInputArea">
                <div class="reviewTitleArea">
                    <div class="inputType">
                        리뷰 제목
                    </div>
                    <input type="text" value="${review.reviewTitle}" id="reviewTitleInput" ${review eq null ? "" : "readonly='readonly'"}>
                </div>
                <div class="reviewContentArea">
                    <div class="inputType">
                        리뷰 내용
                    </div>
                    <textarea id="reviewContentInput" spellcheck="false" ${review eq null ? "" : "readonly='readonly'"}>${review.reviewContent}</textarea>
                </div>
                <div id="imageInputArea">
                    <c:choose>
                        <c:when test="${review eq null}">
                            <div class="inputType">
                                사진 첨부
                            </div>

                            <div class="imageBtnArea">
                                <button id="imageBtn" type="button">사진첨부</button>
                                <input type="file" id="imageInput" hidden="hidden" accept="image/*">
                                <span id="imageCount">0/10</span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="imageUrl" items="${fileList}">
                                <div class="imagePreviewArea">
                                    <div class="imagePreviewBox">
                                        <img src="${imageUrl}" alt="" class="uploadedImg">
                                    </div>
                                    <button class="imageDeleteBtn" type="button" hidden="hidden">x</button>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="submitBtnArea">
                    <c:choose>
                        <c:when test="${review eq null}">
                            <button type="button" id="reviewSubmitBtn" class="reviewBtn">등록하기</button>
                            <button type="button" id="cancelBtn" class="reviewBtn">취소하기</button>
                        </c:when>
                        <c:otherwise>
                            <div class="editBtnArea">
                                <div class="editBtn">
                                    <button type="button" id="reviewUpdateBtn" class="reviewBtn">수정</button>
                                    <button type="button" id="reviewDeleteBtn" class="reviewBtn">삭제</button>
                                </div>
                                <button type="button" id="returnBtn" class="reviewBtn">돌아가기</button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {

            let fileMap = new Map();
            let deleteFileArr = [];

            function drawRate()
            {
                let stars = $(".ratingStar");

                if(${rateList ne null})
                {
                    for (let i = 0; i < stars.length; i++)
                    {
                        let starArr = stars.eq(i).children(".star");
                        let rate = ${rateList}[i];

                        for(let i = 0; i < starArr.length; i++)
                        {
                            let star = starArr.eq(i);
                            if(star.data("value") <= rate)
                                star.css("color","darkred");
                            else
                                star.css("color","darkgray");

                            if(star.data("value") == rate)
                                star.addClass("selected");
                            else
                                star.removeClass("selected");
                        }
                    }
                }
            }
            drawRate();

            $(".star").click(function () {
                if($(".menuTitle > span").text() != "리뷰확인")
                {
                    let rate = $(this).data("value");
                    let itemCode = $(this).parent().attr("id");
                    let starArr = $("#"+itemCode).children(".star");
                    let selectedRate = $("#"+itemCode).children(".selected").data("value");

                    // 같은 별을 눌렀을 때는 취소
                    if(rate == selectedRate)
                    {
                        starArr.css("color","darkgray");
                        starArr.removeClass("selected");
                        return;
                    }

                    for(let i = 0; i < starArr.length; i++)
                    {
                        let star = starArr.eq(i);

                        if(star.data("value") <= rate)
                            star.css("color","darkred");
                        else
                            star.css("color","darkgray");

                        if(star.data("value") == rate)
                            star.addClass("selected");
                        else
                            star.removeClass("selected");
                    }
                }
            })

            $(document).on("click", "#imageBtn", function () {

                if(fileMap.size >= 10)
                {
                    alert("이미지는 최대 10개까지만 저장이 가능합니다.");
                    return;
                }
                $("#imageInput").click();
            });
            $(document).on("change", "#imageInput", function (e) {
                let uploadedFile = e.target.files[0];

                if(fileMap.has(uploadedFile.name))
                    return;

                fileMap.set(uploadedFile.name, uploadedFile);

                let previewArea = $("<div class='imagePreviewArea'></div>");
                let imageBox = $("<div class='imagePreviewBox'></div>");
                let button = $("<button class='imageDeleteBtn' type='button'>x</button>");
                button.attr("value",uploadedFile.name);
                previewArea.append(imageBox);
                previewArea.append(button);

                let image = $("<img/>");
                let imageTmpUrl = window.URL.createObjectURL(uploadedFile);
                image.attr("src",imageTmpUrl);
                image.attr("class","uploadedImg");
                imageBox.append(image);

                $("#imageInputArea").append(previewArea);
                $("#imageCount").text(fileMap.size+"/10");

                console.log(fileMap);
            })

            $(document).on("click",".imageDeleteBtn",function () {

                if($(this).hasClass("existsImage"))
                {
                    let fileName = $(this).prev().children(".uploadedImg").attr("src");
                    fileName = fileName.substring(fileName.lastIndexOf("/")+1,fileName.length);
                    deleteFileArr.push(fileName);
                    fileMap.delete(fileName);
                    console.log(deleteFileArr);
                    $("#imageCount").text((fileMap.size)+"/10");
                }

                fileMap.delete($(this).val());
                $(this).parent().remove();
                $("#imageCount").text(fileMap.size+"/10");
                console.log("=======삭제======")
                console.log(fileMap);
            });

            $(document).on("click", ".submitBtnArea > button", function () {
                let buttonType = $(this).attr("id");
                let url;
                if (buttonType == "reviewSubmitBtn" || buttonType == "submitUpdateBtn")
                {
                    let formData = new FormData();

                    let files = fileMap.values();

                    for (let file of files)
                        if (file != "")
                            formData.append("fileArr", file);

                    for(let i = 0; i < $(".ratingStar").length; i ++)
                    {
                        let itemCode = $(".ratingStar").eq(i);
                        formData.append("itemCodeArr", itemCode.attr("id"));

                        if(itemCode.children("span").hasClass("selected"))
                            formData.append("rateArr", itemCode.children(".selected").data("value"));
                        else
                            formData.append("rateArr", "0");
                    }

                    formData.append("reviewTitle", $("#reviewTitleInput").val());
                    formData.append("reviewContent", $("#reviewContentInput").val());
                    formData.append("orderCode", "${orderCode}");

                    if(buttonType == "reviewSubmitBtn")
                        url = "/user/review";
                    else
                    {
                        for (let filename of deleteFileArr)
                            formData.append("deleteFileArr",filename);
                        formData.append("reviewCode","${reviewCode}");

                        url = "/user/review?mode=update"
                    }
                    $.ajax({
                        url: url
                        , type: "POST"
                        , data: formData
                        , contentType: false
                        , processData: false
                        , success: function (orderCode) {
                            window.location.href = "/user/review/" + orderCode;
                        }
                        , error: function (response) {
                            console.log(response.responseText)
                        }
                    })
                }
                else if (buttonType == "updateCancelBtn")
                    window.location.href = "/user/review/"+"${orderCode}";
            });
            
            $(".editBtn > button").click(function () {
                if($(this).attr("id") == "reviewUpdateBtn")
                {
                    // input readonly 속성 해제
                    $("#reviewTitleInput").removeAttr("readonly");
                    $("#reviewContentInput").removeAttr("readonly");

                    // 이미지 삭제버튼 노출
                    $(".imageDeleteBtn").removeAttr("hidden");

                    // 이미지 첨부 영역 생성
                    let html = '<div class="inputType">사진 첨부</div>'
                        + '<div class="imageBtnArea">'
                        + '<button id="imageBtn" type="button">사진첨부</button>'
                        + '<input type="file" id="imageInput" hidden="hidden" accept="image/*">'
                        +'</div>';

                    $("#imageInputArea").prepend(html);

                    // 기존에 업로드 되어있던 이미지 버튼들은 클래스로 따로 구분
                    $(".imageDeleteBtn").addClass("existsImage");

                    // 기존 이미지 fileMap에 추가 (실제 영향은 없더라도 파일갯수 컨트롤을 위해)
                    let existsImageBtn = $(".existsImage");

                    for (let i = 0; i < existsImageBtn.length; i++)
                    {
                        let button = existsImageBtn.eq(i);
                        let fileName = $(button).prev().children(".uploadedImg").attr("src");
                        fileName = fileName.substring(fileName.lastIndexOf("/")+1,fileName.length);
                        fileMap.set(fileName,"");
                    }

                    console.log(fileMap);

                    // 이미지 갯수 텍스트 생성
                    $(".imageBtnArea").append('<span id="imageCount">'+ fileMap.size +'/10</span>');

                    // menuTitle 변경
                    $(".menuTitle > span").text("리뷰 수정");

                    // 버튼 영역 변경
                    html = '<button type="button" id="submitUpdateBtn" class="reviewBtn">수정하기</button>'
                        +'<button type="button" id="updateCancelBtn" class="reviewBtn">취소하기</button>';
                    $(".submitBtnArea").html(html);

                    return;
                }
                else if($(this).attr("id") == "reviewDeleteBtn")
                    confirm("정말 삭제하시겠습니까? \n리뷰 삭제 후 재등록이 불가능합니다.")
                    {
                        $.ajax({
                            url: "/user/review?mode=delete"
                            , type: "POST"
                            , data: {"reviewCode" : "${reviewCode}", "orderCode" : "${orderCode}"}
                            , success: function () {
                                window.location.href = "/user/mypage/reviewlist";
                            }
                            , error: function (response) {
                                console.log(response.responseText)
                            }
                        })
                    }
            });

            $("#returnBtn").click(function () {
               window.location.href = "/user/mypage/reviewlist";
            });
        })
    </script>
</body>
</html>
