<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Question List</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="assets/css/style.css" />

        <style>
            th, td {
                vertical-align: middle;
                text-align: center;
            }
            img.img-thumbnail {
                object-fit: cover;
            }
        </style>
    </head>

    <body class="bg-light">
        <!-- Include header -->
        <jsp:include page="/header.jsp" />

        <div class="container mt-5 mb-5">
            <h2 class="mb-4">Question List</h2>

            <form method="get" action="Question" class="mb-4 d-flex gap-2">
                <input type="text" name="question" class="form-control w-25" placeholder="Search by question..." />
                <button type="submit" class="btn btn-primary">Search</button>
            </form>

            <table class="table table-bordered table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Question</th>
                        <th>Image</th>
                        <th>Lesson Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="q" items="${questionList}">
                        <tr>
                            <td>${q.id}</td>
                            <td>${q.question}</td>
                            <td>
                                <c:forEach var="img" items="${images}">
                                    <c:if test="${img.id == q.image_id}">
                                        <img src="data:image/jpg;base64, ${img.image_data}" alt="Ảnh câu hỏi" width="100" height="100" class="img-thumbnail">
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                <c:forEach var="l" items="${les}">
                                    <c:if test="${q.lesson_id eq l.id}">
                                        ${l.name}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                <a href="Question?action=updateForm&id=${q.id}" class="btn btn-sm btn-warning">Edit</a>
                                <a href="Question?action=delete&id=${q.id}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?');">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <a href="Question?action=addForm" class="btn btn-success mt-3">Add New Question</a>
        </div>

        <!-- Include footer -->
        <jsp:include page="/footer.jsp" />

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
