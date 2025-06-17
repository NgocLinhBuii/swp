<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý bài Test - Admin</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
                background: #f9f9f9;
                padding-top: 80px;
            }
            .container {
                /*background: #fff;*/
                /*border-radius: 10px;*/
                /*box-shadow: 0 2px 8px rgba(0,0,0,0.1);*/
                padding: 30px;
                margin-top: 30px;
            }
            h2 {
                color: #333;
                border-bottom: 2px solid #007BFF;
                padding-bottom: 8px;
                margin-bottom: 20px;
            }
            .add-link {
                margin-bottom: 15px;
                display: inline-block;
                background: #007BFF;
                color: #fff;
                padding: 8px 16px;
                border-radius: 4px;
                text-decoration: none;
            }
            .add-link:hover {
                background: #0056b3;
            }
            table {
                width: 100%;
                margin-top: 20px;
            }
            th, td {
                text-align: left;
                padding: 10px;
            }
            th {
                background: #007BFF;
                color: #fff;
            }
            tr:nth-child(even) {
                background: #f2f2f2;
            }
            .action-link {
                margin-right: 8px;
            }
            .alert {
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="../header.jsp" />
        <div class="container">
            <h2>Quản lý bài Test - Admin</h2>

            <!-- Success message -->
            <c:if test="${not empty message}">
                <div class="alert alert-success" role="alert">
                    ${message}
                </div>
            </c:if>

            <!-- Error message -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>

            <a class="add-link" href="${pageContext.request.contextPath}/test?action=create">Thêm mới Test</a>
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Mô tả</th>
                        <th>Loại</th>
                        <th>Danh mục</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="test" items="${testList}">
                        <tr>
                            <td>${test.id}</td>
                            <td>${test.name}</td>
                            <td>${test.description}</td>
                            <td><c:choose><c:when test="${test.is_practice}">Practice</c:when><c:otherwise>Official</c:otherwise></c:choose></td>
                            <td>${categoryMap[test.category_id]}</td>
                            <td>
                                <a class="action-link btn btn-sm btn-warning" href="${pageContext.request.contextPath}/test?action=edit&id=${test.id}">Sửa</a>
                                <a class="action-link btn btn-sm btn-danger" href="${pageContext.request.contextPath}/test?action=delete&id=${test.id}" onclick="return confirm('Bạn chắc chắn muốn xoá?');">Xoá</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <jsp:include page="../footer.jsp" />
        <!-- JS -->
        <!-- JS -->
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
        <script>
                                    $(document).ready(function () {
                                        $('select').niceSelect();
                                    });
        </script>
    </body>
</html> 