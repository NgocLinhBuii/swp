<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Update Category</title></head>
<body>
<h2>Update Category</h2>

<c:if test="${empty category}">
    <p style="color:red">Category not found!</p>
    <a href="category">Back to Category List</a>
</c:if>

<c:if test="${not empty category}">
    <form method="post" action="category">
        <input type="hidden" name="action" value="update" />
        ID (read-only): <input type="number" name="id" value="${category.id}" readonly /><br/>
        Name: <input type="text" name="name" value="${category.name}" required /><br/>
        Number of Questions: <input type="number" name="num_question" value="${category.num_question}" min="1" required /><br/>
        Duration (minutes): <input type="number" name="duration" value="${category.duration}" min="1" required /><br/>
        <button type="submit">Update Category</button>
    </form>
</c:if>

<br/>
<a href="category">Back to Category List</a>
</body>
</html>
