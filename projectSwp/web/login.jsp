<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Login Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
            }
            .login-container {
                max-width: 400px;
                margin: 50px auto;
                padding: 25px;
                background-color: white;
                box-shadow: 0 0 10px #ccc;
                border-radius: 5px;
            }
            .login-container h2 {
                text-align: center;
                margin-bottom: 25px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                font-weight: bold;
            }
            input[type=text], input[type=password], select {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
            }
            .error {
                color: red;
                margin-bottom: 15px;
                text-align: center;
            }
            .remember-me {
                display: flex;
                align-items: center;
            }
            .remember-me input {
                margin-right: 5px;
            }
            button {
                width: 100%;
                padding: 10px;
                background-color: #3f51b5;
                border: none;
                color: white;
                font-weight: bold;
                cursor: pointer;
                border-radius: 3px;
            }
            button:hover {
                background-color: #303f9f;
            }
        </style>
    </head>
    <body>

        <div class="login-container">
            <h2>Login</h2>

            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="userType">User Type</label>
                    <select name="userType" id="userType" required onchange="toggleInputFields()">
                        <option value="account" ${userType == 'account' ? 'selected' : ''}>Account</option>
                        <option value="student" ${userType == 'student' ? 'selected' : ''}>Student</option>
                    </select>
                </div>

                <div class="form-group" id="emailGroup">
                    <label for="email">Email</label>
                    <input type="text" name="email" id="email"
                           value="${param.email != null ? param.email : (userType == 'account' ? requestScope.email : '')}"
                           placeholder="Enter your email"/>
                </div>

                <div class="form-group" id="usernameGroup" style="display:none;">
                    <label for="username">Username</label>
                    <input type="text" name="username" id="username"
                           value="${param.username != null ? param.username : (userType == 'student' ? requestScope.username : '')}"
                           placeholder="Enter your username"/>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" name="password" id="password"
                           value="${param.password != null ? param.password : ''}" placeholder="Enter your password" required/>
                </div>

                <div class="form-group remember-me">
                    <input type="checkbox" id="remember_me" name="remember_me"
                           ${param.remember_me == 'on' || (cookieRemember == 'on') ? 'checked' : ''}/>
                    <label for="remember_me">Remember me</label>
                </div>

                <button type="submit">Login</button>
            </form>
        </div>

        <script>
            function toggleInputFields() {
                const userType = document.getElementById('userType').value;
                if (userType === 'account') {
                    document.getElementById('emailGroup').style.display = 'block';
                    document.getElementById('usernameGroup').style.display = 'none';
                } else {
                    document.getElementById('emailGroup').style.display = 'none';
                    document.getElementById('usernameGroup').style.display = 'block';
                }
            }

            // Khởi động ban đầu để ẩn hiện đúng
            toggleInputFields();
        </script>

    </body>
</html>
