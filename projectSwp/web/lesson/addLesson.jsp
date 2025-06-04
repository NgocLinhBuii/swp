<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm bài học</title>
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
            padding: 0;
        }

        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color: #f8f9fa;
        }

        main {
            flex: 1;
            padding-top: 80px; /* tránh header che nội dung */
        }

        footer {
            background: #343a40;
            color: white;
            padding: 10px 0;
            text-align: center;
        }

        .card {
            margin-bottom: 40px;
        }
    </style>
</head>
<body>

    <jsp:include page="/lesson/header.jsp" />

    <main>
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow-sm">
                        <div class="card-header bg-success text-white text-center">
                            <h5 class="mb-0">Thêm Bài Học Mới</h5>
                        </div>
                        <div class="card-body">
                            <form id="lessonForm" action="LessonURL" method="post" onsubmit="return validateForm()">
                                <input type="hidden" name="action" value="insert">

                                <div class="mb-3">
                                    <label for="name" class="form-label">Tên bài học</label>
                                    <input type="text" class="form-control" id="name" name="name">
                                    <div id="nameError" class="text-danger"></div>
                                </div>

                                <div class="mb-3">
                                    <label for="content" class="form-label">Nội dung</label>
                                    <textarea class="form-control" id="content" name="content" rows="4"></textarea>
                                    <div id="contentError" class="text-danger"></div>
                                </div>

                                <div class="mb-3">
                                    <label for="chapter_id" class="form-label">Chapter</label>
                                    <select class="form-select nice-select wide" id="chapter_id" name="chapter_id">
                                        <option value="">-- Chọn Chapter --</option>
                                        <c:forEach items="${chapterName}" var="chapter">
                                            <option value="${chapter.id}">${chapter.name}</option>
                                        </c:forEach>
                                    </select>
                                    <div id="chapterError" class="text-danger"></div>
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-success">Thêm bài học</button>
                                    <a href="LessonURL" class="btn btn-outline-secondary">Quay lại danh sách</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

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
    <!-- JavaScript -->
    <script>
        function validateForm() {
            let isValid = true;
            document.getElementById("nameError").innerText = "";
            document.getElementById("contentError").innerText = "";
            document.getElementById("chapterError").innerText = "";

            const name = document.getElementById("name").value.trim();
            const content = document.getElementById("content").value.trim();
            const chapter = document.getElementById("chapter_id").value;

            if (name === "") {
                document.getElementById("nameError").innerText = "Vui lòng nhập tên bài học.";
                isValid = false;
            }

            if (content === "") {
                document.getElementById("contentError").innerText = "Vui lòng nhập nội dung.";
                isValid = false;
            }

            if (chapter === "") {
                document.getElementById("chapterError").innerText = "Vui lòng chọn một chapter.";
                isValid = false;
            }

            return isValid;
        }
    </script>

 
    <script>
        $(document).ready(function () {
            $('select').niceSelect();
        });
    </script>
</body>
</html>
