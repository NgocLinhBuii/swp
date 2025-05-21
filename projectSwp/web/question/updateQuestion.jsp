<%-- 
    Document   : updateQuestion
    Created on : May 21, 2025, 1:45:37 PM
    Author     : ADMIN
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Update Question</title></head>
<body>
<h2>Update Question</h2>

<c:if test="${not empty question}">
    <form method="post" action="Question">
        <input type="hidden" name="action" value="update" />
        ID: <input type="number" name="id" value="${question.id}" readonly /><br/>
        Question: <input type="text" name="question" value="${question.question}" required /><br/>
        Image ID: <input type="number" name="image_id" value="${question.image_id}" /><br/>
        Lesson ID: <input type="number" name="lesson_id" value="${question.lesson_id}" required /><br/>
        <button type="submit">Update</button>
    </form>
</c:if>

<br/>
<a href="Question">Back to Question List</a>
</body>
</html>

