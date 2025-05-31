<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cập nhật bài học</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm">
                    <div class="card-header bg-warning text-dark text-center">
                        <h5 class="mb-0">Cập nhật bài học</h5>
                    </div>
                    <div class="card-body">
                        <form action="LessonURL" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${lesson.id}">

                            <div class="mb-3">
                                <label for="name" class="form-label">Tên bài học</label>
                                <input type="text" id="name" name="name" class="form-control" value="${lesson.name}" required>
                            </div>

                            <div class="mb-3">
                                <label for="content" class="form-label">Nội dung</label>
                                <textarea id="content" name="content" class="form-control" rows="4" required>${lesson.content}</textarea>
                            </div>

                            <div class="mb-3">
                                <label for="chapter_id" class="form-label">Chapter</label>
                                <select name="chapter_id" id="chapter_id" class="form-select" required>
                                    <c:forEach items="${chapter}" var="chap">
                                        <option value="${chap.id}" ${lesson.chapter_id == chap.id ? 'selected' : ''}>
                                            ${chap.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-warning">Cập nhật</button>
                                <a href="LessonURL" class="btn btn-outline-secondary">Quay lại danh sách</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
