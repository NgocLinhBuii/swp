<%-- 
    Document   : list
    Created on : May 21, 2025, 11:29:52 PM
    Author     : BuiNgocLinh
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Student List</title>
    </head>
    <body>

        <h2>Student List</h2>

        <a href="student?action=create"> Insert Student </a>

        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <th>ID</th>
                <th>Grade Name</th>
                <th>Image</th>
                <th>Full Name</th>
                <th>Parent Name</th>
                <th>Username</th>
                <th>DOB</th>
                <th>Sex</th>

                <th>Actions</th>
            </tr>

            <c:forEach var="s" items="${students}">
                <tr>
                    <td>${s.id}</td>
                    <c:forEach items="${gradeList}" var="g">
                        <c:if test="${s.grade_id == g.id}">
                            <td>${g.name}</td>
                        </c:if>
                    </c:forEach>
                    <td>
                        <c:forEach items="${imageList}" var="i">
                            <c:if test="${i.id == s.image_id}">
                                <img src="${pageContext.request.contextPath}/${not empty i.image_data ? i.image_data : 'assets/img/avatar/macdinh.jpg'}"
                                     alt="Ảnh cá nhân" width="200" height="200"/>
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>${s.full_name}</td>
                    <c:forEach items="${accList}" var="a">
                        <c:if test="${a.id == s.parent_id}">
                            <td>${a.full_name}</td>
                        </c:if>
                    </c:forEach>
                    <td>${s.username}</td>
                    <td>${s.dob}</td>
                    <td>
                        <c:choose>
                            <c:when test="${s.sex}">Male</c:when>
                            <c:otherwise>Female</c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <a href="student?action=edit&id=${s.id}">edit</a> |
                        <a href="student?action=delete&id=${s.id}" onclick="return confirm('Delete?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>

    </body>
</html>

