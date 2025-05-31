<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Add Question</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        .error-msg {
            color: red;
            font-size: 0.875em;
        }
    </style>

    <script>
        function validateForm() {
            let valid = true;

            const form = document.forms["questionForm"];
            const questionInput = form["question"];
            const lessonSelect = form["lesson_id"];
            const questionError = document.getElementById("questionError");
            const lessonError = document.getElementById("lessonError");

            // Reset error messages
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
<body>
<div class="container mt-5">
    <h2 class="mb-4">Add New Question</h2>
    
    <form name="questionForm" method="post" action="Question" onsubmit="return validateForm()">
        <input type="hidden" name="action" value="insert" />

        <div class="mb-3">
            <label class="form-label">Question</label>
            <input type="text" class="form-control" name="question" />
            <span id="questionError" class="error-msg"></span>
        </div>

        <div class="mb-3">
            <label class="form-label">Image ID</label>
            <input type="number" class="form-control" name="image_id" />
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
