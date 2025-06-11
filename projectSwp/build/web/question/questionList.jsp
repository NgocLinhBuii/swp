<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Question List</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="assets/css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <style>
        th, td {
            vertical-align: middle;
        }
        img.img-thumbnail {
            object-fit: cover;
        }
        .badge-success {
            background-color: #28a745;
        }
        .badge-danger {
            background-color: #dc3545;
        }
        .options-preview {
            max-height: 100px;
            overflow-y: auto;
            font-size: 0.85em;
        }
        .option-item {
            border-left: 3px solid #dee2e6;
            padding-left: 10px;
            margin-bottom: 5px;
            color: #666;
        }
        .correct-option {
            border-left-color: #28a745;
            font-weight: bold;
            color: #333;
        }
        .view-options {
            cursor: pointer;
            color: #007bff;
        }
        .view-options:hover {
            text-decoration: underline;
        }
        .action-buttons {
            white-space: nowrap;
        }
        .search-bar {
            max-width: 450px;
        }
    </style>
</head>

<body class="bg-light">
    <!-- Include header -->
    <jsp:include page="../header.jsp" />

    <div class="container-fluid mt-4 mb-5">
        <div class="row">
            <div class="col-lg-11 mx-auto">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2>Question Bank</h2>
                    <a href="Question?action=addForm" class="btn btn-success btn-lg">
                        <i class="fas fa-plus"></i> Add New Question
                    </a>
                </div>

                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <form method="get" action="Question" class="row g-3 flex-grow-1">
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <input type="text" name="question" class="form-control" placeholder="Search by question text..." value="${param.question}" />
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-search"></i> Search
                                        </button>
                                    </div>
                                </div>
                            </form>
                            <a href="Question?action=addForm" class="btn btn-success ms-2">
                                <i class="fas fa-plus-circle"></i> Create Question
                            </a>
                        </div>
                    </div>
                </div>

                <c:if test="${param.success eq 'true'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> 
                        <c:choose>
                            <c:when test="${not empty param.message}">
                                ${param.message}
                            </c:when>
                            <c:otherwise>
                                Question saved successfully!
                            </c:otherwise>
                        </c:choose>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <c:if test="${not empty error || not empty param.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> 
                        <c:choose>
                            <c:when test="${not empty param.error}">
                                ${param.error}
                            </c:when>
                            <c:otherwise>
                                ${error}
                            </c:otherwise>
                        </c:choose>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <div class="card shadow">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th width="5%">ID</th>
                                    <th width="30%">Question</th>
                                    <th width="20%">Answer Options</th>
                                    <th width="15%">Image</th>
                                    <th width="15%">Lesson</th>
                                    <th width="15%">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="q" items="${questionList}">
                                    <tr>
                                        <td class="text-center">${q.id}</td>
                                        <td>${q.question}</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary" 
                                                    onclick="loadOptions(${q.id})" 
                                                    data-bs-toggle="modal" 
                                                    data-bs-target="#optionsModal">
                                                <i class="fas fa-list"></i> View Options
                                            </button>
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${q.image_id > 0}">
                                                    <a href="${pageContext.request.contextPath}/image/${q.image_id}" target="_blank">
                                                        <img src="${pageContext.request.contextPath}/image/${q.image_id}" alt="Question Image" width="80" height="80" class="img-thumbnail">
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">No image</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:forEach var="l" items="${les}">
                                                <c:if test="${q.lesson_id eq l.id}">
                                                    ${l.name}
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="Question?action=updateForm&id=${q.id}" class="btn btn-sm btn-warning me-1">
                                                    <i class="fas fa-edit"></i> Edit
                                                </a>
                                                <a href="Question?action=delete&id=${q.id}" class="btn btn-sm btn-danger" 
                                                   onclick="return confirm('Are you sure you want to delete this question? This action cannot be undone.');">
                                                    <i class="fas fa-trash-alt"></i> Delete
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                
                                <c:if test="${empty questionList}">
                                    <tr>
                                        <td colspan="6" class="text-center py-4">
                                            <div class="text-muted">
                                                <i class="fas fa-info-circle me-2"></i>No questions found
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Options Modal -->
    <div class="modal fade" id="optionsModal" tabindex="-1" aria-labelledby="optionsModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="optionsModalLabel">Question Options</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="optionsModalBody">
                    <div class="text-center">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                        <p>Loading options...</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Include footer -->
    <jsp:include page="../footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Function to load options for a question
        function loadOptions(questionId) {
            const modalBody = document.getElementById('optionsModalBody');
            
            // Show loading spinner
            modalBody.innerHTML = `
                <div class="text-center">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p>Loading options...</p>
                </div>
            `;
            
            // Fetch options from server (in a real app)
            // Here we're simulating with a setTimeout
            fetch('${pageContext.request.contextPath}/QuestionOption?action=getByQuestion&id=' + questionId)
                .then(response => response.json())
                .then(data => {
                    let optionsHtml = '<div class="list-group">';
                    
                    if (data && data.length > 0) {
                        data.forEach((option, index) => {
                            const isCorrect = option.is_correct;
                            optionsHtml += `
                                <div class="list-group-item d-flex align-items-center ${isCorrect ? 'list-group-item-success' : ''}">
                                    <span class="me-3">${index + 1}.</span>
                                    <div>
                                        <div>${option.content}</div>
                                        ${isCorrect ? '<div class="badge bg-success mt-1">Correct Answer</div>' : ''}
                                    </div>
                                </div>
                            `;
                        });
                    } else {
                        optionsHtml += `
                            <div class="list-group-item text-center">
                                <p class="mb-0 text-muted">No options found for this question</p>
                            </div>
                        `;
                    }
                    
                    optionsHtml += '</div>';
                    modalBody.innerHTML = optionsHtml;
                })
                .catch(error => {
                    console.error('Error fetching options:', error);
                    modalBody.innerHTML = `
                        <div class="alert alert-danger">
                            Error loading options. This is likely because the AJAX endpoint isn't implemented yet.
                            In a real application, you would fetch the options from the server.
                        </div>
                        <div class="mt-3">
                            <strong>To test this feature:</strong>
                            <ol class="mt-2">
                                <li>Edit a question to see its options</li>
                                <li>Implement a QuestionOption servlet to handle AJAX requests</li>
                            </ol>
                        </div>
                    `;
                });
        }
    </script>
</body>
</html>
