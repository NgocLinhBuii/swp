<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Category List</title>

    <!-- CSS Libraries -->
    <link rel="stylesheet" href="/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="/assets/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/assets/css/slicknav.css">
    <link rel="stylesheet" href="/assets/css/flaticon.css">
    <link rel="stylesheet" href="/assets/css/progressbar_barfiller.css">
    <link rel="stylesheet" href="/assets/css/gijgo.css">
    <link rel="stylesheet" href="/assets/css/animate.min.css">
    <link rel="stylesheet" href="/assets/css/animated-headline.css">
    <link rel="stylesheet" href="/assets/css/magnific-popup.css">
    <link rel="stylesheet" href="/assets/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="/assets/css/themify-icons.css">
    <link rel="stylesheet" href="/assets/css/slick.css">
    <link rel="stylesheet" href="/assets/css/nice-select.css">
    <link rel="stylesheet" href="/assets/css/style.css">

    <style>
        html, body {
            margin: 0;
            padding-top:  30px;
            height: 100%;
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
        }

        .page-wrapper {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            padding-top: 80px; /* tránh bị header che */
        }

        main {
            flex: 1;
            padding: 20px;
        }

        footer {
            background-color: #f1f1f1;
            padding: 10px 20px;
            text-align: center;
            font-size: 14px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }

        h2 {
            margin-top: 0;
        }
    </style>
</head>
<body>
<div class="page-wrapper">
    <jsp:include page="/Subject/header.jsp" />
    <main>
        <h2>Category List</h2>

        <form method="get" action="category">
            Search by name: <input type="text" name="name" />
            <button type="submit" class="btn btn-primary btn-sm">Search</button>
        </form>

        <c:if test="${not empty error}">
            <p style="color:red">${error}</p>
        </c:if>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Number of Questions</th>
                    <th>Duration (minutes)</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="cate" items="${categoryList}">
                    <tr>
                        <td>${cate.id}</td>
                        <td>${cate.name}</td>
                        <td>${cate.num_question}</td>
                        <td>${cate.duration}</td>
                        <td>
                            <a href="category?action=updateForm&id=${cate.id}">Update</a> |
                            <a href="category?action=delete&id=${cate.id}"
                               onclick="return confirm('Are you sure to delete category ID ${cate.id}?');"
                               style="color:red">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <br/>
        <a href="category?action=addForm" class="btn btn-success btn-sm">Add new Category</a>

        <c:if test="${not empty message}">
            <p style="color:green">${message}</p>
        </c:if>
    </main>
    <jsp:include page="/Subject/footer.jsp" />
</div>

<!-- JS Libraries -->
<script src="${pageContext.request.contextPath}/assets/js/vendor/modernizr-3.5.0.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/vendor/jquery-1.12.4.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.slicknav.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/slick.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/wow.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/animated.headline.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.magnific-popup.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/gijgo.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.nice-select.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.sticky.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.barfiller.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.counterup.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/waypoints.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.countdown.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/hover-direction-snake.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/contact.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.form.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/mail-script.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.ajaxchimp.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/plugins.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
