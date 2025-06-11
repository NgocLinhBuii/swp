<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Test Management</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nice-select.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <style>
        .badge-success {
            background-color: #28a745;
        }
        .badge-primary {
            background-color: #007bff;
        }
    </style>
</head>

<body class="bg-light">
    <!-- Include header -->
    <jsp:include page="/header.jsp" />

    <div class="container mt-5 mb-5">
        <div class="row">
            <div class="col-lg-10 mx-auto">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0">Test Management</h2>
                    <a href="${pageContext.request.contextPath}/test?action=create" class="btn btn-success btn-lg">
                        <i class="fas fa-plus"></i> Create New Test
                    </a>
                </div>

                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <form method="get" action="${pageContext.request.contextPath}/test" class="row g-3 flex-grow-1">
                                <div class="col-md-4">
                                    <div class="input-group">
                                        <input type="text" name="search" class="form-control" placeholder="Search tests..." value="${param.search}" />
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-search"></i> Search
                                        </button>
                                    </div>
                                </div>
                            </form>
                            <div>
                                <a href="${pageContext.request.contextPath}/test" class="btn btn-outline-secondary me-2">
                                    <i class="fas fa-list"></i> All Tests
                                </a>
                                <a href="${pageContext.request.contextPath}/test?filter=practice" class="btn btn-outline-primary me-2">
                                    <i class="fas fa-graduation-cap"></i> Practice Tests
                                </a>
                                <a href="${pageContext.request.contextPath}/test?filter=exam" class="btn btn-outline-danger">
                                    <i class="fas fa-clock"></i> Exam Tests
                                </a>
                            </div>
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
                                Operation completed successfully!
                            </c:otherwise>
                        </c:choose>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <div class="card shadow">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Type</th>
                                    <th>Category</th>
                                    <th>Questions</th>
                                    <th class="text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="test" items="${testList}">
                                    <tr>
                                        <td>${test.id}</td>
                                        <td>
                                            <strong>${test.name}</strong>
                                        </td>
                                        <td>${test.description}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${test.is_practice}">
                                                    <span class="badge bg-success rounded-pill">Practice</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger rounded-pill">Exam</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${categoryMap[test.category_id]}</td>
                                        <td>
                                            <c:if test="${questionCountMap != null}">
                                                <span class="badge bg-primary rounded-pill">${questionCountMap[test.id]} questions</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <div class="d-flex justify-content-center">
                                                <a href="${pageContext.request.contextPath}/test?action=manage-questions&id=${test.id}" 
                                                   class="btn btn-sm btn-primary me-1" title="Manage Questions">
                                                    <i class="fas fa-question-circle"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/test?action=edit&id=${test.id}" 
                                                   class="btn btn-sm btn-warning me-1" title="Edit Test">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/test?action=delete&id=${test.id}" 
                                                   class="btn btn-sm btn-danger" 
                                                   onclick="return confirm('Are you sure you want to delete this test?')"
                                                   title="Delete Test">
                                                    <i class="fas fa-trash-alt"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                
                                <c:if test="${empty testList}">
                                    <tr>
                                        <td colspan="7" class="text-center py-4">
                                            <div class="text-muted">
                                                <i class="fas fa-info-circle me-2"></i>No tests found
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

    <!-- Include footer -->
    <jsp:include page="/footer.jsp" />

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/vendor/jquery-1.12.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery.nice-select.min.js"></script>
    
    <script>
        $(document).ready(function() {
            $('select').niceSelect();
        });
    </script>
</body>
</html>
