<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Làm bài - ${test.name}</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="manifest" href="site.webmanifest">
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">

    <!-- CSS here -->
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
        .test-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        
        .question-container {
            background: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            border-left: 4px solid #ccc;
        }
        
        .question-container.answered {
            border-left: 4px solid #28a745;
        }
        
        .question-container.unanswered {
            border-left: 4px solid #dc3545;
        }
        
        .question-number {
            background: #007bff;
            color: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-bottom: 20px;
        }
        
        .question-text {
            font-size: 1.1em;
            color: #333;
            margin-bottom: 25px;
            line-height: 1.6;
        }
        
        .option-container {
            margin-bottom: 15px;
        }
        
        .option-label {
            display: block;
            padding: 15px 20px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }
        
        .option-label:hover {
            border-color: #007bff;
            background: #e3f2fd;
        }
        
        .option-input:checked + .option-label {
            border-color: #007bff;
            background: #007bff;
            color: white;
        }
        
        .option-input {
            display: none;
        }
        
        .progress-container {
            margin-bottom: 20px;
        }
        
        .btn-navigation {
            min-width: 120px;
        }
        
        .question-image {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin: 20px 0;
        }
        
        .test-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .badge-practice {
            background-color: #28a745;
        }
        
        .badge-official {
            background-color: #dc3545;
        }
        
        /* Styles for timer */
        .timer-container {
            position: fixed;
            top: 90px; /* Below the header */
            right: 20px;
            background: white;
            border-radius: 8px;
            padding: 10px 15px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.2);
            z-index: 999;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-width: 150px;
        }
        
        .timer-label {
            font-size: 0.9em;
            color: #666;
            margin-bottom: 5px;
        }
        
        .timer-display {
            font-size: 1.5em;
            font-weight: bold;
            color: #333;
        }
        
        .timer-warning {
            color: #dc3545;
            animation: blink 1s infinite;
        }
        
        @keyframes blink {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }
    </style>
    
    <!-- Truyền dữ liệu JSP vào JavaScript -->
    <script>
        // Khai báo biến từ dữ liệu JSP - đã chuyển sang String ở controller
        var TOTAL_QUESTIONS = parseInt("${totalQuestions}");
        var TEST_DURATION = parseInt("${duration}"); // phút
        var TEST_START_TIME = parseInt("${startTime}"); // milliseconds
        var IS_PRACTICE = ${isPractice}; // boolean: true nếu là bài luyện tập
        
        // Ghi log để debug
        console.log("TOTAL_QUESTIONS:", TOTAL_QUESTIONS);
        console.log("TEST_DURATION:", TEST_DURATION, "phút");
        console.log("TEST_START_TIME:", TEST_START_TIME, "->", new Date(TEST_START_TIME));
        console.log("IS_PRACTICE:", IS_PRACTICE);
    </script>
</head>
<body>

<main>
    <section class="container mt-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb" class="mb-4">
            <div class="d-flex align-items-center justify-content-between">
                <a href="/student/taketest" class="btn btn-outline-secondary">
                    « Quay lại
                </a>
                <h4 class="m-0 font-weight-bold text-center flex-grow-1">${test.name}</h4>
                <div style="width: 85px;"></div> <!-- Spacer for balance -->
            </div>
        </nav>
        
        <!-- Timer - Chỉ hiển thị cho bài test thực sự -->
        <c:if test="${not isPractice}">
            <div class="timer-container">
                <div class="timer-label">Thời gian còn lại</div>
                <div id="timer" class="timer-display">--:--</div>
            </div>
        </c:if>
        
        <!-- Test Header -->
        <div class="test-header">
            <div class="test-info">
                <div>
                    <h3 class="mb-1">${test.name}</h3>
                    <p class="mb-0">${test.description}</p>
                </div>
                <div>
                    <c:choose>
                        <c:when test="${test.is_practice}">
                            <span class="badge badge-practice badge-lg">Practice</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-official badge-lg">Official Test</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        
        <!-- Error message if exists -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                ${error}
            </div>
        </c:if>
        
        <!-- Progress Bar -->
        <div class="progress-container">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <small class="text-muted">Tiến độ hoàn thành</small>
                <small class="text-muted">
                    Đã trả lời: <span id="answeredCount">0</span> / ${totalQuestions}
                </small>
            </div>
            <div class="progress">
                <div class="progress-bar" role="progressbar" 
                     style="width: 0%"
                     id="progressBar"
                     aria-valuenow="0" 
                     aria-valuemin="0" 
                     aria-valuemax="${totalQuestions}">
                </div>
            </div>
        </div>
        
        <!-- All Questions -->
        <form method="post" action="${pageContext.request.contextPath}/student/taketest" id="allQuestionsForm">
            <input type="hidden" name="action" value="submit">
            
            <c:forEach var="question" items="${questions}" varStatus="qStatus">
                <div class="question-container" id="question-${question.id}">
                    <div class="question-number">
                        ${qStatus.index + 1}
                    </div>
                    
                    <div class="question-text">
                        ${question.question}
                    </div>
                    
                    <!-- Question Image (if exists) -->
                    <c:if test="${question.image_id != null && question.image_id > 0}">
                        <img src="${pageContext.request.contextPath}/image/${question.image_id}" 
                             alt="Question Image" class="question-image">
                    </c:if>
                    
                    <!-- Options -->
                    <input type="hidden" name="questionId${qStatus.index}" value="${question.id}">
                    
                    <c:forEach var="option" items="${allOptions[question.id]}" varStatus="oStatus">
                        <div class="option-container">
                            <input type="radio" 
                                   id="option_${question.id}_${option.id}" 
                                   name="optionId${qStatus.index}" 
                                   value="${option.id}"
                                   class="option-input"
                                   data-question-id="${question.id}"
                                   onclick="updateQuestionStatus(${question.id})"
                                   ${previousAnswers[question.id] == option.id ? 'checked' : ''}>
                            <label for="option_${question.id}_${option.id}" class="option-label">
                                <strong>${oStatus.index + 1}.</strong> ${option.content}
                            </label>
                        </div>
                    </c:forEach>
                </div>
            </c:forEach>
            
            <!-- Submit Button -->
            <div class="d-flex justify-content-center mt-4 mb-5">
                <button type="button" class="btn btn-success btn-lg px-5" onclick="validateAndSubmit()">
                    <i class="fa fa-check"></i> Hoàn thành bài làm
                </button>
            </div>
        </form>
    </section>
</main>
<%@include file="../footer.jsp" %>

<!-- JS Libraries -->
<script src="${pageContext.request.contextPath}/assets/js/vendor/jquery-1.12.4.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>

<!-- Custom Script -->
<script>
// Cập nhật trạng thái của từng câu hỏi (đã trả lời hay chưa)
function updateQuestionStatus(questionId) {
    var container = document.getElementById('question-' + questionId);
    container.classList.remove('unanswered');
    container.classList.add('answered');
    
    updateProgress();
}

// Cập nhật thanh tiến độ
function updateProgress() {
    var answeredQuestions = document.querySelectorAll('input[type="radio"]:checked').length;
    
    document.getElementById('answeredCount').textContent = answeredQuestions;
    var progressPercent = (answeredQuestions / TOTAL_QUESTIONS) * 100;
    
    var progressBar = document.getElementById('progressBar');
    progressBar.style.width = progressPercent + '%';
    progressBar.setAttribute('aria-valuenow', answeredQuestions);
}

// Kiểm tra và nộp bài
function validateAndSubmit() {
    var answeredQuestions = document.querySelectorAll('input[type="radio"]:checked').length;
    
    if (answeredQuestions < TOTAL_QUESTIONS) {
        alert('Bạn chưa trả lời tất cả câu hỏi. Vui lòng trả lời đủ ' + TOTAL_QUESTIONS + ' câu hỏi trước khi nộp bài.');
        
        // Cuộn đến câu hỏi đầu tiên chưa trả lời
        var unansweredContainers = document.querySelectorAll('.question-container:not(.answered)');
        if (unansweredContainers.length > 0) {
            unansweredContainers[0].scrollIntoView({ behavior: 'smooth' });
        }
        
        return false;
    }
    
    if (confirm('Bạn có chắc chắn muốn nộp bài không?')) {
        document.getElementById('allQuestionsForm').submit();
    }
}

// Khởi tạo trạng thái câu hỏi khi tải trang
document.addEventListener('DOMContentLoaded', function() {
    var questions = document.querySelectorAll('.question-container');
    
    questions.forEach(function(container) {
        var questionId = container.id.split('-')[1];
        var answered = container.querySelector('input[type="radio"]:checked') !== null;
        
        if (answered) {
            container.classList.add('answered');
            container.classList.remove('unanswered');
        } else {
            container.classList.add('unanswered');
            container.classList.remove('answered');
        }
    });
    
    updateProgress();
    
    // Khởi tạo đồng hồ đếm ngược
    initializeTimer();
});

// Biến toàn cục cho đồng hồ
let timerInterval;
let remainingTime;

// Khởi tạo đồng hồ đếm ngược
function initializeTimer() {
    // Nếu là bài luyện tập, không cần đồng hồ
    if (IS_PRACTICE) {
        console.log("Bài test luyện tập - không cần đồng hồ đếm ngược");
        return;
    }
    
    // Kiểm tra các giá trị đầu vào
    if (isNaN(TEST_DURATION) || TEST_DURATION <= 0) {
        console.log("TEST_DURATION không hợp lệ:", TEST_DURATION, "- đặt thành 60 phút");
        TEST_DURATION = 60; // Mặc định 60 phút
    }
    
    if (isNaN(TEST_START_TIME) || TEST_START_TIME <= 0) {
        console.log("TEST_START_TIME không hợp lệ:", TEST_START_TIME, "- đặt thành thời gian hiện tại");
        TEST_START_TIME = new Date().getTime();
    }
    
    var currentTime = new Date().getTime();
    
    // Tính toán thời gian còn lại (milliseconds)
    var elapsedTime = currentTime - TEST_START_TIME;
    var totalTime = TEST_DURATION * 60 * 1000; // Chuyển phút thành milliseconds
    
    console.log("Thời gian tổng cộng:", totalTime / 60000, "phút");
    console.log("Thời gian đã trôi qua:", elapsedTime / 60000, "phút");
    
    // Bảo vệ khỏi giá trị duration = 0 hoặc âm
    if (TEST_DURATION <= 0) {
        console.log("Thời gian làm bài không hợp lệ: " + TEST_DURATION + " phút. Đặt thành 60 phút mặc định.");
        remainingTime = 60 * 60 * 1000; // Mặc định 60 phút nếu duration <= 0
    } else {
        remainingTime = totalTime - elapsedTime;
        
        // Bảo vệ khỏi trường hợp remainingTime âm
        if (remainingTime <= 0) {
            // Thời gian không hợp lệ, đặt lại thành giá trị mặc định (toàn bộ thời gian)
            console.log("Thời gian còn lại không hợp lệ: " + remainingTime / 60000 + " phút. Đặt lại thời gian bắt đầu.");
            remainingTime = totalTime;
        }
    }
    
    console.log("Thời gian còn lại:", remainingTime / 60000, "phút");
    
    // Cập nhật đồng hồ mỗi giây
    updateTimerDisplay();
    timerInterval = setInterval(updateTimerDisplay, 1000);
}

// Cập nhật hiển thị đồng hồ
function updateTimerDisplay() {
    // Giảm thời gian còn lại đi 1 giây
    remainingTime -= 1000;
    
    // Nếu thời gian đã hết, tự động nộp bài
    if (remainingTime <= 0) {
        clearInterval(timerInterval);
        autoSubmitDueToTimeout();
        return;
    }
    
    // Tính toán phút và giây
    var minutes = Math.floor(remainingTime / (60 * 1000));
    var seconds = Math.floor((remainingTime % (60 * 1000)) / 1000);
    
    // Format: MM:SS (đảm bảo luôn có 2 chữ số)
    var minutesStr = (minutes < 10) ? "0" + minutes : minutes.toString();
    var secondsStr = (seconds < 10) ? "0" + seconds : seconds.toString();
    var timeString = minutesStr + ":" + secondsStr;
    
    // Hiển thị thời gian
    var timerElement = document.getElementById('timer');
    if (timerElement) {
        timerElement.textContent = timeString;
        
        // Thêm hiệu ứng cảnh báo khi thời gian còn ít (dưới 5 phút)
        if (remainingTime < 5 * 60 * 1000) {
            timerElement.classList.add('timer-warning');
        }
    } else {
        console.error("Không tìm thấy phần tử timer!");
        clearInterval(timerInterval);
    }
}

// Tự động nộp bài khi hết thời gian
function autoSubmitDueToTimeout() {
    // Nếu là bài luyện tập, không cần nộp tự động
    if (IS_PRACTICE) {
        return;
    }
    
    // Hiển thị thông báo
    var timerElement = document.getElementById('timer');
    if (timerElement) {
        timerElement.textContent = "00:00";
        timerElement.classList.add('timer-warning');
    }
    
    // Thông báo cho người dùng
    alert('Hết thời gian làm bài! Bài làm của bạn sẽ được tự động nộp.');
    
    // Nộp form
    document.getElementById('allQuestionsForm').submit();
}
</script>
</body>
</html>