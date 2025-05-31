<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh sách Tests</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f9f9f9;
        }

        h2 {
            color: #333;
            border-bottom: 2px solid #007BFF;
            padding-bottom: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            margin-top: 20px;
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        table th {
            background-color: #007BFF;
            color: white;
        }

        table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        a {
            text-decoration: none;
            color: #007BFF;
        }

        a:hover {
            text-decoration: underline;
        }

        p {
            margin: 10px 0;
            color: red;
        }

        .add-link {
            display: inline-block;
            margin-top: 15px;
            background-color: #007BFF;
            color: white;
            padding: 8px 12px;
            border-radius: 4px;
        }

        .add-link:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<h2>Danh sách Tests</h2>

<c:if test="${not empty error}">
    <p>${error}</p>
</c:if>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Practice</th>
        <th>Category Name</th>
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
            <td>${categoryMap[test.category_id]}</td>
            <td>
                <a href="${pageContext.request.contextPath}/test?action=edit&id=${test.id}">Sửa</a> |
                <a href="${pageContext.request.contextPath}/test?action=delete&id=${test.id}" onclick="return confirm('Bạn chắc chắn muốn xoá?');">Xoá</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<a class="add-link" href="${pageContext.request.contextPath}/test?action=create">Thêm mới Test</a>

</body>
</html>
