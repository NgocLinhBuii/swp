<%-- 
    Document   : form
    Created on : May 21, 2025, 11:30:09 PM
    Author     : BuiNgocLinh
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>${student == null ? "Add student" : "Edit Student"}</title>
    </head>
    <body>

        <h2>${student == null ? "Add student" : "Edit Student"}</h2>

        <form action="student" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="${student == null ? "create" : "edit"}" />

            ID: <input type="text" name="id" value="${student.id}" ${student != null ? "readonly" : ""} required/><br/>
            Grade ID: <input type="text" name="grade_id" value="${student.grade_id}" required/><br/>
            Parent ID: <input type="text" name="parent_id" value="${student.parent_id}" required/><br/>
            Username: <input type="text" name="username" value="${student.username}" required/><br/>
            Password: <input type="password" name="password" value="${student.password}" required/><br/>
            Full Name: <input type="text" name="full_name" value="${student.full_name}" required/><br/>
            DOB: <input type="date" name="dob" value="${student.dob}" required/><br/>

            Sex:
            <select name="sex">
                <option value="true" ${student.sex ? "selected" : ""}>Male</option>
                <option value="false" ${!student.sex ? "selected" : ""}>Female</option>
            </select><br/>

            <c:if test="${image.id == student.image_id}">
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
            <input type="submit" value="${student == null ? "Add" : "update"}"/>
            <a href="student">Back</a>
        </form>

    </body>
</html>

