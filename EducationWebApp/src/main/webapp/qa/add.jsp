<%-- 
    Document   : add
    Created on : Jun 8, 2025, 10:57:25 PM
    Author     : ledai
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm QA</title>
</head>
<body>
    <h2>Thêm câu hỏi - trả lời mới</h2>
    <form action="${pageContext.request.contextPath}/manage-qa" method="post">
        <label>Câu hỏi:</label><br>
        <input type="text" name="question" required><br><br>

        <label>Từ khóa:</label><br>
        <input type="text" name="key" required><br><br>

        <label>Trả lời:</label><br>
        <textarea name="answer" rows="4" cols="40" required></textarea><br><br>

        <button type="submit">Thêm mới</button>
    </form>
    <br>
    <a href="${pageContext.request.contextPath}/manage-qa">← Quay lại danh sách</a>
</body>
</html>
