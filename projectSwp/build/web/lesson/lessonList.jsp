<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách bài học</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap & style -->
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
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
            background-color: #f8f9fa;
        }
        main {
            flex: 1;
        }
        footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 12px 0;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <jsp:include page="/lesson/header.jsp" />

    <!-- Main Content -->
    <main class="container my-4">
        <h2 class="mb-4 text-primary">Danh sách bài học</h2>

        <!-- Search -->
        <form method="get" action="LessonURL" class="row g-2 mb-3">
            <div class="col-auto">
                <input type="text" name="name" class="form-control" placeholder="Tìm theo tên">
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-primary">Tìm</button>
            </div>
        </form>

        <!-- Alerts -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <!-- Add New -->
        <div class="mb-3">
            <a href="LessonURL?action=addForm" class="btn btn-success">Thêm bài học mới</a>
        </div>

        <!-- Table -->
        <table class="table table-bordered table-hover bg-white">
            <thead class="table-primary">
                <tr>
                    <th>ID</th>
                    <th>Tên</th>
                    <th>Nội dung</th>
                    <th>Chapter</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="lesson" items="${lessonList}">
                    <tr>
                        <td>${lesson.id}</td>
                        <td>${lesson.name}</td>
                        <td>${lesson.content}</td>
                        <td>
                            <c:forEach var="chap" items="${chapter}">
                                <c:if test="${lesson.chapter_id eq chap.id}">
                                    ${chap.name}
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            <a href="LessonURL?action=updateForm&id=${lesson.id}" class="btn btn-sm btn-warning">Sửa</a>
                            <a href="LessonURL?action=delete&id=${lesson.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </main>

    <!-- Footer -->
    <footer>
        <jsp:include page="/lesson/footer.jsp" />
         <script src="${pageContext.request.contextPath}/assets/js/vendor/modernizr-3.5.0.min.js"></script>
        <!-- Jquery, Popper, Bootstrap -->
        <script src="${pageContext.request.contextPath}/assets/js/vendor/jquery-1.12.4.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
        <!-- Jquery Mobile Menu -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery.slicknav.min.js"></script>

        <!-- Jquery Slick , Owl-Carousel Plugins -->
        <script src="${pageContext.request.contextPath}/assets/js/owl.carousel.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/slick.min.js"></script>
        <!-- One Page, Animated-HeadLin -->
        <script src="${pageContext.request.contextPath}/assets/js/wow.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/animated.headline.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/jquery.magnific-popup.js"></script>

        <!-- Date Picker -->
        <script src="${pageContext.request.contextPath}/assets/js/gijgo.min.js"></script>
        <!-- Nice-select, sticky -->
       
        <!-- Progress -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery.barfiller.js"></script>

        <!-- counter , waypoint,Hover Direction -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery.counterup.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/waypoints.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/jquery.countdown.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/hover-direction-snake.min.js"></script>

        <!-- contact js -->
        <script src="${pageContext.request.contextPath}/assets/js/contact.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/jquery.form.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/jquery.validate.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/mail-script.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/jquery.ajaxchimp.min.js"></script>

        <!-- Jquery Plugins, main Jquery -->	
        <script src="${pageContext.request.contextPath}/assets/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
    </footer>

    <!-- JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
