<%-- 
    Document   : accountForm
    Created on : May 23, 2025, 11:16:10 AM
    Author     : BuiNgocLinh
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title><c:choose>
                <c:when test="${not empty account}">Edit</c:when>
                <c:otherwise>Add</c:otherwise>
            </c:choose>
        </title>
    </head>
    <body>
        <h2><c:choose>
                <c:when test="${not empty account}">Edit</c:when>
                <c:otherwise>Add</c:otherwise>
            </c:choose></h2>

        <c:if test="${not empty error}">
            <div style="color:red">${error}</div>
        </c:if>

        <form action="admin" method="post" enctype="multipart/form-data">
            <c:if test="${not empty account}">
                <input type="hidden" name="id" value="${account.id}"/>
                <input type="hidden" name="action" value="editAccount"/>
            </c:if>
            <c:if test="${empty account}">
                <input type="hidden" name="action" value="createAccount"/>
            </c:if>

            <label>Email:</label><br/>
            <input type="email" name="email" value="${account.email}" required/><br/>

            <label>Password:</label><br/>
            <input type="password" name="password" value="${account.password}" required/><br/>

            <label>Full Name:</label><br/>
            <input type="text" name="full_name" value="${account.full_name}" required/><br/>

            <label>Role:</label><br/>
            <input type="text" name="role" value="${account.role}" required/><br/>

            <label>Status:</label><br/>
            <input type="text" name="status" value="${account.status}" required/><br/>

            <label>Sex:</label><br/>
            <select name="sex" required>
                <option value="">--Sex--</option>
                <option value="0" ${account.sex == 0 ? "selected" : ""}>Nam</option>
                <option value="1" ${account.sex == 1 ? "selected" : ""}>Nữ</option>
            </select><br/>

            <label>Ngày sinh:</label><br/>
            <input type="date" name="dob" value="${account.dob}" /><br/>
            <c:if test="${image.id == account.image_id}">
                <div class="mb-3">
                    <label class="form-label">Avatar:</label><br/>
                    <img src="${pageContext.request.contextPath}/${not empty image.image_data ? image.image_data : 'assets/img/avatar/macdinh.jpg'}"
                         alt="Ảnh cá nhân" width="200" height="200"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">New avatar:</label>
                    <input type="file" name="imgURL" class="form-control"/>
                </div>
            </c:if>

            <button type="submit">submit</button>
            <a href="admin?action=listAccount">Back</a>
        </form>

    </body>
</html>
