<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page import="java.io.InputStream, java.util.Base64" %>
<%@ page import="jakarta.servlet.annotation.MultipartConfig" %>

<html>
<head>
    <title>Add Question</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="assets/css/nice-select.css" />
    <link rel="stylesheet" href="assets/css/style.css" />

    <style>
        .error-msg {
            color: red;
            font-size: 0.875em;
        }
    </style>

    <!-- jQuery + nice-select -->
    <script src="assets/js/vendor/jquery-1.12.4.min.js"></script>
    <script src="assets/js/jquery.nice-select.min.js"></script>
</head>

<body class="bg-light">
    <!-- ✅ Include header đúng chỗ -->
    <jsp:include page="../header.jsp" />

    <div class="container mt-5 mb-5">
        <h2 class="mb-4">Add New Question</h2>

        <form name="questionForm" method="post" action="Question" enctype="multipart/form-data" onsubmit="return validateForm()">
            <input type="hidden" name="action" value="insert" />

            <div class="mb-3">
                <label class="form-label">Question</label>
                <input type="text" class="form-control" name="question" />
                <span id="questionError" class="error-msg"></span>
            </div>

            <div class="mb-3">
                <label class="form-label">Upload Image</label>
                <input type="file" class="form-control" name="image_file" accept="image/*" />
            </div>

            <div class="mb-3">
                <label class="form-label">Lesson</label>
                <select name="lesson_id" class="form-select">
                    <option value="">-- Select Lesson --</option>
                    <c:forEach var="l" items="${les}">
                        <option value="${l.id}">${l.name}</option>
                    </c:forEach>
                </select>
                <span id="lessonError" class="error-msg"></span>
            </div>

            <button type="submit" class="btn btn-primary">Add Question</button>
            <a href="Question" class="btn btn-secondary ms-2">Back to Question List</a>
        </form>
    </div>

    <!-- ✅ Include footer đúng chỗ -->
    <jsp:include page="../footer.jsp" />

    <!-- ✅ Re-apply nice-select after DOM ready -->
    <script>
        $(document).ready(function () {
            $('select').niceSelect();
        });

        function validateForm() {
            let valid = true;

            const form = document.forms["questionForm"];
            const questionInput = form["question"];
            const lessonSelect = form["lesson_id"];
            const questionError = document.getElementById("questionError");
            const lessonError = document.getElementById("lessonError");

            questionError.textContent = "";
            lessonError.textContent = "";

            if (questionInput.value.trim() === "") {
                questionError.textContent = "You must input the question.";
                valid = false;
            }

            if (lessonSelect.value === "") {
                lessonError.textContent = "You must select a lesson.";
                valid = false;
            }

            return valid;
        }
    </script>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
