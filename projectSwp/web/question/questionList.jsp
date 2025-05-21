<%-- 
    Document   : questionList
    Created on : May 21, 2025, 1:34:58 PM
    Author     : ADMIN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head><title>Question List</title></head>
    <body>
        <h2>Question List</h2>

        <form method="get" action="Question">
            Search by question: <input type="text" name="question" />
            <button type="submit">Search</button>
        </form>



        <table border="1" cellpadding="5">
            <tr>
                <th>ID</th>
                <th>Question</th>
                <th>Image ID</th>
                <th>Lesson ID</th>
                <th>Actions</th>
            </tr>
            <c:forEach var="q" items="${questionList}">
                <tr>
                    <td>${q.id}</td>
                    <td>${q.question}</td>
                    <td>${q.image_id}</td>
                    <td>${q.lesson_id}</td>
                    <td>
                        <a href="Question?action=updateForm&id=${q.id}">Edit</a> |
                        <a href="Question?action=delete&id=${q.id}" onclick="return confirm('Are you sure?');">Delete</a>
                    </td>
                </tr>
            </c:forEach>

        </table>
        <br/><br/>
        <a href="Question?action=addForm">Add New Question</a>
    </body>
</html>

