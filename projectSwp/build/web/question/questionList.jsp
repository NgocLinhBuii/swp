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
                <th>Image</th>
                <th>Lesson Name</th>
                <th>Actions</th>
            </tr>
            <c:forEach var="q" items="${questionList}">
                <tr>
                    <td>${q.id}</td>
                    <td>${q.question}</td>
                    <td>
                        <c:forEach var="img" items="${images}">
                            <c:if test="${img.id == q.image_id}">
                                <img  src="${pageContext.request.contextPath}/${not empty img.image_data ? img.image_data : 'assets/img/question/cauhoi.jpg'}"
                                     alt="Ảnh câu hỏi" width="100" height="100" class="img-thumbnail" />
                            </c:if>
                        </c:forEach>
                    </td>

                    <td>
                        <c:forEach var="l" items="${les}">
                            <c:if test="${q.lesson_id eq l.id}">
                                ${l.name}
                            </c:if>
                        </c:forEach>
                    </td>
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

