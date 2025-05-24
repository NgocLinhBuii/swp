<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách bài học</title>
</head>
<body>
    <h2>Danh sách bài học</h2>

    <form method="get" action="LessonURL">
        <input type="text" name="name" placeholder="Tìm theo tên">
        <button type="submit">Tìm</button>
    </form>

    <c:if test="${not empty message}">
        <p style="color:green;">${message}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>

    <a href="LessonURL?action=addForm">Thêm bài học mới</a>
    <table border="1" cellpadding="5">
        <tr>
            <th>ID</th>
            <th>Tên</th>
            <th>Nội dung</th>
            <th>Chapter name</th>
            <th>Hành động</th>
        </tr>
        <c:forEach var="lesson" items="${lessonList}">
            <tr>
                <td>${lesson.id}</td>
                <td>${lesson.name}</td>
                <td>${lesson.content}</td>
                <td>
                    <c:forEach var="chap" items="${chapter}">
                        <c:if test="${lesson.chapter_id eq chap.id}">
                           " ${chap.name}"
                        </c:if>
                    </c:forEach>
                </td>
                <td>
                    <a href="LessonURL?action=updateForm&id=${lesson.id}">Sửa</a> |
                    <a href="LessonURL?action=delete&id=${lesson.id}" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
