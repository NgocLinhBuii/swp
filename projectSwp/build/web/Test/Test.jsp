<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh sách Tests</title>
</head>
<body>

<h2>Danh sách Tests</h2>

<c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
</c:if>

<table border="1" cellpadding="5" cellspacing="0">
    <thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Practice</th>
        <th>Category ID</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="test" items="${testList}">
        <tr>
            <td>${test.id}</td>
            <td>${test.name}</td>
            <td>${test.description}</td>
            <td>
                <c:choose>
                    <c:when test="${test.is_practice}">Yes</c:when>
                    <c:otherwise>No</c:otherwise>
                </c:choose>
            </td>
            <td>${test.category_id}</td>
            <td>
                <a href="${pageContext.request.contextPath}/test?action=edit&id=${test.id}">Sửa</a> |
                <a href="${pageContext.request.contextPath}/test?action=delete&id=${test.id}" onclick="return confirm('Bạn chắc chắn muốn xoá?');">Xoá</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<br/>

<a href="${pageContext.request.contextPath}/test?action=create">Thêm mới Test</a>

<br/><br/>

<!-- Form thêm hoặc sửa Test -->
<c:choose>
    <c:when test="${editMode == true}">
        <h3>Sửa Test</h3>
        <form action="${pageContext.request.contextPath}/test" method="post">
            <input type="hidden" name="action" value="update"/>
            <input type="hidden" name="id" value="${test.id}"/>
            Name: <input type="text" name="name" value="${test.name}" required/><br/>
            Description: <input type="text" name="description" value="${test.description}" required/><br/>
            Practice: 
            <input type="checkbox" name="practice" value="true" 
                <c:if test="${test.is_practice}">checked</c:if> /><br/>
            Category ID: <input type="number" name="categoryId" value="${test.category_id}" required/><br/>
            <input type="submit" value="Cập nhật"/>
        </form>
    </c:when>
    <c:otherwise>
        <c:if test="${test != null}">
            <h3>Thêm mới Test</h3>
            <form action="${pageContext.request.contextPath}/test" method="post">
                <input type="hidden" name="action" value="add"/>
                Name: <input type="text" name="name" value="${test.name}" required/><br/>
                Description: <input type="text" name="description" value="${test.description}" required/><br/>
                Practice: <input type="checkbox" name="practice" value="true"/><br/>
                Category ID: <input type="number" name="categoryId" value="${test.category_id}" required/><br/>
                <input type="submit" value="Thêm mới"/>
            </form>
        </c:if>
    </c:otherwise>
</c:choose>

</body>
</html>
