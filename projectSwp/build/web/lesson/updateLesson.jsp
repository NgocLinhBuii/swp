<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cập nhật bài học</title>
</head>
<body>
    <h2>Cập nhật bài học</h2>

    <form action="LessonURL" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${lesson.id}">
        <p>Tên: <input type="text" name="name" value="${lesson.name}" required></p>
        <p>Nội dung:
            <textarea name="content" rows="5" cols="30" required>${lesson.content}</textarea>
        </p>
        <p>Chapter ID: <input type="number" name="chapter_id" value="${lesson.chapter_id}" required></p>
        <button type="submit">Cập nhật</button>
    </form>

    <p><a href="LessonURL">Quay lại danh sách</a></p>
</body>
</html>
