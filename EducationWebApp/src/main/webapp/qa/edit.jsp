<%-- 
    Document   : edit
    Created on : Jun 8, 2025, 10:57:42 PM
    Author     : ledai
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.ChatQA" %>
<%
    ChatQA qa = (ChatQA) request.getAttribute("qa");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa QA</title>
</head>
<body>
    <h2>Chỉnh sửa câu hỏi - trả lời</h2>
    <form action="${pageContext.request.contextPath}/manage-qa" method="post">
        <input type="hidden" name="id" value="<%= qa.getId() %>">

        <label>Câu hỏi:</label><br>
        <input type="text" name="question" value="<%= qa.getQuestion() %>" required><br><br>

        <label>Từ khóa:</label><br>
        <input type="text" name="key" value="<%= qa.getKey() %>" required><br><br>

        <label>Trả lời:</label><br>
        <textarea name="answer" rows="4" cols="40" required><%= qa.getAnswer() %></textarea><br><br>

        <button type="submit">Cập nhật</button>
    </form>
    <br>
    <a href="${pageContext.request.contextPath}/manage-qa">← Quay lại danh sách</a>
</body>
</html>

