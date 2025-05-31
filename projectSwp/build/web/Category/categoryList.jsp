<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Category List</title>
</head>
<body>
<h2>Category List</h2>

<form method="get" action="category">
    Search by name: <input type="text" name="name" />
    <button type="submit">Search</button>
</form>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Number of Questions</th>
        <th>Duration (minutes)</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="cate" items="${categoryList}">
        <tr>
            <td>${cate.id}</td>
            <td>${cate.name}</td>
            <td>${cate.num_question}</td>
            <td>${cate.duration}</td>
            <td>
                <a href="category?action=updateForm&id=${cate.id}">Update</a> |
                <a href="category?action=delete&id=${cate.id}" onclick="return confirm('Are you sure to delete category ID ${cate.id}?');" style="color:red">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>

<br/>
<a href="category?action=addForm">Add new Category</a>

<c:if test="${not empty message}">
    <p style="color:green">${message}</p>
</c:if>

</body>
</html>
