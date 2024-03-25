<%--
  Created by IntelliJ IDEA.
  User: Neetjun
  Date: 2024-03-24
  Time: 오후 5:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>파일업로드 테스트</title>
</head>
<body>
    <form action="/uploadtest" method="post" enctype="multipart/form-data">
        <input type="file" name="fileList" multiple>
        <button>제출하기</button>
    </form>
</body>
</html>
