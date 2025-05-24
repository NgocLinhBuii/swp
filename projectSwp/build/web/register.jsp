<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Đăng ký tài khoản</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="mb-4">Register</h2>

            <form action="admin" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="createAccount"/>

                <div class="mb-3">
                    <label class="form-label">Email:</label>
                    <input type="email" name="email" class="form-control" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Pass:</label>
                    <input type="password" name="password" class="form-control" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Name:</label>
                    <input type="text" name="full_name" class="form-control"/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Sex:</label><br/>
                    <input type="radio" name="sex" value="1"/> Nam
                    <input type="radio" name="sex" value="0"/> Nữ
                </div>

                <div class="mb-3">
                    <label class="form-label">Dob:</label>
                    <input type="date" name="dob" class="form-control"/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Role:</label>
                    <select name="role" class="form-select">
                        <option value="student">Student</option>
                        <option value="teacher">Teacher</option>
                        <option value="parent">Parent</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Status:</label>
                    <select name="status" class="form-select">
                        <option value="active">Active</option>
                        <option value="inactive">Inactive</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Avatar:</label>
                    <input type="file" name="imgURL" class="form-control"/>
                </div>

                <button type="submit" class="btn btn-primary">Register</button>
            </form>

            <c:if test="${not empty error}">
                <div class="alert alert-danger mt-3">${error}</div>
            </c:if>
        </div>
    </body>
</html>
