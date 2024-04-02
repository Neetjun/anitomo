<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="/resources/css/userRegistrationForm.css">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="icon" href="/resources/favicon.ico">
</head>
<body>
    <c:import url="header.jsp" charEncoding="utf-8"></c:import>

    <div class="registerFormArea wrapper">
        <div class="menuTitle">
            <i class="fa-solid fa-user"></i>
            <span>회원가입</span>
        </div>
        <form action="/user" method="post" id="registrationForm">
            <div class="inputArea">
                <div class="inputId">
                    <div>아이디</div>
                    <input type="text" id="userId" name="userId" placeholder="영문+숫자 5~15자">
                    <button type="button" id="idCheckBtn">중복확인</button>
                    <span id="idCheckResult">사용 가능한 아이디 입니다!</span>
                </div>
                <div class="inputPw">
                    <div>비밀번호</div>
                    <input type="password" id="userPw" name="userPw" placeholder="영문+숫자+특수문자 8~15자">
                    <span id="pwCheckResult">비밀번호 형식이 알맞지 않습니다!</span>
                </div>
                <div class="inputPwCheck">
                    <div>비밀번호 확인</div>
                    <input type="password" id="pwCheck" name="pwCheck">
                    <span id="pwCheckResult2">비밀번호가 일치하지 않습니다!</span>
                </div>
                <div class="inputName">
                    <div>이름</div>
                    <input type="text" name="userName" placeholder="한글 또는 영어">
                    <span id="nameCheckResult">이름 형식이 올바르지 않습니다!</span>
                </div>
                <div class="inputTel">
                    <div>전화번호</div>
                    <input type="tel" name="userTelArr" placeholder="010"> - <input type="tel" name="userTelArr" placeholder="1111"> - <input type="tel" name="userTelArr" placeholder="2222">
                    <span id="telCheckResult">전화번호 형식이 알맞지 않습니다!</span>
                </div>
                <div class="inputBirth">
                    <div>생년월일</div>
                    <input type="text" name="userBirth" readonly="readonly">
                </div>
            </div>
            <div class="submitBtnArea">
                <button type="button" id="submitBtn">회원가입</button>
                <button type="button" id="cancelBtn">취소</button>
            </div>
        </form>
    </div>

    <c:import url="footer.jsp"></c:import>

    <%-- 스크립트 영역 --%>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $(document).ready(function () {
            $("#cancelBtn").click(function () {
                window.location.href = "/";
            });

            $("#submitBtn").click(function () {
                // 1. 모든 입력사항을 기재했는가
                let inputs = $(".inputArea > div > input");

                for (let i = 0; i < inputs.length; i++)
                {
                    let input = inputs.eq(i);

                    if(input.val() == "")
                    {
                        alert("모든 입력사항을 입력해주세요.");
                        return;
                    }
                }

                // 2. 아이디 중복검사를 수행했는가?
                if($("#idCheckResult").css("display") == "none")
                {
                    alert("id 중복검사를 해주세요.");
                    return;
                }

                // 3. 아이디에 문제가 없는가?
                if($("#idCheckResult").attr("pass") != "pass")
                {
                    $("#userId").focus();
                    return;
                }

                // 4. 비밀번호에 문제가 없는가?
                if($("#pwCheckResult").attr("pass") != "pass")
                {
                    $("#userPw").focus();
                    return;
                }
                else if($("#pwCheckResult2").attr("pass") != "pass")
                {
                    $("#pwCheck").focus();
                    return;
                }

                // 5. 이름에 문제는 없는가?
                if($("#nameCheckResult").attr("pass") != "pass")
                {
                    $("input[name='userName']").focus();
                    return;
                }

                // 6. 전화번호에 문제가 없는가?
                if($("#telCheckResult").attr("pass") != "pass")
                {
                    $("input[type='tel']").eq(0).focus();
                    return;
                }

                $("#registrationForm").submit();
            });

            // 달력 input 클릭 시 데이트피커 노출
            $(".inputBirth > input").datepicker({
                dateFormat: 'yy-mm-dd' //달력 날짜 형태
                ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
                ,changeYear: true //option값 년 선택 가능
                ,changeMonth: true //option값  월 선택 가능
                ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
                ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
                ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
                ,buttonText: "선택" //버튼 호버 텍스트
                ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
                ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
                ,minDate: "-100Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
                ,maxDate: "+100y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
                ,yearRange: "c-100:c+10"
            });

            $("#idCheckBtn").click(function () {
               $.ajax({
                   url : "/user/idcheck"
                   , type : "GET"
                   , data : {"userId" : $("#userId").val()}
                   , contentType : "application/json"
                   , success : function (result)
                   {
                        if(result == "success")
                        {
                            $("#idCheckResult").css("color","blue");
                            $("#idCheckResult").attr("pass","pass");
                            $("#idCheckResult").text("사용 가능한 아이디 입니다!");
                        }
                        else if(result == "fail")
                        {
                            $("#idCheckResult").css("color","darkred");
                            $("#idCheckResult").attr("pass","fail");
                            $("#idCheckResult").text("중복된 아이디 입니다!");
                        }
                        else if(result == "patternError")
                        {
                            $("#idCheckResult").css("color","darkred");
                            $("#idCheckResult").attr("pass","fail");
                            $("#idCheckResult").text("아이디 형식이 알맞지 않습니다!");
                        }
                        $("#idCheckResult").css("display", "block");
                   }
                   , error : function (error)
                   {
                        console.log(error);
                   }
               })
            });

            $("#userPw").blur(function () {
                if($("#userPw").val() != "")
                {
                    $.ajax({
                        url: "/user/pwcheck"
                        , type: "GET"
                        , data: {"userPw": $("#userPw").val()}
                        , contentType: "application/json"
                        , success: function (result) {
                            if (result == "fail")
                            {
                                $("#pwCheckResult").css("display", "block");
                                $("#pwCheckResult").attr("pass", "fail");
                            }

                            else
                            {
                                $("#pwCheckResult").css("display", "none");
                                $("#pwCheckResult").attr("pass", "pass");
                            }

                        }
                        , error: function (error) {
                            console.log(error);
                        }
                    })
                }
            });

            $("#pwCheck").blur(function () {
                if($("#userPw").val() != $("#pwCheck").val())
                {
                    $("#pwCheckResult2").css("display", "block");
                    $("#pwCheckResult2").attr("pass", "fail");
                }
                else if($("#userPw").val() == $("#pwCheck").val())
                {
                    $("#pwCheckResult2").css("display", "none");
                    $("#pwCheckResult2").attr("pass", "pass");
                }
            });

            $("input[type='tel']").blur(function () {

                let tel = $(this);
                let regex = /^[0-9]+$/;

                if(!regex.test(tel.val()))
                {
                    $("#telCheckResult").attr("pass","fail");
                    $("#telCheckResult").css("display","block");
                }
                else if(regex.test(tel.val()))
                {
                    $("#telCheckResult").attr("pass","pass");
                    $("#telCheckResult").css("display","none");
                }
            });

            $("input[name='userName']").blur(function () {
                let regex = /^([가-힣]+|[a-zA-Z]+)$/;
                let name = $(this);

                if(!regex.test(name.val()))
                {
                    $("#nameCheckResult").attr("pass","fail");
                    $("#nameCheckResult").css("display","block");
                }
                else if(regex.test(name.val()))
                {
                    $("#nameCheckResult").attr("pass","pass");
                    $("#nameCheckResult").css("display","none");
                }
            });
        })
    </script>
</body>
</html>
