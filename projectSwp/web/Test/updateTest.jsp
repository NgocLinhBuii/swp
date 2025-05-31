<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Sửa Test</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f9f9f9;
        }

        h3 {
            color: #333;
            border-bottom: 2px solid #007BFF;
            padding-bottom: 5px;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
            max-width: 400px;
        }

        input[type="text"], select {
            width: 100%;
            padding: 8px;
            margin: 6px 0 12px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="checkbox"] {
            margin-bottom: 12px;
        }

        input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 16px;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        a {
            text-decoration: none;
            color: #007BFF;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h3>Sửa Test</h3>

<form action="${pageContext.request.contextPath}/test" method="post">
    <input type="hidden" name="action" value="update"/>
    <input type="hidden" name="id" value="${test.id}"/>
    Name: <input type="text" name="name" value="${test.name}" required/><br/>
    Description: <input type="text" name="description" value="${test.description}" required/><br/>
    Practice: 
    <input type="checkbox" name="practice" value="true" 
        <c:if test="${test.is_practice}">checked</c:if> /><br/>
    Category:
    <select name="categoryId" required>
        <c:forEach var="entry" items="${categoryMap}">
            <option value="${entry.key}" 
                <c:if test="${test.category_id == entry.key}">selected</c:if>>
                ${entry.value}
            </option>
        </c:forEach>
    </select><br/>
    <input type="submit" value="Cập nhật"/>
</form>

<br/>
<a href="${pageContext.request.contextPath}/test">Quay lại danh sách</a>

</body>
</html>
