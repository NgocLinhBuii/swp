<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Login Page</title>
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">

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
                        <option value="teacher" ${userType == 'teacher' ? 'selected' : ''}>Teacher</option>
                        <option value="admin" ${userType == 'admin' ? 'selected' : ''}>Admin</option>
                        <option value="parent" ${userType == 'parent' ? 'selected' : ''}>Parent</option>
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
                <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid
                   &redirect_uri=http://localhost:9999/login
                   &response_type=code
                   &client_id=118450184719-78co4nrqe55ud7rmnl6bn0h2plkavhrg.apps.googleusercontent.com
                   &approval_prompt=force" class="btn btn-lg btn-danger" >
                    <svg xmlns="http://www.w3.org/2000/svg" width="132" height="25" fill="currentColor">
                    <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z" />
                    </svg>
                    <span class="">Sign in with Google</span>
                </a>
                <button type="submit">Login</button>

                <a href="/register.jsp" class="btn btn3">Register</a>

            </form>
        </div>

        <script>
            function toggleInputFields() {
                const userType = document.getElementById('userType').value;
                if (userType === 'student') {
                    document.getElementById('emailGroup').style.display = 'none';
                    document.getElementById('usernameGroup').style.display = 'block';
                } else {
                    document.getElementById('emailGroup').style.display = 'block';
                    document.getElementById('usernameGroup').style.display = 'none';
                }
            }

            // Khởi động ban đầu để ẩn hiện đúng
            toggleInputFields();
        </script>

    </body>
</html>
