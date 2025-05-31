<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm bài học</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm">
                    <div class="card-header bg-success text-white text-center">
                        <h5 class="mb-0">Thêm Bài Học Mới</h5>
                    </div>
                    <div class="card-body">
                        <form id="lessonForm" action="LessonURL" method="post" onsubmit="return validateForm()">
                            <input type="hidden" name="action" value="insert">

                            <div class="mb-3">
                                <label for="name" class="form-label">Tên bài học</label>
                                <input type="text" class="form-control" id="name" name="name">
                                <div id="nameError" class="text-danger"></div>
                            </div>

                            <div class="mb-3">
                                <label for="content" class="form-label">Nội dung</label>
                                <textarea class="form-control" id="content" name="content" rows="4"></textarea>
                                <div id="contentError" class="text-danger"></div>
                            </div>

                            <div class="mb-3">
                                <label for="chapter_id" class="form-label">Chapter</label>
                                <select class="form-select" id="chapter_id" name="chapter_id">
                                    <option value="">-- Chọn Chapter --</option>
                                    <c:forEach items="${chapterName}" var="chapter">
                                        <option value="${chapter.id}">${chapter.name}</option>
                                    </c:forEach>
                                </select>
                                <div id="chapterError" class="text-danger"></div>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-success">Thêm bài học</button>
                                <a href="LessonURL" class="btn btn-outline-secondary">Quay lại danh sách</a>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>
<script>
function validateForm() {
    let isValid = true;

    // Clear previous errors
    document.getElementById("nameError").innerText = "";
    document.getElementById("contentError").innerText = "";
    document.getElementById("chapterError").innerText = "";

    // Get form values
    const name = document.getElementById("name").value.trim();
    const content = document.getElementById("content").value.trim();
    const chapter = document.getElementById("chapter_id").value;

    // Validate name
    if (name === "") {
        document.getElementById("nameError").innerText = "Vui lòng nhập tên bài học.";
        isValid = false;
    }

    // Validate content
    if (content === "") {
        document.getElementById("contentError").innerText = "Vui lòng nhập nội dung.";
        isValid = false;
    }

    // Validate chapter
    if (chapter === "") {
        document.getElementById("chapterError").innerText = "Vui lòng chọn một chapter.";
        isValid = false;
    }

    return isValid;
}
</script>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>
