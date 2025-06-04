<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Category</title>

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
            padding: 0;
            height: 100%;
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
        }

        .page-wrapper {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            padding-top: 80px; /* tránh header che */
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

        form {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            max-width: 500px;
            margin: auto;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
        }

        label {
            margin-top: 10px;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 8px;
            margin-top: 4px;
            margin-bottom: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            padding: 8px 16px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 4px;
        }

        a {
            display: block;
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="page-wrapper">
    <jsp:include page="/Subject/header.jsp" />
    <main>
        <h2 style="text-align:center;">Add New Category</h2>

        <form method="post" action="category">
            <input type="hidden" name="action" value="insert" />
            
            <label for="name">Name:</label>
            <input type="text" name="name" id="name" required />

            <label for="num_question">Number of Questions:</label>
            <input type="number" name="num_question" id="num_question" min="1" required />

            <label for="duration">Duration (minutes):</label>
            <input type="number" name="duration" id="duration" min="1" required />

            <button type="submit">Add Category</button>
        </form>

        <a href="category">← Back to Category List</a>
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
