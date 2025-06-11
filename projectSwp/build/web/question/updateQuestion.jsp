<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Update Question</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../assets/css/nice-select.css">
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <jsp:include page="../header.jsp" />

    <style>
        .error-msg {
            color: red;
            font-size: 0.875em;
        }
        .option-container {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 10px;
            position: relative;
        }
        .remove-option {
            position: absolute;
            top: 10px;
            right: 10px;
            color: #dc3545;
            cursor: pointer;
        }
        .card-header {
            background-color: #f0f0f0;
        }
        .correct-option {
            border-left: 4px solid #28a745;
        }
        .cursor-pointer {
            cursor: pointer;
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
            const optionError = document.getElementById("optionError");

            questionError.textContent = "";
            lessonError.textContent = "";
            optionError.textContent = "";

            if (questionInput.value.trim() === "") {
                questionError.textContent = "You must input the question.";
                valid = false;
            }

            if (lessonSelect.value === "") {
                lessonError.textContent = "You must select a lesson.";
                valid = false;
            }

            // Validate at least 2 options and one marked as correct
            const correctOptionSelected = document.querySelector('input[name="correctOption"]:checked');
            if (!correctOptionSelected) {
                optionError.textContent = "You must select one correct answer.";
                valid = false;
            }

            // Validate that all option fields have content
            let emptyOptions = false;
            document.querySelectorAll('textarea[name^="option_"]').forEach(option => {
                if (option.value.trim() === '') {
                    emptyOptions = true;
                }
            });

            if (emptyOptions) {
                optionError.textContent = "All options must have content.";
                valid = false;
            }

            return valid;
        }
    </script>
</head>

<body class="bg-light">
<div class="container mt-5 mb-5">
    <div class="row">
        <div class="col-lg-8 mx-auto">
            <div class="card shadow">
                <div class="card-header">
                    <h2 class="mb-0">Update Question</h2>
                </div>
                <div class="card-body">
                    <form name="updateForm" method="post" action="Question" enctype="multipart/form-data" onsubmit="return validateForm()">
                        <input type="hidden" name="action" value="update" />
                        <input type="hidden" name="id" value="${question.id}" />
                        <input type="hidden" name="optionsCount" id="optionsCount" value="${options.size() > 0 ? options.size() : 2}" />

                        <div class="mb-3">
                            <label class="form-label">Question</label>
                            <textarea class="form-control" name="question" rows="3" required>${question.question}</textarea>
                            <span id="questionError" class="error-msg"></span>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Upload New Image (optional)</label>
                            <input type="file" name="image_file" class="form-control" accept="image/*" />
                            <c:if test="${question.image_id > 0}">
                                <div class="mt-2">
                                    <p class="text-muted small">Current image:</p>
                                    <img src="${pageContext.request.contextPath}/image/${question.image_id}" 
                                         alt="Question Image" class="img-fluid img-thumbnail" style="max-height: 200px;">
                                </div>
                            </c:if>
                            <div class="mt-2" id="imagePreview"></div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Lesson</label>
                            <select name="lesson_id" class="form-select" required>
                                <option value="">-- Select Lesson --</option>
                                <c:forEach var="l" items="${les}">
                                    <option value="${l.id}" <c:if test="${l.id == question.lesson_id}">selected</c:if>>${l.name}</option>
                                </c:forEach>
                            </select>
                            <span id="lessonError" class="error-msg"></span>
                        </div>

                        <!-- Options Section -->
                        <div class="card mb-4">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Answer Options</h5>
                                <button type="button" class="btn btn-sm btn-outline-primary" onclick="addOption()">
                                    <i class="fas fa-plus"></i> Add Option
                                </button>
                            </div>
                            <div class="card-body" id="optionsContainer">
                                <c:choose>
                                    <c:when test="${not empty options}">
                                        <!-- Existing options -->
                                        <c:forEach var="option" items="${options}" varStatus="status">
                                            <div class="option-container ${option.is_correct ? 'correct-option' : ''}" id="option-${status.index + 1}">
                                                <div class="mb-2">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio" name="correctOption" 
                                                               value="${status.index + 1}" id="correctOption${status.index + 1}" 
                                                               ${option.is_correct ? 'checked' : ''} required>
                                                        <label class="form-check-label fw-bold" for="correctOption${status.index + 1}">
                                                            Mark as correct answer
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="mb-0">
                                                    <textarea class="form-control" name="option_${status.index + 1}" 
                                                              rows="2" placeholder="Enter option content" required>${option.content}</textarea>
                                                </div>
                                                <c:if test="${status.index > 0}">
                                                    <span class="remove-option" onclick="removeOption(${status.index + 1})">
                                                        <i class="fas fa-times-circle"></i>
                                                    </span>
                                                </c:if>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Default options if none exist -->
                                        <div class="option-container" id="option-1">
                                            <div class="mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="correctOption" value="1" id="correctOption1" checked required>
                                                    <label class="form-check-label fw-bold" for="correctOption1">
                                                        Mark as correct answer
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="mb-0">
                                                <textarea class="form-control" name="option_1" rows="2" placeholder="Enter option content" required></textarea>
                                            </div>
                                        </div>
                                        
                                        <div class="option-container" id="option-2">
                                            <div class="mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="correctOption" value="2" id="correctOption2">
                                                    <label class="form-check-label fw-bold" for="correctOption2">
                                                        Mark as correct answer
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="mb-0">
                                                <textarea class="form-control" name="option_2" rows="2" placeholder="Enter option content" required></textarea>
                                            </div>
                                            <span class="remove-option" onclick="removeOption(2)">
                                                <i class="fas fa-times-circle"></i>
                                            </span>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <span id="optionError" class="error-msg d-block mb-3"></span>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="Question" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Back to Question List
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Update Question
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />

<!-- Scripts -->
<script src="../assets/js/vendor/jquery-1.12.4.min.js"></script>
<script src="../assets/js/jquery.nice-select.min.js"></script>
<script>
    $(document).ready(function () {
        $('select').niceSelect();
        
        // Image preview
        $('input[name="image_file"]').on('change', function() {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    $('#imagePreview').html(`<img src="${e.target.result}" class="img-fluid img-thumbnail" style="max-height: 200px">`);
                }
                reader.readAsDataURL(file);
            }
        });
        
        // Update initial styling
        updateOptionStyles();
    });
    
    // Add new option
    function addOption() {
        const optionsCount = parseInt(document.getElementById('optionsCount').value) + 1;
        if (optionsCount > 10) {
            alert('Maximum 10 options allowed');
            return;
        }
        
        document.getElementById('optionsCount').value = optionsCount;
        
        const optionHtml = `
            <div class="option-container" id="option-${optionsCount}">
                <div class="mb-2">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="correctOption" value="${optionsCount}" id="correctOption${optionsCount}">
                        <label class="form-check-label fw-bold" for="correctOption${optionsCount}">
                            Mark as correct answer
                        </label>
                    </div>
                </div>
                <div class="mb-0">
                    <textarea class="form-control" name="option_${optionsCount}" rows="2" placeholder="Enter option content" required></textarea>
                </div>
                <span class="remove-option" onclick="removeOption(${optionsCount})">
                    <i class="fas fa-times-circle"></i>
                </span>
            </div>
        `;
        
        document.getElementById('optionsContainer').insertAdjacentHTML('beforeend', optionHtml);
        updateOptionStyles();
    }
    
    // Remove option
    function removeOption(optionId) {
        // At least 2 options required
        const optionsCount = parseInt(document.getElementById('optionsCount').value);
        if (optionsCount <= 2) {
            alert('At least 2 options are required');
            return;
        }
        
        const element = document.getElementById(`option-${optionId}`);
        
        // If we're removing the correct option, reset selection
        const radioButton = element.querySelector(`input[name=correctOption][value="${optionId}"]`);
        if (radioButton && radioButton.checked) {
            document.getElementById('correctOption1').checked = true;
        }
        
        element.remove();
        updateOptionStyles();
    }
    
    // Highlight options when selected as correct
    function updateOptionStyles() {
        document.querySelectorAll('.option-container').forEach(container => {
            container.classList.remove('correct-option');
        });
        
        const selectedOption = document.querySelector('input[name="correctOption"]:checked');
        if (selectedOption) {
            const containerId = `option-${selectedOption.value}`;
            document.getElementById(containerId).classList.add('correct-option');
        }
    }
    
    // Set up event listener for radio buttons
    document.addEventListener('click', function(e) {
        if (e.target && e.target.name === 'correctOption') {
            updateOptionStyles();
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
