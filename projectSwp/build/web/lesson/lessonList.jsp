<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách bài học</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light p-4">
    <div class="container">
        <h2 class="mb-4 text-primary">Danh sách bài học</h2>

        <!-- Search Form -->
        <form method="get" action="LessonURL" class="row g-2 mb-3">
            <div class="col-auto">
                <input type="text" name="name" class="form-control" placeholder="Tìm theo tên">
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-primary">Tìm</button>
            </div>
        </form>

        <!-- Message Alerts -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <!-- Add New Lesson -->
        <div class="mb-3">
            <a href="LessonURL?action=addForm" class="btn btn-success">Thêm bài học mới</a>
        </div>

        <!-- Lesson Table -->
        <table class="table table-bordered table-hover bg-white">
            <thead class="table-primary">
                <tr>
                    <th>ID</th>
                    <th>Tên</th>
                    <th>Nội dung</th>
                    <th>Chapter name</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="lesson" items="${lessonList}">
                    <tr>
                        <td>${lesson.id}</td>
                        <td>${lesson.name}</td>
                        <td>${lesson.content}</td>
                        <td>
                            <c:forEach var="chap" items="${chapter}">
                                <c:if test="${lesson.chapter_id eq chap.id}">
                                    ${chap.name}
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            <a href="LessonURL?action=updateForm&id=${lesson.id}" class="btn btn-sm btn-warning">Sửa</a>
                            <a href="LessonURL?action=delete&id=${lesson.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Bootstrap JS Bundle (optional for dynamic components like modals) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
