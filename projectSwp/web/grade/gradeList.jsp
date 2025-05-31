<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
    <head>
        <title>Grade List</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="mb-4">Grade List</h2>

            <form method="get" action="../Grade" class="row g-3 mb-3">
                <div class="col-auto">
                    <input type="text" name="name" class="form-control" placeholder="Search by name" />
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary mb-3">Search</button>
                </div>
            </form>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <table class="table table-bordered table-striped align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Teacher Name</th>  
                        <th>Actions</th>              
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="gra" items="${requestScope.gradeList}">
                        <tr>
                            <td>${gra.id}</td>
                            <td>${gra.name}</td>
                            <td>${gra.description}</td>
                            <td>
                                <c:forEach var="acc" items="${accounts}">
                                    <c:if test="${acc.id eq gra.teacher_id}">
                                        ${acc.full_name}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                <a href="../Grade?action=updateForm&id=${gra.id}" class="btn btn-sm btn-warning">Update</a> 
                                <a href="../Grade?action=delete&id=${gra.id}" 
                                   onclick="return confirm('Are you sure to delete grade ID ${gra.id}?');" 
                                   class="btn btn-sm btn-danger ms-1">Delete</a>
                            </td>               
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <a href="../Grade?action=addForm" class="btn btn-success">Add new Grade</a>

            <c:if test="${not empty message}">
                <div class="alert alert-success mt-3">${message}</div>
            </c:if>
        </div>

        <!-- Bootstrap JS Bundle with Popper (optional, nếu có dùng JS của bootstrap) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
