<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Cập nhật bài học</title>
    <meta charset="UTF-8">

    <!-- Bootstrap & Style -->
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
            height: 100%;
            margin: 0;
        }

        .page-wrapper {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            padding-top: 80px; /* tránh header che nội dung */
        }

        main {
            flex: 1;
        }

        footer {
            flex-shrink: 0;
        }
    </style>
</head>
<body class="bg-light">

<div class="page-wrapper">
    <jsp:include page="/lesson/header.jsp" />

    <main class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm">
                    <div class="card-header bg-warning text-dark text-center">
                        <h5 class="mb-0">Cập nhật bài học</h5>
                    </div>
                    <div class="card-body">
                        <form action="LessonURL" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${lesson.id}">

                            <div class="mb-3">
                                <label for="name" class="form-label">Tên bài học</label>
                                <input type="text" id="name" name="name" class="form-control" value="${lesson.name}" required>
                            </div>

                            <div class="mb-3">
                                <label for="content" class="form-label">Nội dung</label>
                                <textarea id="content" name="content" class="form-control" rows="4" required>${lesson.content}</textarea>
                            </div>

                            <div class="mb-3">
                                <label for="chapter_id" class="form-label">Chapter</label>
                                <select name="chapter_id" id="chapter_id" class="form-select nice-select" required>
                                    <c:forEach items="${chapter}" var="chap">
                                        <option value="${chap.id}" ${lesson.chapter_id == chap.id ? 'selected' : ''}>
                                            ${chap.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-warning">Cập nhật</button>
                                <a href="LessonURL" class="btn btn-outline-secondary">Quay lại danh sách</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

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
</div>

<!-- JS Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="/assets/js/jquery-1.12.4.min.js"></script>
<script src="/assets/js/jquery.nice-select.min.js"></script>
<script>
    $(document).ready(function () {
        $('select').niceSelect();
    });
</script>
</body>
</html>
