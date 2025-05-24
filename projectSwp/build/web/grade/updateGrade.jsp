<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head><title>Update Grade</title></head>
<body>
    <h2>Update Grade</h2>

    <c:if test="${empty grade}">
        <p style="color:red">Grade not found!</p>
        <a href="Grade">Back to Grade List</a>
    </c:if>

    <c:if test="${not empty grade}">
        <form method="post" action="Grade">
            <input type="hidden" name="action" value="update" />
            ID (read-only): 
            <input type="number" name="id" value="${grade.id}" readonly /><br/>
            Name: 
            <input type="text" name="name" value="${grade.name}" required /><br/>
            Description: 
            <input type="text" name="description" value="${grade.description}" /><br/>
            Teacher ID: 
            <input type="number" name="teacher_id" value="${grade.teacher_id}" required /><br/>
            <button type="submit">Update Grade</button>
        </form>
    </c:if>

    <br/>
    <a href="Grade">Back to Grade List</a>
</body>
</html>
