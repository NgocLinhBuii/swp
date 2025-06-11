<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Test Questions</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nice-select.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    
    <style>
        .question-container {
            padding: 15px;
            border-left: 4px solid #6c757d;
            margin-bottom: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        .selected-question {
            border-left-color: #28a745;
            background-color: rgba(40, 167, 69, 0.1);
        }
        .remove-btn {
            position: absolute;
            right: 10px;
            top: 10px;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Include header -->
    <jsp:include page="/header.jsp" />
    
    <div class="container mt-5 mb-5">
        <div class="row">
            <div class="col-lg-10 mx-auto">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/test">Tests</a></li>
                        <li class="breadcrumb-item active">Manage Questions for ${test.name}</li>
                    </ol>
                </nav>
                
                <div class="card shadow mb-4">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0">Manage Questions for "${test.name}"</h3>
                    </div>
                    <div class="card-body">
                        <c:if test="${param.success eq 'true'}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle"></i> 
                                <c:choose>
                                    <c:when test="${not empty param.message}">
                                        ${param.message}
                                    </c:when>
                                    <c:otherwise>
                                        Operation completed successfully!
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
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="card h-100">
                                    <div class="card-header bg-success text-white">
                                        <h4 class="mb-0">Assigned Questions (${assignedQuestions.size()})</h4>
                                    </div>
                                    <div class="card-body p-0">
                                        <div class="list-group list-group-flush">
                                            <c:choose>
                                                <c:when test="${empty assignedQuestions}">
                                                    <div class="list-group-item text-center py-4">
                                                        <i class="fas fa-info-circle me-2"></i>
                                                        No questions assigned to this test yet
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div style="max-height: 500px; overflow-y: auto;">
                                                        <c:forEach var="question" items="${assignedQuestions}">
                                                            <div class="list-group-item position-relative">
                                                                <strong>${question.question}</strong>
                                                                <a href="${pageContext.request.contextPath}/test?action=removeQuestion&testId=${test.id}&questionId=${question.id}" 
                                                                   class="btn btn-sm btn-danger remove-btn" 
                                                                   onclick="return confirm('Are you sure you want to remove this question from the test?')">
                                                                    <i class="fas fa-times"></i>
                                                                </a>
                                                                <c:if test="${question.image_id > 0}">
                                                                    <div class="mt-2">
                                                                        <span class="badge bg-info">Has Image</span>
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="card h-100">
                                    <div class="card-header bg-primary text-white">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h4 class="mb-0">Available Questions (${availableQuestions.size()})</h4>
                                        </div>
                                    </div>
                                    <div class="card-body p-0">
                                        <form action="${pageContext.request.contextPath}/test" method="post">
                                            <input type="hidden" name="action" value="addQuestions" />
                                            <input type="hidden" name="testId" value="${test.id}" />
                                            
                                            <div class="p-3">
                                                <div class="input-group mb-3">
                                                    <input type="text" class="form-control" id="searchInput" placeholder="Search questions..." />
                                                    <button class="btn btn-outline-secondary" type="button">
                                                        <i class="fas fa-search"></i>
                                                    </button>
                                                </div>
                                                
                                                <div class="mb-2">
                                                    <label class="form-label mb-1">Filter by:</label>
                                                    <select class="form-select form-select-sm" id="lessonFilter">
                                                        <option value="all">All Lessons</option>
                                                        <!-- Add lesson options dynamically if needed -->
                                                    </select>
                                                </div>
                                            </div>
                                            
                                            <div style="max-height: 400px; overflow-y: auto;">
                                                <c:choose>
                                                    <c:when test="${empty availableQuestions}">
                                                        <div class="text-center py-4">
                                                            <i class="fas fa-info-circle me-2"></i>
                                                            No additional questions available
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="list-group list-group-flush" id="questionsList">
                                                            <c:forEach var="question" items="${availableQuestions}">
                                                                <div class="list-group-item">
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" 
                                                                               name="selectedQuestions" value="${question.id}" 
                                                                               id="question${question.id}">
                                                                        <label class="form-check-label" for="question${question.id}">
                                                                            ${question.question}
                                                                        </label>
                                                                    </div>
                                                                    <c:if test="${question.image_id > 0}">
                                                                        <div class="mt-1 ms-4">
                                                                            <span class="badge bg-info">Has Image</span>
                                                                        </div>
                                                                    </c:if>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            
                                            <div class="p-3 d-flex justify-content-between border-top">
                                                <button type="button" class="btn btn-outline-secondary" id="selectAllBtn">
                                                    <i class="fas fa-check-square"></i> Select All
                                                </button>
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-plus"></i> Add Selected Questions
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between mt-4">
                            <a href="${pageContext.request.contextPath}/test" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Back to Tests
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Include footer -->
    <jsp:include page="/footer.jsp" />
    
    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/vendor/jquery-1.12.4.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Search functionality
            $("#searchInput").on("keyup", function() {
                var value = $(this).val().toLowerCase();
                $("#questionsList .list-group-item").filter(function() {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
            });
            
            // Select all button
            let allSelected = false;
            $("#selectAllBtn").click(function() {
                const checkboxes = $("input[name='selectedQuestions']");
                allSelected = !allSelected;
                checkboxes.prop("checked", allSelected);
                
                $(this).html(allSelected ? 
                    '<i class="fas fa-square"></i> Deselect All' : 
                    '<i class="fas fa-check-square"></i> Select All');
            });
        });
    </script>
</body>
</html> 