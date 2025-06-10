<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách câu hỏi - trả lời</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }

        h2 {
            margin-bottom: 10px;
        }

        a {
            text-decoration: none;
            color: #6c63ff;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #999;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #f9f9f9;
        }

        .empty-msg {
            color: gray;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>Danh sách câu hỏi - trả lời</h2>
    <a href="qa/add.jsp">➕ Thêm mới</a>
    <br><br>

    <c:if test="${not empty list}">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Câu hỏi</th>
                    <th>Từ khóa</th>
                    <th>Trả lời</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="qa" items="${list}">
                    <tr>
                        <td>${qa.id}</td>
                        <td>${qa.question}</td>
                        <td>${qa.key}</td>
                        <td>${qa.answer}</td>
                        <td>
                            <a href="manage-qa?action=edit&id=${qa.id}">✏️ Sửa</a> |
                            <a href="manage-qa?action=delete&id=${qa.id}" onclick="return confirm('Bạn có chắc muốn xoá?')">🗑️ Xoá</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty list}">
        <p class="empty-msg">Không có câu hỏi nào trong hệ thống.</p>
    </c:if>
</body>
</html>
