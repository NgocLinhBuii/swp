<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Update Question</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../assets/css/nice-select.css">
    <link rel="stylesheet" href="../assets/css/style.css">

    <jsp:include page="../header.jsp" />

    <style>
        .error-msg {
            color: red;
            font-size: 0.875em;
        }
    </style>

    <script>
        function validateForm() {
            let valid = true;

            const form = document.forms["updateForm"];
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
</head>

<body class="bg-light">
<div class="container mt-5 mb-5">
    <h2 class="mb-4">Update Question</h2>

    <form name="updateForm" method="post" action="Question" enctype="multipart/form-data" onsubmit="return validateForm()">
        <input type="hidden" name="action" value="update" />

        <div class="mb-3">
            <label class="form-label">ID</label>
            <input type="number" name="id" class="form-control" value="${question.id}" readonly />
        </div>

        <div class="mb-3">
            <label class="form-label">Question</label>
            <input type="text" name="question" class="form-control" value="${question.question}" />
            <span id="questionError" class="error-msg"></span>
        </div>

        <div class="mb-3">
            <label class="form-label">Upload New Image (optional)</label>
            <input type="file" name="image_file" class="form-control" accept="image/*" />
        </div>

        <div class="mb-3">
            <label class="form-label">Lesson</label>
            <select name="lesson_id" class="form-select">
                <option value="">-- Select Lesson --</option>
                <c:forEach var="l" items="${les}">
                    <option value="${l.id}" <c:if test="${l.id == question.lesson_id}">selected</c:if>>${l.name}</option>
                </c:forEach>
            </select>
            <span id="lessonError" class="error-msg"></span>
        </div>

        <button type="submit" class="btn btn-primary">Update Question</button>
        <a href="Question" class="btn btn-secondary ms-2">Back to Question List</a>
    </form>
</div>

<jsp:include page="../footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
