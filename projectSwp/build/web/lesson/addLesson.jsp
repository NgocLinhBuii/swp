<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm bài học</title>
</head>
<body>
    <h2>Thêm bài học mới</h2>

    <form action="LessonURL" method="post">
        <input type="hidden" name="action" value="insert">
        <p>Tên: <input type="text" name="name" required></p>
        <p>Nội dung: <textarea name="content" rows="5" cols="30" required></textarea></p>
        <p>Chapter ID: <input type="number" name="chapter_id" required></p>
        <button type="submit">Thêm</button>
    </form>

    <p><a href="LessonURL">Quay lại danh sách</a></p>
</body>
</html>
