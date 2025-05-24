<%-- 
    Document   : profileAccount
    Created on : May 23, 2025, 3:06:45 PM
    Author     : BuiNgocLinh
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>My profile</title>
    </head>
    <body>
        <h2>My profile</h2>
        <table border="1">
            <tr><td>Name:</td><td>${view.full_name}</td></tr>
            <tr><td>Email:</td><td>${view.email}</td></tr>
            <tr><td>Sex:</td><td>
                    <c:choose>
                        <c:when test="${view.sex == 1}">Male</c:when>
                        <c:when test="${view.sex == 0}">Female</c:when>
                        <c:otherwise>null</c:otherwise>
                    </c:choose>
                </td></tr>
            <tr><td>DOB:</td><td>${view.dob}</td></tr>
            <tr><td>Role:</td><td>${view.role}</td></tr>
            <tr><td>Status:</td><td>${view.status}</td></tr>
            <tr><td>Avatar:</td>
                <td>
                    <c:forEach items="${imageList}" var="i">
                        <c:if test="${i.id == view.image_id}">
                            <img src="${pageContext.request.contextPath}/${not empty i.image_data ? i.image_data : 'assets/img/avatar/macdinh.jpg'}"
                                 alt="Ảnh cá nhân" width="200" height="200"/>
                        </c:if>
                    </c:forEach>
                </td>
            </tr>
        </table>
    </body>
</html>
