<%-- 
    Document   : addQuestion
    Created on : May 21, 2025, 1:43:43 PM
    Author     : ADMIN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Add Question</title></head>
<body>
<h2>Add New Question</h2>
<form method="post" action="Question">
    <input type="hidden" name="action" value="insert" />
    ID: <input type="number" name="id" required /><br/>
    Question: <input type="text" name="question" required /><br/>
    Image ID: <input type="number" name="image_id" /><br/>
    Lesson ID: <input type="number" name="lesson_id" required /><br/>
    <button type="submit">Add Question</button>
</form>
<br/>
<a href="Question">Back to Question List</a>
</body>
</html>


